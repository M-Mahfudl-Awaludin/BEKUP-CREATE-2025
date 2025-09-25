import 'package:ceksantap/screen/live_camera/home_camera_live.dart';
import 'package:ceksantap/screen/picker_camera/picker_camera_screen.dart';
import 'package:ceksantap/style/theme/ceksantap_theme.dart';
import 'package:flutter/material.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> images = [
    "assets/image/splash_ceksantap.png",
    "assets/image/slide-2.png",
    "assets/image/slide-3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "CekSantap",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CeksantapColors.secondary,
            ),
          ),
          centerTitle: true,
          backgroundColor: CeksantapColors.primary,
          elevation: 4,
          toolbarHeight: 50,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
        ),

        body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 500,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 14 : 8,
                      height: _currentPage == index ? 14 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.blue : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeCameraLive(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.videocam, size: 24),
                    label: const Text("Live Camera"),
                    style: CeksantapTheme.elevatedButtonStyle(background: CeksantapColors.primary),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PickerCameraScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.photo_library, size: 24),
                    label: const Text("Pilih Gambar"),
                    style: CeksantapTheme.outlinedButtonStyle(borderColor: CeksantapColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
