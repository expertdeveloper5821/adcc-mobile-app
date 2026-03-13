import 'dart:convert';

import 'package:adcc/l10n/app_localizations.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/token_storage_service.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../shared/widgets/app_button.dart';
import '../../home/view/home_screen.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  DateTime? _birthDate;
  String? _gender;
  String? _jerseySize; // xs, s, m, l, xl, xxl
  Country? _selectedCountry;
  XFile? _idFrontFile;
  XFile? _idBackFile;
  bool _agreedToTerms = false;
  bool _isLoading = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final ImagePicker _imagePicker = ImagePicker();

  static const Color _iconBgColor = Color(0xFFFFF4D6);
  static const Color _fieldBgColor = Color(0xFFFDF8ED);
  static const Color _backButtonBg = Color(0xFFF5F0E6);

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? now.subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() => _selectedCountry = country);
      },
    );
  }

  Future<void> _pickIdFront() async {
    final xFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (xFile != null) setState(() => _idFrontFile = xFile);
  }

  Future<void> _pickIdBack() async {
    final xFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (xFile != null) setState(() => _idBackFile = xFile);
  }

  Future<String?> _fileToBase64(XFile? file) async {
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> _handleContinue() async {
    setState(() {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
    });

    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.userAgreementAndPrivacy,
            maxLines: 2,
          ),
          backgroundColor: AppColors.deepRed,
        ),
      );
      return;
    }
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final idToken = await TokenStorageService.getFirebaseToken();
      if (idToken == null || idToken.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Session expired. Please sign in again.'),
              backgroundColor: AppColors.deepRed,
            ),
          );
        }
        setState(() => _isLoading = false);
        return;
      }

      final birthDateStr = _birthDate != null
          ? '${_birthDate!.year}-${_birthDate!.month.toString().padLeft(2, '0')}-${_birthDate!.day.toString().padLeft(2, '0')}'
          : null;
      final countryName = _selectedCountry?.name;
      final countryCode = _selectedCountry?.countryCode;

      final payload = <String, dynamic>{
        'idToken': idToken,
        'fullName': _fullNameController.text.trim(),
        if (birthDateStr != null) 'birthDate': birthDateStr,
        if (_gender != null) 'gender': _gender,
        if (_jerseySize != null) 'jerseySize': _jerseySize,
        if (countryName != null) 'country': countryName,
        if (countryCode != null) 'countryCode': countryCode,
        'agreedToTerms': true,
      };

      final idFrontBase64 = await _fileToBase64(_idFrontFile);
      final idBackBase64 = await _fileToBase64(_idBackFile);
      if (idFrontBase64 != null) payload['governmentIdFront'] = idFrontBase64;
      if (idBackBase64 != null) payload['governmentIdBack'] = idBackBase64;

      final apiClient = ApiClient.instance;
      final response = await apiClient.post<dynamic>(
        ApiEndpoints.authRegister,
        data: payload,
      );

      debugPrint('[Backend API] Register response.data: ${response.data}');

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final body = response.data;
        if (body is Map<String, dynamic>) {
          final data = body["data"];
          if (data is Map<String, dynamic>) {
            final accessToken = data["accessToken"] as String?;
            final refreshToken = data["refreshToken"] as String?;
            final user = data["user"];
            if (user is Map<String, dynamic>) {
              final userId = user["id"]?.toString();
              if (userId != null && userId.isNotEmpty) {
                await TokenStorageService.saveUserId(userId);
              }
            }
            if (accessToken != null && accessToken.isNotEmpty) {
              await TokenStorageService.saveAccessToken(accessToken);
            }
            if (refreshToken != null && refreshToken.isNotEmpty) {
              await TokenStorageService.saveRefreshToken(refreshToken);
            }
          }
        }

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        }
      } else {
        String msg = 'Registration failed';
        if (response.data is Map) {
          final d = response.data as Map;
          msg = d['message'] as String? ?? d['error'] as String? ?? msg;
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: AppColors.deepRed),
          );
        }
      }
    } on DioException catch (e) {
      debugPrint('[Backend API] Register error: $e');
      String msg = 'Registration failed';
      if (e.response?.data is Map) {
        final d = e.response!.data as Map;
        msg = d['message'] as String? ?? d['error'] as String? ?? msg;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: AppColors.deepRed),
        );
      }
    } catch (e) {
      debugPrint('[SetupProfile] Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: AppColors.deepRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildIconCircle(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: _iconBgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 22, color: AppColors.textDark),
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: _fieldBgColor,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: _backButtonBg,
              shape: const CircleBorder(),
            ),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark, size: 20),
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
        title: Text(
          l10n.setupProfileTitle,
          style: const TextStyle(
            color: AppColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                l10n.setupProfileStep,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _fullNameController,
                  hint: l10n.enterFullNamePlaceholder,
                  icon: Icons.person_outline,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildDateField(l10n.chooseBirthDate),
                const SizedBox(height: 16),
                _buildGenderField(l10n),
                const SizedBox(height: 16),
                _buildJerseySizeField(l10n),
                const SizedBox(height: 16),
                _buildCountryField(l10n),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildUploadField(
                        label: l10n.governmentIdFront,
                        file: _idFrontFile,
                        onTap: _pickIdFront,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildUploadField(
                        label: l10n.governmentIdBack,
                        file: _idBackFile,
                        onTap: _pickIdBack,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildTermsCheckbox(l10n),
                const SizedBox(height: 40),
                AppButton(
                  label: l10n.continue_button,
                  onPressed: _isLoading ? null : _handleContinue,
                  isLoading: _isLoading,
                  backgroundColor: AppColors.deepRed,
                  textColor: Colors.white,
                  borderRadius: 14,
                  height: 56,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorText(String? text) {
    if (text == null || text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.deepRed,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return FormField<String>(
      validator: (_) => validator?.call(controller.text),
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: _fieldDecoration().copyWith(
                border: state.hasError
                    ? Border.all(color: AppColors.deepRed, width: 1.5)
                    : Border.all(color: Colors.grey.shade300),
              ),
              child: TextFormField(
                controller: controller,
                onChanged: (_) {
                  state.didChange(controller.text);
                  state.validate();
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: _buildIconCircle(icon),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 0),
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorText: null,
                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                ),
              ),
            ),
            _buildErrorText(state.errorText),
          ],
        );
      },
    );
  }

  Widget _buildDateField(String hint) {
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: _fieldDecoration(),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildIconCircle(Icons.calendar_today_outlined),
            ),
            Expanded(
              child: Text(
                _birthDate != null
                    ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                    : hint,
                style: TextStyle(
                  color: _birthDate != null
                      ? AppColors.textDark
                      : Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.textDark),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderField(AppLocalizations l10n) {
    return FormField<String>(
      validator: (_) => _gender == null ? 'Please choose your gender' : null,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: _fieldDecoration().copyWith(
                border: field.hasError
                    ? Border.all(color: AppColors.deepRed, width: 1.5)
                    : Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: _buildIconCircle(Icons.wc_outlined),
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 0),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    errorText: null,
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                  ),
                  hint: Text(
                    l10n.chooseGender,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  items: [
                    DropdownMenuItem(value: 'male', child: Text(l10n.genderMale)),
                    DropdownMenuItem(value: 'female', child: Text(l10n.genderFemale)),
                    DropdownMenuItem(value: 'other', child: Text(l10n.genderOther)),
                  ],
                  onChanged: (v) => setState(() => _gender = v),
                ),
              ),
            ),
            _buildErrorText(field.errorText),
          ],
        );
      },
    );
  }

  Widget _buildJerseySizeField(AppLocalizations l10n) {
    final jerseyOptions = [
      ('xs', l10n.jerseySizeXS),
      ('s', l10n.jerseySizeS),
      ('m', l10n.jerseySizeM),
      ('l', l10n.jerseySizeL),
      ('xl', l10n.jerseySizeXL),
      ('xxl', l10n.jerseySizeXXL),
    ];
    return FormField<String>(
      validator: (_) => _jerseySize == null ? 'Please choose jersey size' : null,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: _fieldDecoration().copyWith(
                border: field.hasError
                    ? Border.all(color: AppColors.deepRed, width: 1.5)
                    : Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: _jerseySize,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: _buildIconCircle(Icons.checkroom_outlined),
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 0),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    errorText: null,
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                  ),
                  hint: Text(
                    l10n.jerseySize,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  items: [
                    for (final o in jerseyOptions)
                      DropdownMenuItem(value: o.$1, child: Text(o.$2)),
                  ],
                  onChanged: (v) => setState(() => _jerseySize = v),
                ),
              ),
            ),
            _buildErrorText(field.errorText),
          ],
        );
      },
    );
  }

  Widget _buildCountryField(AppLocalizations l10n) {
    return FormField<String>(
      validator: (_) =>
          _selectedCountry == null ? 'Please choose your country' : null,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _openCountryPicker,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: _fieldDecoration().copyWith(
                  border: field.hasError
                      ? Border.all(color: AppColors.deepRed, width: 1.5)
                      : Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildIconCircle(Icons.public_outlined),
                    ),
                    Expanded(
                      child: Text(
                        _selectedCountry?.name ?? l10n.countryLabel,
                        style: TextStyle(
                          color: _selectedCountry != null
                              ? AppColors.textDark
                              : Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: AppColors.textDark),
                  ],
                ),
              ),
            ),
            _buildErrorText(field.errorText),
          ],
        );
      },
    );
  }

  Widget _buildUploadField({
    required String label,
    required XFile? file,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: _fieldDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: file != null ? AppColors.textDark : Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.upload_outlined,
              color: AppColors.textDark,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox(AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _agreedToTerms,
            onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
            activeColor: AppColors.deepRed,
            shape: const CircleBorder(),
            side: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                l10n.userAgreementAndPrivacy,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textDark,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
