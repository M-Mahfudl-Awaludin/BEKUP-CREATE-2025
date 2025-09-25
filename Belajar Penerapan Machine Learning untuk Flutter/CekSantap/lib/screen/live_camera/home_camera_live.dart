import 'package:ceksantap/provider/live_camera/image_classification_provider.dart';
import 'package:ceksantap/screen/live_camera/classification_item.dart';
import 'package:ceksantap/screen/live_camera/live_camera_view.dart';
import 'package:ceksantap/service/image_classification_service.dart';
import 'package:ceksantap/style/theme/ceksantap_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCameraLive extends StatelessWidget {
  const HomeCameraLive({
    super.key,
  });

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
      body: ColoredBox(
        color: Colors.black,
        child: Center(
          child: MultiProvider(
            providers: [
              Provider(
                create: (context) => ImageClassificationService(),
              ),
              ChangeNotifierProvider(
                create: (context) => ImageClassificationProvider(
                  context.read<ImageClassificationService>(),
                ),
              ),
            ],
            child: _HomeBody(),
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  late final readViewmodel = context.read<ImageClassificationProvider>();

  @override
  void dispose() {
    Future.microtask(() async => await readViewmodel.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LiveCameraView(
          onImage: (cameraImage) async {
            await readViewmodel.runClassification(cameraImage);
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: Consumer<ImageClassificationProvider>(
            builder: (_, updateViewmodel, __) {
              final classifications = updateViewmodel.classifications.entries;

              if (classifications.isEmpty) {
                return const SizedBox.shrink();
              }
              return SingleChildScrollView(
                child: Card(
                  color: Colors.black.withValues(alpha: 0.6),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: classifications
                          .map(
                            (classification) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: ClassificatioinItem(
                            item: classification.key,
                            value: classification.value.toStringAsFixed(2),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}