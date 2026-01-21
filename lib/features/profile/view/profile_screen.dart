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
import 'sections/guest_profile_section.dart';
import '../../my_cycling_details/view/my_cycling_details_screen.dart';
import '../../../features/auth/view/register_screen.dart';
import '../../../features/auth/view/email_password_login_screen.dart';
import '../../../features/events/view/events_screen.dart';
import '../../../features/communities/view/community_screen.dart';
import '../../../features/routes/view/routes_screen_wrapper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggingOut = false;
  bool _isAuthenticated = false;
  bool _isCheckingAuth = true;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final isAuthenticated = await TokenStorageService.isAuthenticated();
    if (mounted) {
      setState(() {
        _isAuthenticated = isAuthenticated;
        _isCheckingAuth = false;
      });
    }
  }

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

      // Update authentication state
      if (mounted) {
        setState(() {
          _isAuthenticated = false;
        });
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

  void _handleSignUpLogin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EmailPasswordLoginScreen(),
      ),
    );
    // Refresh authentication state after returning from login
    _checkAuthentication();
  }

  void _handleBrowseEvents() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EventsScreen(),
      ),
    );
  }

  void _handleExploreCommunity() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CommunitiesScreen(),
      ),
    );
  }

  void _handleViewRoutes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RoutesScreenWrapper(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while checking authentication
    if (_isCheckingAuth) {
      return Container(
        color: AppColors.softCream,
        child: const SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    // Show guest profile screen if not authenticated
    if (!_isAuthenticated) {
      return Container(
        color: AppColors.softCream,
        child: SafeArea(
          child: Column(
            children: [
              // Header with Profile title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    const SizedBox(width: 40), // Spacer for centering
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.charcoal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // Spacer for centering
                  ],
                ),
              ),
              // Guest Profile Content
              Expanded(
                child: GuestProfileSection(
                  onSignUpLogin: _handleSignUpLogin,
                  onBrowseEvents: _handleBrowseEvents,
                  onExploreCommunity: _handleExploreCommunity,
                  onViewRoutes: _handleViewRoutes,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show regular profile screen if authenticated
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
                      'icon': 'assets/svg/colored_cycle.svg',
                      'label': 'My cycling details',
                    },
                    {
                      'icon': 'assets/svg/events_colored.svg',
                      'label': 'Event history & results',
                    },
                    {
                      'icon': 'assets/svg/win_badge.svg',
                      'label': 'Badges & achievements',
                    },
                    {
                      'icon': 'assets/svg/rewards_colored.svg',
                      'label': 'Rewards and points',
                    },
                    {
                      'icon': 'assets/svg/settings_colored.svg',
                      'label': 'Settings & preferences',
                    },
                  ],
                  onItemTap: (index, label) {
                    if (index == 0) {
                      // My cycling details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyCyclingDetailsScreen(),
                        ),
                      );
                      return;
                    }

                    // TODO: handle other menu items
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
                    services: [
                      ServiceIntegration(
                        name: 'Garmin',
                        onConnect: () {
                          // Handle connect action
                          debugPrint('Connect Garmin tapped');
                        },
                      ),
                      ServiceIntegration(
                        name: 'Wahoo',
                        onConnect: () {
                          // Handle connect action
                          debugPrint('Connect Wahoo tapped');
                        },
                      ),
                    ],
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
