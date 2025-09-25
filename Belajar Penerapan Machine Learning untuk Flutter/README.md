# BEKUP-CREATE-2025
**ini adalah repository project saya selama mengikuti program BEKUP CREATE 2025 Multi-Platform App dengan Flutter**


# Submission: Food Recognizer App

Selamat datang di submission **Food Recognizer App** 🎉  
Pada submission ini, Anda akan membangun aplikasi Flutter yang dapat mengambil gambar, melakukan inferensi machine learning untuk mengenali makanan, dan menampilkan halaman prediksi dengan detail informasi terkait makanan tersebut.  

Setiap kriteria bernilai **0–4 points**. Untuk lulus, Anda harus mendapatkan minimal **2 points pada setiap kriteria**.  
Submission akan **ditolak** jika masih terdapat kriteria dengan nilai **0 point**.  

---

## 🎯 Kriteria Submission

### Kriteria 1: Penerapan Fitur Pengambilan Gambar
Anda diminta membuat fitur untuk mengambil gambar dari galeri atau kamera.  

**Kompetensi yang dicapai:**
- Implementasi `image_picker` untuk mengambil gambar dari galeri/kamera.  
- Implementasi `camera` untuk custom camera.  

**Ketentuan Penilaian:**
- **Reject (0 pts):**
  - Tidak ada fitur pengambilan gambar.  
  - Aplikasi gagal meminta izin akses kamera/galeri.  
  - Error saat inisialisasi kamera atau membuka galeri.  
  - Gambar corrupt/tidak valid.  
- **Basic (2 pts):**  
  - Memakai `image_picker` untuk ambil gambar dari kamera.  
  - Gambar tampil di halaman aplikasi.  
- **Skilled (3 pts):**  
  - Memenuhi ketentuan sebelumnya.  
  - Menambahkan fitur crop dengan `image_cropper`.  
- **Advanced (4 pts):**  
  - Memenuhi ketentuan sebelumnya.  
  - Menambahkan fitur identifikasi gambar secara **real-time** dengan `camera` (camera stream/feed).  

---

### Kriteria 2: Penerapan Fitur Machine Learning
Anda diminta mengintegrasikan model ML **Food Classification** (TensorFlow Lite) untuk mengenali makanan.  

**Kompetensi yang dicapai:**
- Integrasi TensorFlow Lite untuk inferensi gambar.  
- Alternatif: menyimpan model di cloud dengan Firebase ML.  

**Ketentuan Penilaian:**
- **Reject (0 pts):**
  - Tidak menggunakan model yang disediakan.  
  - Aplikasi crash saat inferensi.  
  - Tidak menyertakan berkas config (GoogleService-Info.plist / google-services.json / firebase_options.dart) jika menggunakan Firebase ML.  
- **Basic (2 pts):**  
  - Menggunakan model classifier yang disediakan.  
  - Mengintegrasikan model dengan aplikasi (LiteRT/TFLite).  
  - Proses inferensi bisa dilakukan setelah gambar diambil atau secara real-time.  
- **Skilled (3 pts):**  
  - Memenuhi ketentuan sebelumnya.  
  - Menjalankan inferensi di background thread dengan `Isolate` agar UI tidak freeze.  
- **Advanced (4 pts):**  
  - Memenuhi ketentuan sebelumnya.  
  - Menggunakan **Firebase ML** untuk menyimpan & mengunduh model secara dinamis.  

---

### Kriteria 3: Menyediakan Halaman Prediksi
Anda diminta membuat halaman hasil prediksi yang menampilkan informasi detail makanan.  

**Kompetensi yang dicapai:**
- Memberikan informasi hasil deteksi makanan.  
- Memperkaya data dengan API eksternal (MealDB, Gemini API).  

**Ketentuan Penilaian:**
- **Reject (0 pts):**
  - Tidak ada halaman informasi detail.  
  - Halaman kosong/tidak relevan dengan hasil deteksi.  
- **Basic (2 pts):**  
  - Menyediakan halaman detail setelah proses deteksi.  
  - Menampilkan:
    - Gambar yang diambil pengguna  
    - Nama makanan hasil prediksi ML  
    - Confidence score (%)  
  - Tata letak sederhana dan mudah dibaca.  
- **Skilled (3 pts):**  
  - Memenuhi ketentuan sebelumnya.  
  - Menambahkan referensi dari **MealDB API** berdasarkan nama makanan hasil inferensi.  
  - Informasi minimal:  
    - Nama makanan (`strMeal`)  
    - Foto makanan (`strMealThumb`)  
    - Bahan + takaran (`strIngredientX`, `strMeasureX`)  
    - Langkah pembuatan (`strInstructions`)  
- **Advanced (4 pts):**  
  - Memenuhi ketentuan sebelumnya.  
  - Menambahkan informasi nutrisi dari **Gemini API** berdasarkan nama makanan hasil inferensi.  
  - Informasi minimal:  
    - Kalori  
    - Karbohidrat  
    - Lemak  
    - Serat  
    - Protein  
  - **Tidak wajib** menyematkan API Key di project.  

---

## ✅ Syarat Kelulusan
- Minimal **2 points pada setiap kriteria**.  
- Tidak ada kriteria yang bernilai **0 point**.  
- Aplikasi berjalan tanpa error/crash.  
- Halaman prediksi menampilkan informasi dengan jelas dan rapi.  

---

## 🚀 Cara Menjalankan
1. Pastikan Flutter SDK sudah terinstall.  
2. Clone atau download repository ini.  
3. Jalankan perintah berikut di terminal:  

```bash
flutter pub get
flutter run
