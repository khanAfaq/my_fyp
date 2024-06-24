// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fyp/pages/cancer_page.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<dynamic> mydata = [];
  File? _image;
  XFile? myFile;
  Uint8List? bytes;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    myFile = pickedFile;
    bytes = await myFile!.readAsBytes();

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  void uploadImage(List<int> imageBytes, XFile imagePath) async {
    showLoadingDialog();
    print(imageBytes);
    print(imagePath);
    try {
      final response = await http.post(
        Uri.parse(
            "https://api-inference.huggingface.co/models/kamran7006/fyp__brain_tumor_detection_vit"),
        headers: {
          "Authorization": "Bearer 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",
          "Content-Type": "application/octet-stream",
        },
        body: imageBytes,
      );
      hideLoadingDialog();
      if (response.statusCode == 200) {
        final afaq = jsonDecode(response.body);
        log('this is body : ${afaq}');
        mydata = afaq;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CancerPage(
              result: mydata[0]['label'],
              imageFile: _image,
            ),
          ),
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to upload image, please try again',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 30,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
        );
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } on SocketException {
      hideLoadingDialog();
      Get.snackbar(
        'Error',
        'No Internet Connection',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 30,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
      );
      throw Exception('No internet connection');
    } catch (e) {
      hideLoadingDialog();
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 30,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
      );
      throw Exception('Failed to upload image: $e');
    }
  }

  void goToMain() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CancerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'FYP',
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Upload an Image for testing tumor',
              style: TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _image == null
                    ? const Center(
                        child: Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Image.file(
                          _image!,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 50.0),
            GestureDetector(
              onTap: () => uploadImage(bytes!, myFile!),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
