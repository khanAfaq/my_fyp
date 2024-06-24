import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_fyp/pages/home_page.dart';

class CancerPage extends StatefulWidget {
  final String? result;
  final File? imageFile;

  const CancerPage({super.key, this.result, this.imageFile});

  @override
  State<CancerPage> createState() => _CancerPageState();
}

class _CancerPageState extends State<CancerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CircleAvatar(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
          ),
        ),
        title: const Text(
          'Final Result',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Brain tumor detection using ViT',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 35.0),
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.file(
                      widget.imageFile!,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text(
                    'Result Status',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  subtitle: Text(
                    widget.result.toString(),
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
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
