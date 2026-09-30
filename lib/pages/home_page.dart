import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import 'detail_mahasiswa_page.dart';
import 'form_mahasiswa_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data Awal Mahasiswa (Minimal 5 Data)
  final List<Mahasiswa> _daftarMahasiswa = [
    Mahasiswa(
      nim: '231001',
      nama: 'Andi Saputra',
      prodi: 'Informatika',
      kelas: 'TI-3A',
    ),
    Mahasiswa(
      nim: '231002',
      nama: 'Budi Santoso',
      prodi: 'Informatika',
      kelas: 'TI-3A',
    ),
    Mahasiswa(
      nim: '231003',
      nama: 'Citra Dewi',
      prodi: 'Sistem Informasi',
      kelas: 'SI-3B',
    ),
    Mahasiswa(
      nim: '231004',
      nama: 'Dimas Pratama',
      prodi: 'Teknik Komputer',
      kelas: 'TK-3A',
    ),
    Mahasiswa(
      nim: '231005',
      nama: 'Eka Rahmawati',
      prodi: 'Informatika',
      kelas: 'TI-3B',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedProdi = 'Semua';

  final List<String> _filterProdiList = [
    'Semua',
    'Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter daftar berdasarkan query pencarian dan kategori prodi
  List<Mahasiswa> get _filteredMahasiswa {
    return _daftarMahasiswa.where((mhs) {
      final matchesSearch = mhs.nama.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          mhs.nim.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesProdi = _selectedProdi == 'Semua' || mhs.prodi == _selectedProdi;
      return matchesSearch && matchesProdi;
    }).toList();
  }

  // Navigasi ke Form Tambah Mahasiswa
  void _tambahMahasiswa() async {
    final Mahasiswa? dataBaru = await Navigator.push<Mahasiswa>(
      context,
      MaterialPageRoute(
        builder: (context) => const FormMahasiswaPage(),
      ),
    );

    if (dataBaru != null) {
      setState(() {
        _daftarMahasiswa.add(dataBaru);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mahasiswa ${dataBaru.nama} berhasil ditambahkan!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // Navigasi ke Halaman Detail Mahasiswa
  void _bukaDetail(int indexDiListAsli, Mahasiswa mhs) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMahasiswaPage(mahasiswa: mhs),
      ),
    );

    if (result != null) {
      final action = result['action'] as String?;
      if (action == 'delete') {
        setState(() {
          _daftarMahasiswa.removeAt(indexDiListAsli);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data mahasiswa berhasil dihapus!'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else if (action == 'update') {
        final dataUpdate = result['data'] as Mahasiswa?;
        if (dataUpdate != null) {
          setState(() {
            _daftarMahasiswa[indexDiListAsli] = dataUpdate;
          });
        }
      }
    }
  }

  // Dialog Konfirmasi Hapus langsung dari list item
  void _konfirmasiHapusItem(int indexDiListAsli, Mahasiswa mhs) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 8),
              Text('Hapus Data'),
            ],
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus data mahasiswa "${mhs.nama}" (${mhs.nim})?',
            style: const TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                setState(() {
                  _daftarMahasiswa.removeAt(indexDiListAsli);
                });
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data mahasiswa berhasil dihapus!'),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayedList = _filteredMahasiswa;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school_rounded),
            SizedBox(width: 10),
            Text(
              'Data Mahasiswa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Stats & Search Section
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Info Total Mahasiswa Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.people_alt_rounded,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Total Mahasiswa: ${_daftarMahasiswa.length}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_daftarMahasiswa.isNotEmpty && _filteredMahasiswa.length != _daftarMahasiswa.length)
                      Text(
                        'Hasil filter: ${_filteredMahasiswa.length}',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari nama atau NIM...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Filter Chips Program Studi
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filterProdiList.length,
                    itemBuilder: (context, index) {
                      final prodi = _filterProdiList[index];
                      final isSelected = _selectedProdi == prodi;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(prodi),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedProdi = prodi;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Daftar Mahasiswa (ListView.builder) / Empty State
          Expanded(
            child: displayedList.isEmpty
                ? _buildEmptyState(theme)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: displayedList.length,
                    itemBuilder: (context, index) {
                      final mhs = displayedList[index];
                      final indexDiListAsli = _daftarMahasiswa.indexOf(mhs);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 1.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => _bukaDetail(indexDiListAsli, mhs),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: [
                                // Avatar Inisial
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: _getProdiColor(mhs.prodi).withValues(alpha: 0.15),
                                  child: Text(
                                    mhs.nama.isNotEmpty ? mhs.nama[0].toUpperCase() : '?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _getProdiColor(mhs.prodi),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Mahasiswa Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // NIM & Nama
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: theme.colorScheme.surfaceContainerHighest,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              mhs.nim,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: theme.colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              mhs.nama,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),

                                      // Prodi & Kelas
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.school_outlined,
                                            size: 14,
                                            color: theme.colorScheme.onSurfaceVariant,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            mhs.prodi,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: theme.colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Icon(
                                            Icons.meeting_room_outlined,
                                            size: 14,
                                            color: theme.colorScheme.onSurfaceVariant,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            mhs.kelas,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: theme.colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Menu / Delete Action
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
                                  tooltip: 'Hapus',
                                  onPressed: () => _konfirmasiHapusItem(indexDiListAsli, mhs),
                                ),
                                const Icon(Icons.chevron_right, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahMahasiswa,
        icon: const Icon(Icons.add),
        label: const Text(
          'Tambah Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Widget Empty State jika list kosong
  Widget _buildEmptyState(ThemeData theme) {
    final isFiltering = _searchQuery.isNotEmpty || _selectedProdi != 'Semua';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFiltering ? Icons.search_off_rounded : Icons.folder_open_rounded,
              size: 80,
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              isFiltering ? 'Data tidak ditemukan' : 'Belum ada data mahasiswa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isFiltering
                  ? 'Coba gunakan kata kunci lain atau ubah filter program studi.'
                  : 'Tekan tombol "+ Tambah Mahasiswa" untuk menambahkan data baru.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (isFiltering) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                    _selectedProdi = 'Semua';
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Pencarian'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper warna badge per prodi
  Color _getProdiColor(String prodi) {
    switch (prodi.toLowerCase()) {
      case 'informatika':
        return Colors.indigo;
      case 'sistem informasi':
        return Colors.teal;
      case 'teknik komputer':
        return Colors.deepOrange;
      default:
        return Colors.purple;
    }
  }
}
