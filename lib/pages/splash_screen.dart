import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_fyp/pages/home_page.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/uet.jpg',
                    width: 85,
                    height: 85,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "University of Engineering & Technology \n'\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tPeshawar",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'NeuroScan: Revaluatizing Brain tumor detection using Vision transformer',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 30),
            const CircleAvatar(
              maxRadius: 68,
              backgroundImage: AssetImage('images/b2.jpg'),
            ),
            const SizedBox(height: 30),
            const Text(
              'Supervisior: Dr. Yasir Saleem Afridi',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const Text(
              'Department of Computer Systems Engineering',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
