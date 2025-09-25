# BEKUP-CREATE-2025
**ini adalah repository project saya selama mengikuti program BEKUP CREATE 2025 Multi-Platform App dengan Flutter**


# Submission: Proyek Akhir - Favorite Restaurant App

Selamat datang di submission **Proyek Akhir: Favorite Restaurant App** 🎉  
Submission ini adalah kelanjutan dari **Proyek Awal: Restaurant App dengan API**.  
Pastikan seluruh kriteria berikut terpenuhi agar submission Anda diterima.  

---

## 🎯 Kriteria Submission

### 1. Mempertahankan Kriteria Utama
- Semua kriteria dari submission sebelumnya (**Restaurant App dengan API**) harus tetap dipertahankan.  

---

### 2. Halaman Favorit Restoran
- Membuat **satu halaman khusus** berisi daftar restoran favorit.  
- Informasi minimal yang ditampilkan pada setiap item card:  
  - Nama restoran  
  - Gambar restoran  
  - Kota  
  - Rating  
- Apabila item favorit ditekan, aplikasi harus **berpindah ke halaman detail restoran**.  
- Pengguna dapat **menambahkan** dan **menghapus** restoran dari daftar favorit (baik dari halaman detail maupun daftar favorit).  
- Informasi daftar favorit harus disimpan di **SQLite Database**.  

---

### 3. Pengaturan Tema
- Menambahkan menu untuk mengganti **tema terang (light)** dan **tema gelap (dark)**.  
- Simpan perubahan tema menggunakan **SharedPreferences**.  
- Tema harus tetap tersimpan walaupun aplikasi ditutup dan dibuka kembali.  
- Pastikan setiap komponen aplikasi tetap terbaca dengan baik pada kedua tema.  

---

### 4. Fitur Daily Reminder
- Menambahkan pengaturan untuk **menghidupkan** dan **mematikan reminder** di halaman **Settings**.  
- Simpan pengaturan reminder menggunakan **SharedPreferences**.  
- Reminder harus menampilkan **notifikasi pada pukul 11.00 AM** dengan memanfaatkan **Scheduled Notification**.  
- Notifikasi berfungsi untuk mengingatkan pengguna mengenai makan siang.  

---

### 5. Pengujian (Testing)
- Terapkan minimal **tiga skenario pengujian** pada fungsi di dalam **Provider** untuk mengambil daftar restoran.  
- Skenario yang harus diuji:  
  1. Memastikan **state awal provider** sudah terdefinisi.  
  2. Memastikan **daftar restoran berhasil dikembalikan** ketika pengambilan data API sukses.  
  3. Memastikan **kesalahan dikembalikan** ketika pengambilan data API gagal.  

---

## ✅ Syarat Kelulusan
- Semua kriteria di atas harus terpenuhi.  
- Aplikasi dapat dijalankan tanpa error.  
- Tidak ada tampilan overflow.  
- Tema dan reminder tersimpan dengan baik setelah aplikasi ditutup dan dibuka kembali.  
- Pengujian harus berjalan sukses.  

---

## 🚀 Cara Menjalankan
1. Pastikan Flutter SDK sudah terinstall.  
2. Clone atau download repository ini.  
3. Jalankan perintah berikut di terminal:  

```bash
flutter pub get
flutter run
