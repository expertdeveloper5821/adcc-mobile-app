import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';

class GuestProfileSection extends StatelessWidget {
  final VoidCallback onSignUpLogin;
  final VoidCallback onBrowseEvents;
  final VoidCallback onExploreCommunity;
  final VoidCallback onViewRoutes;

  const GuestProfileSection({
    super.key,
    required this.onSignUpLogin,
    required this.onBrowseEvents,
    required this.onExploreCommunity,
    required this.onViewRoutes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: 100, // Space for bottom navigation bar
      ),
      children: [
        // Sign Up / Login Section
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // Circular golden-yellow icon with person silhouette and plus
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7B347), // Golden yellow
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                // "Welcome to ADCC" text
                const Text(
                  'Welcome to ADCC',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 12),
                // Description text
                Text(
                  'Sign up to join events, connect with the community, and track your cycling journey.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.charcoal.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                // Sign Up / Login Button
                AppButton(
                  label: 'Sign Up / Login',
                  onPressed: onSignUpLogin,
                  backgroundColor: const Color(0xFFC83E3E), // Red
                  textColor: Colors.white,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
        // Available as a Guest Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Available as a guest:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(height: 16),
              // Browse Events Button
              _GuestOptionButton(
                label: 'Browse Events',
                onTap: onBrowseEvents,
              ),
              const SizedBox(height: 12),
              // Explore Community Button
              _GuestOptionButton(
                label: 'Explore Community',
                onTap: onExploreCommunity,
              ),
              const SizedBox(height: 12),
              // View Routes Button
              _GuestOptionButton(
                label: 'View Tracks',
                onTap: onViewRoutes,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _GuestOptionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _GuestOptionButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.lightBeige, // #E9E4DB
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.charcoal,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.charcoal,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
