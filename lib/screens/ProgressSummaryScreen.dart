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
              Container(
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
              ),
              const SizedBox(height: 16),
              Text('Summary', style: textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildProgressBar('Communication', Colors.green, 'Good', 0.9),
              _buildProgressBar('Social Interaction', Colors.orange, 'Fair', 0.7),
              _buildProgressBar('Sensory Sensitivities', Colors.green, 'Good', 0.85),
              _buildProgressBar('Repetitive and Focused Behaviors', Colors.green, 'Good', 0.8),
              _buildProgressBar('Emotional Regulation', Colors.red, 'Severe', 0.4),
              _buildProgressBar('Engagement and Learning', Colors.orange, 'Fair', 0.6),
              _buildProgressBar('Visual Behavior Analysis', Colors.green, 'Good', 0.9),
              const SizedBox(height: 16),
              Text('Comparison', style: textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildComparisonRow('Communication', 10, Colors.green),
              _buildComparisonRow('Social Interaction', 5, Colors.green),
              _buildComparisonRow('Sensory Sensitivities', -4, Colors.red),
              _buildComparisonRow('Repetitive and Focused Behaviors', 1, Colors.green),
              _buildComparisonRow('Emotional Regulation', 7, Colors.green),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

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

  Widget _buildComparisonRow(String title, int change, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: 0.6,
              backgroundColor: AppColors.secondaryColor.withOpacity(0.4),
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${change > 0 ? '+' : ''}$change%',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}