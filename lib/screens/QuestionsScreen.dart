import 'package:flutter/material.dart';
import 'package:asd_detection_flutter/theme/colors.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Header Row** (Title + Week)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Communication',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                Text(
                  'Week 3',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.darkBlue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// **Question 1**
            _buildQuestion(
              1,
              'Does the child understand and follow verbal instructions?',
            ),

            /// **Question 2**
            _buildQuestion(
              2,
              'Does the child focus on understanding social cues, such as recognizing emotions in others?',
            ),

            /// **Spacer** pushes the button to the bottom
            const Spacer(),

            /// **Next Button**
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Next button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // #00B4D8
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Next →',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue, // #03045E
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Question Widget** (question text + row of options)
  Widget _buildQuestion(int index, String question) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Question Text
          Text(
            '$index. $question',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 8),

          /// **Row of Options** (Improved, Poor)
          Row(
            children: [
              /// 1st Option
              Flexible(
                child: _buildOption(index, 'Improved'),
              ),
              const SizedBox(width: 12),

              /// 2nd Option
              Flexible(
                child: _buildOption(index, 'Poor'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// **Option Button Widget** (Radio + label)
  Widget _buildOption(int questionIndex, String label) {
    bool isSelected = selectedAnswers[questionIndex] == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswers[questionIndex] = label;
        });
      },
      child: Container(
        // Removed fixed width, so it can shrink/expand as needed
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.2)
              : Colors.transparent,
          border: Border.all(
            color: AppColors.primaryColor, // #00B4D8
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.darkBlue, // #03045E
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}