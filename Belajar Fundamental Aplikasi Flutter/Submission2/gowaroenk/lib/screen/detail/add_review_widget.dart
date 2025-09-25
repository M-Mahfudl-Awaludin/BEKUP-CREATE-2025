import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:gowaroenk/provider/detail/add_review_restaurant_provider.dart';

class AddReviewWidget extends StatelessWidget {
  final String restaurantId;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  AddReviewWidget({super.key, required this.restaurantId});

  void _submitReview(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<AddReviewRestaurantProvider>(); // simpan dulu

    await provider.addReview(
      restaurantId,
      _nameController.text,
      _reviewController.text,
    );

    if (provider.state == ReviewState.success) {
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) { // pastikan masih mounted
          Navigator.pop(context, true);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Review")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<AddReviewRestaurantProvider>(
          builder: (context, provider, _) {
            Widget content;

            switch (provider.state) {
              case ReviewState.loading:
                content = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/Trail_loading.json", height: 150),
                      const SizedBox(height: 16),
                      const Text("Mengirim review...", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                );
                break;

              case ReviewState.success:
                content = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/Success_animation.json", height: 150),
                      const SizedBox(height: 16),
                      const Text(
                        "Review berhasil dikirim!",
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                    ],
                  ),
                );
                break;

              case ReviewState.error:
                content = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/Error.json", height: 150),
                      const SizedBox(height: 16),
                      const Text(
                        "Gagal menambahkan review",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          provider.resetState();
                        },
                        child: const Text("Ulangi"),
                      ),
                    ],
                  ),
                );
                break;

              case ReviewState.idle:
              content = Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "Nama",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? "Nama wajib diisi" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _reviewController,
                        decoration: const InputDecoration(
                          labelText: "Review",
                          border: OutlineInputBorder(),
                        ),
                        minLines: 3,
                        maxLines: 5,
                        validator: (value) =>
                        value == null || value.isEmpty ? "Review wajib diisi" : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => _submitReview(context),
                        child: const Text("Kirim"),
                      ),
                    ],
                  ),
                );
                break;
            }

            return content;
          },
        ),
      ),
    );
  }
}
