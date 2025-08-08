import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'dart:math' as math;


class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final double imageSize = math.min(screenSize.width * 0.4, 200);

    return Scaffold(
        appBar: AppBar(
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo_cekfilm.png",
            height: 50,
        ),
          const SizedBox(width: 10),

          const Text(
              "Cek FILM",
              style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'BebasNeue',
              color: textColor,
                ),
              ),
            ],
          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                //width: screenSize.width * 0.4,
                //height: screenSize.width * 0.4,
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/profile.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),


              Text(
                "M Mahfud Awaludin",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BebasNeue',
                  color: kTextColor,
                ),
              ),
              const SizedBox(height: 2),


              Text(
                "Flutter Developer",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SansitaSwashed',
                  color: kTextLightColor,
                ),
              ),
              const SizedBox(height: 32),


              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: bgColor1.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tentang Aplikasi",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SansitaSwashed',
                        color: kTextColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "CekFilm adalah aplikasi inovatif yang dirancang untuk memberikan informasi lengkap dan terkini tentang berbagai film. Mulai dari judul, tahun rilis, rating, genre, hingga daftar pemeran, semuanya disajikan dengan antarmuka yang intuitif dan mudah digunakan.",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'SansitaSwashed',
                        color: kTextColor,
                      ),
                      textAlign: TextAlign.justify, // Teks rata kanan-kiri
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Versi Aplikasi: 1.0.0",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Roboto',
                        color: kTextColor,
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Bagian Tambahan (misalnya, tautan sosial media atau kontak)
              Text(
                "Connect With Me:",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  color: kTextColor,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Contoh ikon media sosial (gunakan ikon yang sesuai)
                  IconButton(
                    icon: const Icon(Icons.link, color: textColor, size: 30),
                    onPressed: () {
                      // Tambahkan logika untuk membuka tautan LinkedIn/GitHub
                      print("LinkedIn/GitHub ditekan");
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.email, color: textColor, size: 30),
                    onPressed: () {
                      // Tambahkan logika untuk membuka email
                      print("Email ditekan");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
