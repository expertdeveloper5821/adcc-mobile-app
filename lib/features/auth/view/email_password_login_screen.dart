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

class EmailPasswordLoginScreen extends StatefulWidget {
  const EmailPasswordLoginScreen({super.key});

  @override
  State<EmailPasswordLoginScreen> createState() =>
      _EmailPasswordLoginScreenState();
}

class _EmailPasswordLoginScreenState extends State<EmailPasswordLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _errorDialogShown = false; // Prevent showing error dialog multiple times

  // Lazy initialization - only get FirebaseAuth when needed
  FirebaseAuth get _auth {
    try {
      return FirebaseAuth.instance;
    } catch (e) {
      debugPrint('[Firebase Auth] Firebase not initialized: $e');
      throw Exception('Firebase is not initialized. Please restart the app.');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuthAndRedirect();
  }

  /// Check if user is already authenticated and redirect to home
  Future<void> _checkAuthAndRedirect() async {
    final isAuthenticated = await TokenStorageService.isAuthenticated();
    if (isAuthenticated && mounted) {
      // User is already logged in, redirect to home and clear navigation stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false, // Remove all previous routes
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Enable auto-validation after first submit attempt
    setState(() {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isLoading) return;

    // Check if Firebase is initialized
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

    debugPrint('🔐 [Firebase Auth] Starting authentication...');
    debugPrint('📧 [Firebase Auth] Email: $email');
    debugPrint('🔑 [Firebase Auth] Attempting sign in...');

    try {
      UserCredential? userCredential;

      // Try to sign in with credentials
      try {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        debugPrint('[Firebase Auth] Sign in successful!');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          debugPrint(
              '[Firebase Auth] User not found, attempting to create account...');
          // User doesn't exist, try to create account
          userCredential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          debugPrint('[Firebase Auth] Account created successfully!');

          // Send verification email for new accounts
          if (userCredential.user != null &&
              !userCredential.user!.emailVerified) {
            debugPrint('[Firebase Auth] Sending verification email...');
            await userCredential.user!.sendEmailVerification();
            debugPrint('[Firebase Auth] Verification email sent!');
          }
        } else {
          rethrow;
        }
      }

      final user = userCredential.user;
      if (user == null) {
        throw Exception('User credential is null');
      }

      // Log user details
      debugPrint('[Firebase Auth] User ID: ${user.uid}');
      debugPrint(' [Firebase Auth] User Email: ${user.email}');
      debugPrint(' [Firebase Auth] Email Verified: ${user.emailVerified}');
      debugPrint(
          ' [Firebase Auth] Creation Time: ${user.metadata.creationTime}');
      debugPrint(
          ' [Firebase Auth] Last Sign In: ${user.metadata.lastSignInTime}');

      // Reload user to get latest verification status
      await user.reload();
      final reloadedUser = _auth.currentUser;
      final isEmailVerified = reloadedUser?.emailVerified ?? false;

      debugPrint(
          ' [Firebase Auth] Email Verification Status: $isEmailVerified');

      // Get Firebase ID Token
      debugPrint(' [Firebase Auth] Getting ID token...');
      String? idToken;
      try {
        idToken = await user.getIdToken();
        debugPrint(' [Firebase Auth] ID Token retrieved successfully!');
        debugPrint(' [Firebase Auth] ID Token: $idToken');
      } catch (tokenError) {
        debugPrint(' [Firebase Auth] Failed to get ID token: $tokenError');
        throw Exception('Failed to get ID token: $tokenError');
      }

      // Send token to backend API
      debugPrint(' [Backend API] Sending token to backend...');
      final backendSuccess = await _sendTokenToBackend(idToken: idToken!);

      // Only navigate if backend API succeeded
      if (backendSuccess) {
        debugPrint(' [Firebase Auth] Navigating to HomeScreen...');
        if (mounted) {
          // Clear entire navigation stack and go to home
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) =>
                false, // Remove all previous routes (prevents going back to login)
          );
        }
      } else {
        debugPrint(
            ' [Backend API] Backend verification failed, not navigating');
      }
    } on FirebaseAuthException catch (e) {
      // Log Firebase Auth Exception
      String errorMessage = 'An error occurred';

      if (e.code == 'wrong-password') {
        errorMessage = 'Invalid password';
        debugPrint(' [Firebase Auth] Wrong password error');
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address';
        debugPrint(' [Firebase Auth] Invalid email error');
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak';
        debugPrint('[Firebase Auth] Weak password error');
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email is already in use';
        debugPrint('[Firebase Auth] Email already in use error');
      } else {
        errorMessage = e.message ?? 'Authentication failed';
        debugPrint(' [Firebase Auth] Other authentication error');
      }

      if (mounted) {
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('An unexpected error occurred: ${e.toString()}');
      }
    } finally {
      debugPrint('🏁 [Firebase Auth] Authentication process completed');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

 Future<bool> _sendTokenToBackend({
  required String idToken,
}) async {
  _errorDialogShown = false;

  try {
     await TokenStorageService.saveFirebaseToken(idToken);
      debugPrint('🔥 [Storage] Firebase token saved during sign-in');
    final apiClient = ApiClient.instance;

    final response = await apiClient.post<dynamic>(
      ApiEndpoints.authVerify,
      data: {'idToken': idToken},
    );

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final body = response.data;

      debugPrint("✅ [Backend API] Verify Response: $body");

      if (body is Map<String, dynamic>) {
        final data = body["data"];
final user = data["user"];

if (user is Map<String, dynamic>) {
  final userId = user["id"]?.toString();

  if (userId != null && userId.isNotEmpty) {
    await TokenStorageService.saveUserId(userId);
    debugPrint("👤 [Storage] UserId saved: $userId");
  } else {
    debugPrint("⚠️ [Storage] UserId missing in response");
  }
}

        if (data is Map<String, dynamic>) {
           final user = data["user"];
  if (user is Map<String, dynamic>) {
    final userId = user["id"]?.toString();
    if (userId != null && userId.isNotEmpty) {
      await TokenStorageService.saveUserId(userId);
      debugPrint("👤 [Storage] UserId saved: $userId");
    }
  }
          final accessToken = data["accessToken"] as String?;
          final refreshToken = data["refreshToken"] as String?;

          debugPrint("🔑 [Backend API] AccessToken Found: ${accessToken != null}");
          debugPrint("🔁 [Backend API] RefreshToken Found: ${refreshToken != null}");

          if (accessToken != null && accessToken.isNotEmpty) {
            await TokenStorageService.saveAccessToken(accessToken);
            debugPrint("💾 [Storage] Access token saved");
          }

          if (refreshToken != null && refreshToken.isNotEmpty) {
            await TokenStorageService.saveRefreshToken(refreshToken);
            debugPrint("💾 [Storage] Refresh token saved");
          }

          // confirm saved
          final savedRefresh = await TokenStorageService.getRefreshToken();
          debugPrint(
            "✅ [Storage] Refresh token now: ${savedRefresh == null ? "NULL" : "FOUND"}",
          );

          return true;
        }
      }

      debugPrint("❌ [Backend API] Token parsing failed!");
      return false;
    } else {
      String errorMessage = 'Backend verification failed';

      if (response.data is Map) {
        final errorData = response.data as Map;
        errorMessage = errorData['message'] as String? ??
            errorData['error'] as String? ??
            'Backend verification failed';
      }

      if (mounted && !_errorDialogShown) {
        _errorDialogShown = true;
        _showBackendErrorDialog(errorMessage);
      }
      return false;
    }
  } on DioException catch (e) {
    String errorMessage = 'Backend verification failed';

    if (e.response?.data is Map) {
      final errorData = e.response!.data as Map;
      errorMessage = errorData['message'] as String? ??
          errorData['error'] as String? ??
          'Backend verification failed';
    }

    if (mounted && !_errorDialogShown) {
      _errorDialogShown = true;
      _showBackendErrorDialog(errorMessage);
    }

    return false;
  } catch (e) {
    debugPrint("❌ [Backend API] Error: $e");

    if (mounted && !_errorDialogShown) {
      _errorDialogShown = true;
      _showBackendErrorDialog(
        'An unexpected error occurred. Please try again.',
      );
    }

    return false;
  }
}

  void _showBackendErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Backend Verification Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Authentication Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: Column(
          children: [
            // Header - not scrollable
            const AppHeaderLogin(),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo
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

                      // Title
                      const Text(
                        'Join the official',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Abu Dhabi Cycling Community',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email Input Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final trimmedValue = value.trim();
                          if (trimmedValue.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Email regex pattern for proper validation
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(trimmedValue)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: 'Enter your Email',
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

                      // Password Input Field
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
                          hintText: 'Enter your Password',
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

                      // Create Account Button
                      AppButton(
                        label: 'Sign In',
                        onPressed: _isLoading ? null : _handleLogin,
                        isLoading: _isLoading,
                        backgroundColor: AppColors.deepRed,
                        textColor: Colors.white,
                        borderRadius: 14,
                        height: 56,
                      ),

                      const SizedBox(height: 32),

                      // Or sign in with
                      const Text(
                        'Or sign in with',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Social Sign-in Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Apple
                          _buildSocialButton(
                            child: Image.asset(
                              'assets/icons/apple_icon.png',
                              width: 24,
                              height: 24,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text(
                                  '🍎',
                                  style: TextStyle(fontSize: 24),
                                );
                              },
                            ),
                            onTap: () {
                              debugPrint('Apple sign-in clicked');
                            },
                          ),
                          const SizedBox(width: 16),
                          // Google
                          _buildSocialButton(
                            child: Image.asset(
                              'assets/icons/google_icon.png',
                              width: 24,
                              height: 24,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text(
                                  'G',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            onTap: () {
                              debugPrint('Google sign-in clicked');
                            },
                          ),
                          const SizedBox(width: 16),
                          // Facebook
                          _buildSocialButton(
                            child: Image.asset(
                              'assets/icons/facebook_icon.png',
                              width: 24,
                              height: 24,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text(
                                  'f',
                                  style: TextStyle(
                                    color: Color(0xFF1877F2),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Arial',
                                  ),
                                );
                              },
                            ),
                            onTap: () {
                              debugPrint('Facebook sign-in clicked');
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Terms and Privacy Policy
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "By continuing, you agree to our Terms of Service and Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
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

  Widget _buildSocialButton({
    IconData? icon,
    Widget? child,
    Color? color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: child ??
              (icon != null
                  ? Icon(
                      icon,
                      color: color ?? AppColors.textDark,
                      size: 24,
                    )
                  : const SizedBox()),
        ),
      ),
    );
  }
}
