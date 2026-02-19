import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  final String eventTitle;
  final String eventLocationLine;
  final String date;
  final String location;
  final String type;
  final String community;

  final String eventImagePath;

  final String redArcImagePath;

  const RegistrationSuccessScreen({
    super.key,
    required this.eventTitle,
    required this.eventLocationLine,
    required this.date,
    required this.location,
    required this.type,
    required this.community,
    required this.eventImagePath,
    required this.redArcImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: -52,
              top: 168,
              child: Image.asset(
                redArcImagePath,
                width: 160,
                fit: BoxFit.contain,
              ),
            ),

            ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
              children: [
                Row(
                  children: [
                    _BackCircleButton(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 92,
                        width: 92,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                        left: 22,
                        top: 18,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.deepRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: Text(
                    "You're registered!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.charcoal,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Center(
                  child: Text(
                    "Get ready for an amazing ride with\nthe community!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                      color: AppColors.charcoal.withValues(alpha: 0.55),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                _EventSummaryCard(
                  eventImagePath: eventImagePath,
                  title: eventTitle,
                  subtitle: eventLocationLine,
                  date: date,
                  location: location,
                  type: type,
                  community: community,
                ),

                const SizedBox(height: 16),

                _ActionTile(
                  icon: Icons.calendar_month_rounded,
                  title: "Add to Calendar",
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _ActionTile(
                  icon: Icons.share_rounded,
                  title: "Share with Friends",
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _ActionTile(
                  icon: Icons.event_note_rounded,
                  title: "View My Events",
                  onTap: () {},
                ),

                const SizedBox(height: 16),

                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepRed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Return to Home",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BackCircleButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackCircleButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightDeepRed.withValues(alpha: 0.45),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          height: 34,
          width: 34,
          child: Icon(
            Icons.arrow_back,
            size: 18,
            color: AppColors.deepRed,
          ),
        ),
      ),
    );
  }
}

class _EventSummaryCard extends StatelessWidget {
  final String eventImagePath;
  final String title;
  final String subtitle;

  final String date;
  final String location;
  final String type;
  final String community;

  const _EventSummaryCard({
    required this.eventImagePath,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.location,
    required this.type,
    required this.community,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.dustyRose,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  eventImagePath,
                  height: 52,
                  width: 52,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.2,
                        fontWeight: FontWeight.w700,
                        color: AppColors.charcoal.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MiniInfoCard(
                  icon: Icons.calendar_month_rounded,
                  title: "When",
                  value: date,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniInfoCard(
                  icon: Icons.location_on_rounded,
                  title: "Location",
                  value: location,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _MiniInfoCard(
                  icon: Icons.directions_bike_rounded,
                  title: "Type",
                  value: type,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniInfoCard(
                  icon: Icons.groups_2_rounded,
                  title: "Community",
                  value: community,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _MiniInfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardLightBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.lightBeige,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.deepRed),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardLightBackground,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: AppColors.warmSand.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: AppColors.goldenOchre,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    color: AppColors.charcoal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
