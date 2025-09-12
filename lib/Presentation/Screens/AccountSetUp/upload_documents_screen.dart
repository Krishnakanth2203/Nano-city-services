import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nano_city_services/AppUtils/app_colors.dart';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/AppUtils/app_text_style.dart';
import 'package:nano_city_services/Presentation/Screens/Home/home_page_screen.dart';
import 'package:nano_city_services/Presentation/Widgets/button_style_widget.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  String? serviceDocUrl;
  String? certDocUrl;

  bool uploading = false;

  Future<String?> uploadFile(String docType) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      File file = File(pickedFile.path);
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String fileName =
          "${docType}_${DateTime.now().millisecondsSinceEpoch}.jpg";

      final storageRef = FirebaseStorage.instance
          .ref()
          .child("documents")
          .child(userId)
          .child(fileName);

      final uploadTask = await storageRef.putFile(file);
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print("❌ Upload error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $e")),
      );
      return null;
    }
  }

  Future<void> handleSubmit() async {
    if (serviceDocUrl == null || certDocUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload both documents")),
      );
      return;
    }

    setState(() {
      uploading = true;
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;
    final phone = FirebaseAuth.instance.currentUser!.phoneNumber ?? "";

    await FirebaseFirestore.instance.collection("users").doc(userId).set({
      "userType": "service_provider",
      "phone": phone,
      "documents": {
        "service_doc": serviceDocUrl,
        "cert_doc": certDocUrl,
      },
      "isVerified": false,
    });

    setState(() {
      uploading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(AppImages.logoncsImg),
        ),
        actions: [
          Image.asset(AppImages.frame6Img),
          const SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.fewDoc, style: AppTextStyle.textStyle),
            const SizedBox(height: 30),
            Text(AppStrings.uploadService, style: AppTextStyle.textStyle),
            const SizedBox(height: 12),
            uploadButton("Upload Service Doc", (url) {
              setState(() => serviceDocUrl = url);
            }),
            const SizedBox(height: 20),
            Text(AppStrings.uploadCertification, style: AppTextStyle.textStyle),
            const SizedBox(height: 12),
            uploadButton("Upload Certificate", (url) {
              setState(() => certDocUrl = url);
            }),
            const SizedBox(height: 40),
            InkWell(
              onTap: uploading ? null : handleSubmit,
              child: ButtonStyleWidget(
                title: uploading ? "Uploading..." : AppStrings.next,
                colors: AppColors.blueColors,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadButton(String title, Function(String?) onUploaded) {
    return InkWell(
      onTap: () async {
        String? downloadUrl = await uploadFile(title);
        if (downloadUrl != null) {
          onUploaded(downloadUrl);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title uploaded successfully!")),
          );
        }
      },
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.blueColors),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.blueColors,
            ),
          ),
        ),
      ),
    );
  }
}
