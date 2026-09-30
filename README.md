# Aplikasi Manajemen Data Mahasiswa (Flutter)

Aplikasi Flutter untuk pengelolaan data mahasiswa secara lokal menggunakan `StatefulWidget`, `setState()`, dan `ListView.builder` tanpa dependensi eksternal (murni Flutter SDK).

---

## 📌 Fitur Aplikasi Sesuai Tahapan Tugas

| Tahap | Fitur | Deskripsi |
|---|---|---|
| **Tahap 1** | **Menampilkan Data Mahasiswa** | Menampilkan minimal 5 data mahasiswa awal (NIM, Nama, Prodi, Kelas) menggunakan `ListView.builder` & `Card`. |
| **Tahap 2** | **Menambahkan Data** | Tombol `+ Tambah Mahasiswa`, membuka halaman form (`TextFormField`, `TextEditingController`), dan menambah data ke `List`. |
| **Tahap 3** | **Validasi Form** | Form memiliki validasi agar NIM, Nama, Program Studi, dan Kelas tidak boleh kosong. |
| **Tahap 4** | **Detail Mahasiswa** | Navigasi saat card mahasiswa ditekan untuk melihat informasi detail mahasiswa secara lengkap. |
| **Tahap 5** | **Edit Data** | Tombol Edit pada halaman detail yang otomatis memuat data lama dan memperbarui data di list. |
| **Tahap 6** | **Hapus Data** | Tombol Hapus dengan dialog konfirmasi (`AlertDialog` Batal / Hapus). |
| **Tahap 7** | **Pencarian Data** | Search bar interaktif untuk mencari data mahasiswa berdasarkan Nama atau NIM secara langsung. |
| **Bonus 1** | **Filter Program Studi** | Filter chips untuk menyaring data berdasarkan program studi tertentu. |
| **Bonus 2** | **Indikator Total Mahasiswa** | Header counter yang menampilkan `Total Mahasiswa: X` secara dinamis. |
| **Bonus 3** | **Empty State** | Tampilan ramah dan ilustrasi jika daftar kosong atau hasil pencarian tidak ditemukan. |

---

## 📂 Struktur Proyek

```text
baru/
├── lib/
│   ├── main.dart                      # Entry point aplikasi & konfigurasi tema Material 3
│   ├── models/
│   │   └── mahasiswa.dart             # Model data Mahasiswa (NIM, Nama, Prodi, Kelas)
│   └── pages/
│       ├── home_page.dart             # Halaman utama (List, Search, Filter Prodi, Total Counter, Empty State)
│       ├── form_mahasiswa_page.dart   # Halaman Form Tambah & Edit Mahasiswa + Validasi
│       └── detail_mahasiswa_page.dart # Halaman Detail Mahasiswa + Konfirmasi Hapus Dialog
├── pubspec.yaml                       # Konfigurasi dependensi Flutter
└── README.md                          # Dokumentasi proyek & panduan pengumpulan
```

---

## 📸 Panduan Pengambilan 10 Screenshot untuk Laporan

Berikut panduan langkah demi langkah saat menjalankan aplikasi untuk mengambil 10 screenshot sesuai instruksi:

1. **Screenshot 1 (Tahap 1):** Buka aplikasi, ambil screenshot halaman utama yang menampilkan 5 data awal mahasiswa dalam `ListView.builder`.
2. **Screenshot 2 (Tahap 2):** Tekan tombol **+ Tambah Mahasiswa**, isi form dengan data baru (contoh: NIM `231006`, Nama `Farhan Pratama`, Prodi `Informatika`, Kelas `TI-3C`). Ambil screenshot form yang terisi.
3. **Screenshot 3 (Tahap 2):** Tekan tombol **Simpan Mahasiswa**, ambil screenshot daftar mahasiswa di mana data baru sudah muncul pada list.
4. **Screenshot 4 (Tahap 3):** Tekan tombol **+ Tambah Mahasiswa**, kosongkan seluruh isian dan tekan tombol Simpan. Ambil screenshot pesan validasi kesalahan (contoh: `NIM wajib diisi`, `Nama wajib diisi`, dsb).
5. **Screenshot 5 (Tahap 4):** Klik salah satu card mahasiswa dari list, ambil screenshot halaman **Detail Mahasiswa**.
6. **Screenshot 6 (Tahap 5):** Di halaman detail, tekan tombol **Edit Data** (icon pensil). Ambil screenshot form edit yang sudah terisi otomatis dengan data lama.
7. **Screenshot 7 (Tahap 5):** Ubah salah satu data (misal nama diubah), lalu tekan **Simpan Perubahan**. Ambil screenshot data setelah diperbarui.
8. **Screenshot 8 (Tahap 6):** Tekan tombol **Hapus Data** (icon tong sampah), ambil screenshot pop-up **AlertDialog** bertuliskan *"Apakah Anda yakin ingin menghapus data ini?"* dengan tombol Batal dan Hapus.
9. **Screenshot 9 (Tahap 6):** Tekan tombol **Hapus** pada dialog, ambil screenshot daftar mahasiswa setelah data tersebut berhasil dihapus (muncul notifikasi SnackBar).
10. **Screenshot 10 (Tahap 7):** Ketikkan nama mahasiswa (misal: `Andi`) atau NIM (misal: `231001`) pada kolom pencarian. Ambil screenshot hasil pencarian yang terfilter.

---

## 🚀 Cara Menjalankan Aplikasi

1. Buka terminal pada folder proyek:
   ```bash
   flutter pub get
   ```
2. Jalankan aplikasi di emulator atau browser/perangkat:
   ```bash
   flutter run
   ```
   *(Atau pilih device Chrome dengan `flutter run -d chrome`)*

---

## 📦 Panduan Upload ke GitHub

1. Inisialisasi Git:
   ```bash
   git init
   git add .
   git commit -m "feat: Implementasi lengkap Aplikasi Manajemen Data Mahasiswa CRUD Lokal"
   ```
2. Hubungkan ke repository GitHub Anda:
   ```bash
   git remote add origin <URL_REPOSITORY_GITHUB_ANDA>
   git branch -M main
   git push -u origin main
   ```
