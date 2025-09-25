# gowaroenk

## Testing
### Unit Test Provider
1. LocalDatabaseProvider (Bookmark)
- Tujuan: Mengelola daftar favorit restoran menggunakan database lokal.
- Mock: LocalDatabaseService
- Test Cases:
1. loadFavorites : Memastikan data favorit dimuat dari database dan notifyListeners terpanggil.
2. addFavorite : Menambah restoran ke database dan memperbarui daftar _favorites.
3. removeFavorite : Menghapus restoran dari database dan memperbarui daftar _favorites.
4. isFavorite : Mengembalikan true jika restoran ada di database.
5. isFavorite : Mengembalikan false jika restoran tidak ada.
   ✅ Semua test dijalankan menggunakan mock tanpa akses database nyata.

2. RestaurantListProvider (Home / Daftar Restoran)
- Tujuan: Menampilkan daftar restoran dan fitur pencarian.
- Mock: ApiServices
- Test Cases:
1. Initial State : Harus RestaurantListNoneState.
2. fetchRestaurantList berhasil : Mengembalikan RestaurantListLoadedState dengan data restoran.
3. fetchRestaurantList gagal : Mengembalikan RestaurantListErrorState dengan pesan error.
4. searchRestaurant berhasil : Mengembalikan RestaurantListLoadedState sesuai query.
5. searchRestaurant gagal : Mengembalikan RestaurantListErrorState jika data tidak ditemukan.
6. searchRestaurant dengan query kosong : Memanggil fetchRestaurantList dan memuat semua restoran.
   ✅ Test mencakup alur sukses, gagal, dan behavior pencarian.

3. RestaurantDetailProvider (Detail Restoran)
- Tujuan: Menampilkan detail restoran.
- Mock: ApiServices
- Test Cases:
1. Initial State : Harus RestaurantDetailNoneState.
2. fetchRestaurantDetail berhasil : Mengembalikan RestaurantDetailLoadedState dengan detail restoran.
3. fetchRestaurantDetail gagal (API error) : Mengembalikan RestaurantDetailErrorState dengan pesan dari API.
4. fetchRestaurantDetail exception : Mengembalikan RestaurantDetailErrorState dengan pesan default jika terjadi exception (misal: no internet).
   ✅ Test mencakup kondisi normal, error API, dan exception jaringan.

4. AddReviewRestaurantProvider (Tambah Review)
- Tujuan: Menambah review restoran.
- Mock: ApiServices
- Test Cases:
1. Initial State : Harus ReviewState.idle.
2. addReview berhasil : Mengembalikan ReviewState.success dan menambahkan review.
3. addReview gagal (exception) : Mengembalikan ReviewState.error.
4. resetState : Mengembalikan state ke ReviewState.idle.
   ✅ Test mencakup state awal, sukses menambah review, error saat menambah review, dan reset state.

### Widget Test

1. **BookmarkScreen**
- Tujuan: Menampilkan daftar restoran favorit dan navigasi ke detail restoran.
- Mock: `LocalDatabaseProvider`
- Test Cases:
   1. Favorites kosong:
      - Memastikan teks "No Bookmarked Restaurant" muncul.
      - Memastikan widget `Lottie` / `Column` muncul sebagai indikator kosong.
   2. Favorites ada:
      - Menampilkan list restoran sesuai data mock.
      - Memastikan `RestaurantCard` muncul sesuai jumlah restoran.
   3. Navigasi ke DetailScreen:
      - Tap pada `RestaurantCard`.
      - Memastikan navigasi menggunakan `Navigator.pushNamed` dengan argumen restoran yang benar.

2. **HomeScreen**
- Tujuan: Menampilkan daftar restoran dan fitur pencarian.
- Mock: `RestaurantListProvider`
- Test Cases:
   1. Loading State:
      - Mock state `RestaurantListLoadingState`.
      - Memastikan widget `Lottie` loading muncul.
   2. Loaded State:
      - Mock state `RestaurantListLoadedState` dengan data restoran.
      - Memastikan daftar restoran ditampilkan di `ListView`.
      - Memastikan nama restoran muncul sesuai data.
   3. Error State:
      - Mock state `RestaurantListErrorState`.
      - Memastikan teks error muncul.
      - Memastikan widget `Lottie` error muncul.
   4. Pencarian restoran:
      - Masukkan query di `TextField`.
      - Pastikan `searchRestaurant` terpanggil sesuai query.
      - Verifikasi behavior debounce berjalan (500-600ms).

3. **SplashScreen**
- Tujuan: Menampilkan logo dan otomatis navigasi ke MainScreen.
- Test Cases:
   1. Memastikan `Image` logo muncul.
   2. Memastikan navigasi ke MainScreen setelah delay (misal 3 detik).
   3. Verifikasi screen tujuan muncul dengan teks / widget yang sesuai.

4. **HomeScreen Direct (tanpa SplashScreen)**
- Tujuan: Menampilkan HomeScreen langsung menggunakan mock provider.
- Test Cases:
   1. Mock state `RestaurantListLoadedState` dengan 1 restoran.
   2. Memastikan `HomeScreen` muncul.
   3. Memastikan nama restoran muncul di layar.

### Integration Test 

