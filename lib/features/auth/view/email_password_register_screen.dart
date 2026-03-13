import 'package:adcc/l10n/app_localizations.dart';
import 'package:adcc/shared/widgets/app_header_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/token_storage_service.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../shared/widgets/app_button.dart';
import '../../home/view/home_screen.dart';
import 'email_password_login_screen.dart';
import 'setup_profile_screen.dart';

class EmailPasswordRegisterScreen extends StatefulWidget {
  const EmailPasswordRegisterScreen({super.key});

  @override
  State<EmailPasswordRegisterScreen> createState() =>
      _EmailPasswordRegisterScreenState();
}

class _EmailPasswordRegisterScreenState
    extends State<EmailPasswordRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _errorDialogShown = false;

  FirebaseAuth get _auth {
    try {
      return FirebaseAuth.instance;
    } catch (e) {
      debugPrint('[Firebase Auth] Firebase not initialized: $e');
      throw Exception('Firebase is not initialized. Please restart the app.');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    setState(() {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isLoading) return;

    try {
      if (Firebase.apps.isEmpty) {
        if (mounted) {
          _showErrorDialog(
              'Firebase is not initialized. Please restart the app.');
        }
        return;
      }
    } catch (e) {
      debugPrint('[Firebase] Check failed: $e');
      if (mounted) {
        _showErrorDialog('Firebase is not available. Please restart the app.');
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('[Firebase Auth] Account created successfully!');

      final user = userCredential.user;
      if (user == null) {
        throw Exception('User credential is null');
      }

      if (!user.emailVerified) {
        try {
          await user.sendEmailVerification();
          debugPrint('[Firebase Auth] Verification email sent.');
        } catch (_) {
          // Non-fatal
        }
      }

      final idToken = await user.getIdToken();
      if (idToken == null || idToken.isEmpty) {
        throw Exception('Failed to get ID token');
      }

      final (backendSuccess, isNewUser) =
          await _sendTokenToBackend(idToken: idToken);

      if (backendSuccess && mounted) {
        if (isNewUser) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const SetupProfileScreen()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already registered. Sign in instead.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak';
      } else {
        errorMessage = e.message ?? 'Registration failed';
      }
      if (mounted) _showErrorDialog(errorMessage);
    } catch (e) {
      if (mounted) {
        _showErrorDialog('An unexpected error occurred: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Returns (success, isNewUser). When isNewUser is true, navigate to SetupProfileScreen.
  Future<(bool, bool)> _sendTokenToBackend({required String idToken}) async {
    _errorDialogShown = false;
    try {
      await TokenStorageService.saveFirebaseToken(idToken);

      final apiClient = ApiClient.instance;
      final response = await apiClient.post<dynamic>(
        ApiEndpoints.authVerify,
        data: {'idToken': idToken},
      );
      debugPrint('response.data: ${response.data}');
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final body = response.data;
        if (body is Map<String, dynamic>) {
          final data = body["data"];
          final isNewUser = data is Map<String, dynamic>
              ? (data["isNewUser"] == true)
              : (body["isNewUser"] == true);

          if (data is Map<String, dynamic>) {
            final user = data["user"];
            if (user is Map<String, dynamic>) {
              final userId = user["id"]?.toString();
              if (userId != null && userId.isNotEmpty) {
                await TokenStorageService.saveUserId(userId);
              }
            }
            if (!isNewUser) {
              final accessToken = data["accessToken"] as String?;
              final refreshToken = data["refreshToken"] as String?;
              if (accessToken != null && accessToken.isNotEmpty) {
                await TokenStorageService.saveAccessToken(accessToken);
              }
              if (refreshToken != null && refreshToken.isNotEmpty) {
                await TokenStorageService.saveRefreshToken(refreshToken);
              }
            }
            return (true, isNewUser);
          }
        }
        return (false, false);
      } else {
        String errorMessage = 'Backend verification failed';
        if (response.data is Map) {
          final errorData = response.data as Map;
          errorMessage = errorData['message'] as String? ??
              errorData['error'] as String? ??
              errorMessage;
        }
        if (mounted && !_errorDialogShown) {
          _errorDialogShown = true;
          _showBackendErrorDialog(errorMessage);
        }
        return (false, false);
      }
    } on DioException catch (e) {
      String errorMessage = 'Backend verification failed';
      if (e.response?.data is Map) {
        final errorData = e.response!.data as Map;
        errorMessage = errorData['message'] as String? ??
            errorData['error'] as String? ??
            errorMessage;
      }
      if (mounted && !_errorDialogShown) {
        _errorDialogShown = true;
        _showBackendErrorDialog(errorMessage);
      }
      return (false, false);
    } catch (e) {
      debugPrint('[Backend API] Error: $e');
      if (mounted && !_errorDialogShown) {
        _errorDialogShown = true;
        _showBackendErrorDialog(
            'An unexpected error occurred. Please try again.');
      }
      return (false, false);
    }
  }

  void _showBackendErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.backendVerificationError),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.authenticationError),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const EmailPasswordLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: Column(
          children: [
            AppHeaderLogin(
              onBack: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/adcc_logo.png',
                          width: 80,
                          height: 80,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.bike_scooter,
                                size: 40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        l10n.community_heading1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.community_heading2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final trimmed = value.trim();
                          if (trimmed.isEmpty) return 'Please enter your email';
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(trimmed)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: l10n.enterYourEmail,
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          hintText: l10n.enterYourPassword,
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                          hintText: l10n.confirmPassword,
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      AppButton(
                        label: l10n.signUp,
                        onPressed: _isLoading ? null : _handleRegister,
                        isLoading: _isLoading,
                        backgroundColor: AppColors.deepRed,
                        textColor: Colors.white,
                        borderRadius: 14,
                        height: 56,
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: _isLoading ? null : _navigateToLogin,
                        child: Text(
                          l10n.login_link,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.deepRed,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
