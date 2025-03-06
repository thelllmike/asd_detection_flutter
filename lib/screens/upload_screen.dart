// lib/screens/upload_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  String? _selectedAge;
  String? _selectedGender;

  Future<void> _pickImage() async {
    // If you want to let the user choose camera vs gallery, present a dialog or bottom sheet
    // For now, we pick from gallery by default:
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _onNext() {
    // TODO: Validate or proceed with next steps
    // e.g., Navigator.push(context, MaterialPageRoute(builder: (_) => NextScreen()));
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image.")),
      );
      return;
    }
    if (_selectedAge == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an age.")),
      );
      return;
    }
    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a gender.")),
      );
      return;
    }

    // If everything is selected, do your logic
    print("Image: $_selectedImage");
    print("Age: $_selectedAge");
    print("Gender: $_selectedGender");
    // Navigate or do something else
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Behavioural Progress Prediction"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Intro text
            Text(
              "We need some information to predict the progress of an autistic kid",
              style: textStyle.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Image picker area
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: _selectedImage == null
                    ? Center(
                        child: Text(
                          "Tap to add image",
                          style: textStyle.copyWith(
                            color: AppColors.darkBlue,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Age Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Age",
                labelStyle: textStyle.copyWith(
                  fontSize: 16,
                  color: AppColors.darkBlue,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: AppColors.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: _selectedAge,
              items: [
                "24 months",
                "36 months",
                "48 months",
                "60 months",
                "72 months",
              ].map((age) {
                return DropdownMenuItem(
                  value: age,
                  child: Text(
                    age,
                    style: textStyle.copyWith(fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAge = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Gender Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Gender",
                labelStyle: textStyle.copyWith(
                  fontSize: 16,
                  color: AppColors.darkBlue,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: AppColors.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: _selectedGender,
              items: ["Male", "Female", "Other"].map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(
                    gender,
                    style: textStyle.copyWith(fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // NEXT button
            ElevatedButton(
              onPressed: _onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "NEXT",
                style: textStyle.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}