import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 25.h),
              Center(
                child: Image.asset(
                  'assets/circle-g.png',
                  width: 128,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                child: const Text(
                  'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.email_rounded),
                        SizedBox(width: 5.w),
                        const Text('very.very.23.5.1999@gmail.com'),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.phone_rounded),
                        SizedBox(width: 5.w),
                        const Text('0896-9339-9496'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
