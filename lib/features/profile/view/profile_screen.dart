import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/token_storage_service.dart';
import '../../../core/services/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../shared/widgets/app_button.dart';
import 'sections/profile_header_section.dart';
import 'sections/profile_menu_section.dart';
import 'sections/route_details_integration_section.dart';
import '../../../features/auth/view/register_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggingOut = false;

  /// Handle logout with API call
  Future<void> _handleLogout() async {
    if (_isLoggingOut) return; // Prevent multiple calls

    setState(() {
      _isLoggingOut = true;
    });

    try {
      // Get refresh token before clearing
      final refreshToken = await TokenStorageService.getRefreshToken();

      // Call logout API if refresh token exists
      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          final apiClient = ApiClient.instance;
          final requestData = {
            'refreshToken': refreshToken,
          };

          debugPrint('📤 [Logout API] Request URL: ${ApiEndpoints.authLogout}');
          debugPrint('📤 [Logout API] Request Body: $requestData');

          final response = await apiClient.post<dynamic>(
            ApiEndpoints.authLogout,
            data: requestData,
          );

          debugPrint(
              '📥 [Logout API] Response Status Code: ${response.statusCode}');
          debugPrint('📥 [Logout API] Response Body: ${response.data}');

          if (response.statusCode != null &&
              response.statusCode! >= 200 &&
              response.statusCode! < 300) {
            debugPrint('✅ [Logout API] Logout successful');
          } else {
            debugPrint(
                '⚠️ [Logout API] Logout API returned non-success status');
            // Continue with local logout even if API fails
          }
        } on DioException catch (e) {
          debugPrint('❌ [Logout API] DioException: ${e.message}');
          debugPrint('❌ [Logout API] Response: ${e.response?.data}');
          // Continue with local logout even if API fails
        } catch (e) {
          debugPrint('❌ [Logout API] Unexpected error: $e');
          // Continue with local logout even if API fails
        }
      } else {
        debugPrint('⚠️ [Logout] No refresh token found, skipping API call');
      }

      // Clear all tokens and user data locally
      await TokenStorageService.clearTokens();
      debugPrint('✅ [Logout] Local tokens cleared');

      // Navigate to register screen and clear entire navigation stack
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const RegisterScreen(),
          ),
          (route) => false, // Remove all previous routes
        );
      }
    } catch (e) {
      debugPrint('❌ [Logout] Error during logout: $e');
      // Even if there's an error, try to clear tokens and navigate
      await TokenStorageService.clearTokens();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const RegisterScreen(),
          ),
          (route) => false,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.softCream,
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: 100, // Space for bottom navigation bar
          ),
          children: [
            // Header with Profile title (now scrollable)
            ProfileHeaderSection(
              name: 'Andrew',
              location: 'Abu Dhabi City',
              skillLevel: 'Intermediate rider',
              profileImagePath: 'assets/images/profile.png',
              stats: {
                'km': '2,340',
                'rides': '126',
                'events': '14',
              },
            ),
            // Menu Options (positioned to overlap header bottom by 20-30px)
            Transform.translate(
              offset: const Offset(
                  0, -30), // Move up 30px to overlap only bottom of header
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProfileMenuSection(
                  menuItems: [
                    {
                      'icon': Icons.directions_bike,
                      'label': 'My cycling details',
                    },
                    {
                      'icon': Icons.history,
                      'label': 'Event history & results',
                    },
                    {
                      'icon': Icons.workspace_premium,
                      'label': 'Badges & achievements',
                    },
                    {
                      'icon': Icons.card_giftcard,
                      'label': 'Rewards and points',
                    },
                    {
                      'icon': Icons.settings,
                      'label': 'Settings & preferences',
                    },
                  ],
                  onItemTap: (index, label) {
                    // Handle menu item tap
                    debugPrint('Tapped: $label');
                  },
                ),
              ),
            ),
            // Content below header with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Route Details Integration
                  RouteDetailsIntegrationSection(
                    serviceName: 'Garmin',
                    onConnect: () {
                      // Handle connect action
                      debugPrint('Connect Garmin tapped');
                    },
                  ),
                  const SizedBox(height: 24),
                  // Logout Button
                  AppButton(
                    label: _isLoggingOut ? 'Logging out...' : 'Logout',
                    onPressed: _isLoggingOut ? null : _handleLogout,
                    type: AppButtonType.danger,
                    backgroundColor: AppColors.deepRed,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
