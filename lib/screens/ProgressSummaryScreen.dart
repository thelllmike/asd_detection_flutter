import 'package:flutter/material.dart';
import 'package:asd_detection_flutter/Widget/bottom_navigation.dart';
import 'package:asd_detection_flutter/theme/theme.dart';
import 'package:asd_detection_flutter/theme/colors.dart';

class ProgressSummaryScreen extends StatelessWidget {
  const ProgressSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome Ann,',
                style: textStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildWelcomeCard(),
              const SizedBox(height: 16),
              _buildSummarySection(),
              const SizedBox(height: 16),
              _buildComparisonSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  /// Welcome Message Card
  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [AppColors.secondaryColor, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Consistency is key!\nNo major changes yet, but every step counts.',
              style: TextStyle(fontSize: 16, color: AppColors.textColor),
            ),
          ),
          Image.asset('assets/images/asd.png', width: 60),
        ],
      ),
    );
  }

  /// Summary Section
  Widget _buildSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summary', style: textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildProgressBar('Communication', Colors.green, 'Good', 0.9),
        _buildProgressBar('Social Interaction', Colors.orange, 'Fair', 0.7),
        _buildProgressBar('Sensory Sensitivities', Colors.green, 'Good', 0.85),
        _buildProgressBar('Repetitive and Focused Behaviors', Colors.green, 'Good', 0.8),
        _buildProgressBar('Emotional Regulation', Colors.red, 'Severe', 0.4),
        _buildProgressBar('Engagement and Learning', Colors.orange, 'Fair', 0.6),
        _buildProgressBar('Visual Behavior Analysis', Colors.green, 'Good', 0.9),
      ],
    );
  }

  /// Comparison Section (Styled to Match Screenshot)
  Widget _buildComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Comparison', style: textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF90E0EF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Text('Last Week', style: TextStyle(color: Colors.black, fontSize: 14)),
                  Icon(Icons.arrow_drop_down, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildComparisonRow('Communication', 10),
        _buildComparisonRow('Social Interaction', 5),
        _buildComparisonRow('Sensory Sensitivities', -4),
        _buildComparisonRow('Repetitive and Focused Behaviors', 1),
        _buildComparisonRow('Emotional Regulation', 7),
      ],
    );
  }

  /// Progress Bar for Summary Section
  Widget _buildProgressBar(String title, Color color, String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textStyle.copyWith(fontSize: 16)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: AppColors.secondaryColor.withOpacity(0.4),
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  /// Styled Comparison Row with Indicator
  Widget _buildComparisonRow(String title, int change) {
    bool isIncrease = change > 0;
    String iconPath = isIncrease ? 'assets/images/up.png' : 'assets/images/down.png';
    Color changeColor = isIncrease ? const Color(0xFF58C322) : const Color(0xFFD41111);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textStyle.copyWith(fontSize: 16)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    LinearProgressIndicator(
                      value: 1.0,
                      backgroundColor: AppColors.secondaryColor.withOpacity(0.4),
                      color: const Color(0xFF0077B6),
                    ),
                    Positioned(
                      right: 5,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 45,
                        height: 22,
                        decoration: BoxDecoration(
                          color: changeColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${isIncrease ? '+' : ''}$change%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              iconPath,
                              width: 12,
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}