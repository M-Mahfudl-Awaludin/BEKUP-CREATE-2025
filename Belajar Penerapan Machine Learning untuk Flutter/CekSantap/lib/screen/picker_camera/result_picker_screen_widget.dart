import 'dart:io';
import 'package:ceksantap/style/theme/ceksantap_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../../provider/picker_camera/result_provider.dart';
import '../../static/tflite_service.dart';
import 'gemini_nutrition_card.dart';
import 'meal_card.dart';


class ResultPickerScreenWidget extends StatefulWidget {
  final String imagePath;
  const ResultPickerScreenWidget({super.key, required this.imagePath});

  @override
  State<ResultPickerScreenWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultPickerScreenWidget> {
  Map<String, dynamic>? _result;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _runInference();
  }

  void _runInference() async {
    final tflite = TFLiteService();
    await tflite.loadModel();
    final res = await tflite.classifyImage(widget.imagePath);
    if (mounted) {
      setState(() {
        _result = res;
        _loading = false;
      });
      final foodName = res['result'] ?? '';
      if (foodName.isNotEmpty) {
        context.read<ResultProvider>().fetchMeal(foodName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ResultProvider>();

    return Scaffold(
        appBar: AppBar(
        title: const Text(
        "CekSantap Result",
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: widget.imagePath,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(widget.imagePath),
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Result: ${_result?['result'] ?? 'Unknown'}",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Confidence: ${_result?['confidence']?.toStringAsFixed(2) ?? '0'}%",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 24),

              // 🔹 TabBar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TabBar(
                  indicator: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black87,
                  tabs: [
                    Tab(icon: Icon(Icons.restaurant_menu), text: "Nutrisi"),
                    Tab(icon: Icon(Icons.info), text: "Informasi"),
                  ],
                ),
              ),
              const SizedBox(height: 5),

              SizedBox(
                height: 600,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: GeminiNutritionCard(
                        nutrition: provider.nutrition,
                        isLoading: provider.isLoading,
                        error: provider.error,
                      ),
                    ),

                    SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: provider.isLoading || provider.meal == null
                          ? const Center(
                        child: Text(
                          "Tidak ada informasi",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                          : MealCard(meal: provider.meal!),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}