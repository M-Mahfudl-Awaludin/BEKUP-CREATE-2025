import 'dart:io';
import 'package:ceksantap/screen/picker_camera/result_picker_screen_widget.dart';
import 'package:ceksantap/style/theme/ceksantap_theme.dart';
import 'package:flutter/material.dart';
import 'package:ceksantap/utils/widgets_extension.dart';
import 'package:provider/provider.dart';
import '../../provider/picker_camera/picker_camera_provider.dart';

class PickerCameraScreen extends StatelessWidget {
  const PickerCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PickerCameraProvider(),
      child: const _PickerCameraView(),
    );
  }
}

class _PickerCameraView extends StatelessWidget {
  const _PickerCameraView();

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
      body: const _PickerCameraBody(),
    );
  }
}

class _PickerCameraBody extends StatefulWidget {
  const _PickerCameraBody();

  @override
  State<_PickerCameraBody> createState() => _PickerCameraBodyState();
}

class _PickerCameraBodyState extends State<_PickerCameraBody> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<PickerCameraProvider>();
    provider.addListener(() {
      final message = provider.message;
      if (message != null && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Consumer<PickerCameraProvider>(
                  builder: (_, value, __) {
                    final path = value.imagePath;
                    return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: CeksantapColors.primary.withValues(alpha:0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: CeksantapColors.primary.withValues(alpha:0.5),
                            width: 1.5,
                          ),
                        ),
                        child: path == null
                        ? const Center(
                            child: Icon(Icons.image,
                                size: 100, color: Colors.grey)
                        )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(File(path), fit: BoxFit.contain),
                    )
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              Consumer<PickerCameraProvider>(
                builder: (_, value, __) {
                  final data = value.uploadResponse?.data;
                  if (data == null) return const SizedBox.shrink();
                  return Text(
                    "${data.result} - ${data.confidenceScore.round()}%",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: CeksantapColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),

              const SizedBox(height: 10),

              Row(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => context.read<PickerCameraProvider>().openGallery(),
                    icon: const Icon(Icons.photo_library, size: 20),
                    label: const Text("Gallery", overflow: TextOverflow.ellipsis),
                    style: CeksantapTheme.elevatedButtonStyle(
                      background: CeksantapColors.primary,
                      textColor: Colors.white,
                    ).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => context.read<PickerCameraProvider>().openCamera(),
                    icon: const Icon(Icons.camera_alt, size: 20),
                    label: const Text("Camera", overflow: TextOverflow.ellipsis),
                    style: CeksantapTheme.elevatedButtonStyle(
                      background: CeksantapColors.secondary,
                      textColor: Colors.white,
                    ).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => context.read<PickerCameraProvider>().openCustomCamera(context),
                    icon: const Icon(Icons.camera_enhance, size: 20),
                    label: const Text("Custom", overflow: TextOverflow.ellipsis),
                    style: CeksantapTheme.elevatedButtonStyle(
                      background: CeksantapColors.darkGreen,
                      textColor: Colors.white,
                    ).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      ),
                    ),
                  ),
                ].expanded(), // 👈 cukup ini yang ngasih Expanded ke semua
              ),


              const SizedBox(height: 24),

              // Tombol Analyze full width
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final provider = context.read<PickerCameraProvider>();
                    final path = provider.imagePath;
                    if (path == null) return;

                    setState(() => provider.setUploading(true));

                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResultPickerScreenWidget(imagePath: path),
                        ),
                      );
                    }

                    setState(() => provider.setUploading(false));
                  },
                  icon: const Icon(Icons.analytics_outlined),
                  label: Consumer<PickerCameraProvider>(
                    builder: (_, value, __) {
                      return value.isUploading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : const Text("Analyze");
                    },
                  ),
                  style: CeksantapTheme.elevatedButtonStyle(
                    background: CeksantapColors.primary,
                    textColor: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
