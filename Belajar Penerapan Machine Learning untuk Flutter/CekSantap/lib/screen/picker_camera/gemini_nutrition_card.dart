import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../data/model/nutrition_model.dart';

class GeminiNutritionCard extends StatelessWidget {
  final Nutrition? nutrition;
  final bool isLoading;
  final String? error;

  const GeminiNutritionCard({
    super.key,
    required this.nutrition,
    required this.isLoading,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Lottie.asset(
              'assets/lottie/Trail_loading.json',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    if (error != null) {
      return Card(
        margin: const EdgeInsets.all(8),
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Lottie.asset(
                'assets/lottie/nothing.json',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              Text(
                error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    if (nutrition == null) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.restaurant_menu, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  "Informasi Nutrisi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 14,
              children: [
                _buildNutritionBadge(
                    icon: Icons.local_fire_department,
                    label: "Kalori",
                    value: "${nutrition!.calories} g",
                    color: Colors.redAccent),
                _buildNutritionBadge(
                    icon: Icons.bakery_dining,
                    label: "Karbohidrat",
                    value: "${nutrition!.carbs} g",
                    color: Colors.orangeAccent),
                _buildNutritionBadge(
                    icon: Icons.egg_alt,
                    label: "Protein",
                    value: "${nutrition!.protein} g",
                    color: Colors.green),
                _buildNutritionBadge(
                    icon: Icons.opacity,
                    label: "Lemak",
                    value: "${nutrition!.fat} g",
                    color: Colors.blueAccent),
                _buildNutritionBadge(
                    icon: Icons.eco,
                    label: "Serat",
                    value: "${nutrition!.fiber} g",
                    color: Colors.teal),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildNutritionBadge({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, scale, child) {
        final safeScale = scale.clamp(0.0, 1.0); // biar aman
        return Transform.scale(
          scale: safeScale,
          child: Opacity(
            opacity: safeScale,
            child: child,
          ),
        );
      },
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.15),
              color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}