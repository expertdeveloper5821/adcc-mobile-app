import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/back_button_widget.dart';
import 'sections/challenge_header_section.dart';
import 'sections/challenge_info_section.dart';
import 'sections/challenge_metrics_section.dart';
import 'sections/challenge_progress_section.dart';
import 'sections/challenge_rules_section.dart';
import 'sections/challenge_top_performers_section.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  final String challengeId;

  const ChallengeDetailsScreen({
    super.key,
    required this.challengeId,
  });

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _challengeData;

  @override
  void initState() {
    super.initState();
    _loadChallengeData();
  }

  // TODO: Replace with actual API call
  Future<void> _loadChallengeData() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Sample data - replace with actual API response
    setState(() {
      _challengeData = {
        'id': widget.challengeId,
        'image': 'assets/images/cycling_1.png',
        'title': 'December Distance Champion',
        'description': 'Ride 500km this month to earn the champion badge',
        'difficulty': 'Easy',
        'joined': 234,
        'daysLeft': 12,
        'points': 100,
        'progress': 324,
        'target': 500,
        'unit': 'km',
        'percentage': 65,
        'remaining': 176,
        'rules': [
          'Track your rides with the ADCC app or devices.',
          'Both solo and group rides count towards your total',
          'Minimum 10km per ride to count',
          'Challenge ends December 31st at midnight',
        ],
        'topPerformers': [
          {'rank': 1, 'name': 'Ahmed K.', 'value': '497 km'},
          {'rank': 2, 'name': 'Sara M.', 'value': '465 km'},
          {'rank': 3, 'name': 'Mohammed A.', 'value': '420 km'},
        ],
        'isJoined': false,
        'isCompleted': false,
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.softCream,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_challengeData == null) {
      return Scaffold(
        backgroundColor: AppColors.softCream,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Failed to load challenge details'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Back button above banner
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(
                  backgroundColor: AppColors.paleGreen.withValues(alpha: 0.36),
                  iconColor: AppColors.brand_green,
                  onBack: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ),

            // Header with image only
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ChallengeHeaderSection(
                imagePath: _challengeData!['image'] as String,
              ),
            ),

            const SizedBox(height: 16),

            // Challenge Info (Title, Description, and Share button)
            ChallengeInfoSection(
              title: _challengeData!['title'] as String,
              description: _challengeData!['description'] as String,
              onShare: () {
                // Handle share
                debugPrint('Share challenge tapped');
              },
            ),

            const SizedBox(height: 16),

            // Metrics Cards (Joined, Days Left, Points)
            ChallengeMetricsSection(
              joined: _challengeData!['joined'] as int,
              daysLeft: _challengeData!['daysLeft'] as int,
              points: _challengeData!['points'] as int,
            ),

            const SizedBox(height: 16),

            // Progress Section
            ChallengeProgressSection(
              progress: _challengeData!['progress'] as int,
              target: _challengeData!['target'] as int,
              unit: _challengeData!['unit'] as String,
              percentage: _challengeData!['percentage'] as int,
              remaining: _challengeData!['remaining'] as int,
            ),

            const SizedBox(height: 24),

            // Challenge Rules
            ChallengeRulesSection(
              rules: _challengeData!['rules'] as List<String>,
            ),

            const SizedBox(height: 24),

            // Top Performers
            ChallengeTopPerformersSection(
              performers: _challengeData!['topPerformers'] as List<Map<String, dynamic>>,
              onViewAll: () {
                // Navigate to full leaderboard
                debugPrint('View all performers tapped');
              },
              onJoin: _challengeData!['isJoined'] == false
                  ? () {
                      // Handle join challenge
                      setState(() {
                        _challengeData!['isJoined'] = true;
                      });
                      debugPrint('Join challenge tapped');
                    }
                  : null,
              onMarkComplete: _challengeData!['isJoined'] == true &&
                      _challengeData!['isCompleted'] == false
                  ? () {
                      // Handle mark as complete
                      debugPrint('Mark as complete tapped');
                    }
                  : null,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

