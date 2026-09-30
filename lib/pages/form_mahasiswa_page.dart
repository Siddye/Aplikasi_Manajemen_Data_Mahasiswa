import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';

class FormMahasiswaPage extends StatefulWidget {
  final Mahasiswa? mahasiswa;

  const FormMahasiswaPage({super.key, this.mahasiswa});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nimController;
  late TextEditingController _namaController;
  late TextEditingController _prodiController;
  late TextEditingController _kelasController;

  bool get isEditing => widget.mahasiswa != null;

  final List<String> _daftarProdi = [
    'Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Teknologi Rekayasa Multimedia',
  ];

  @override
  void initState() {
    super.initState();
    _nimController = TextEditingController(text: widget.mahasiswa?.nim ?? '');
    _namaController = TextEditingController(text: widget.mahasiswa?.nama ?? '');
    _prodiController = TextEditingController(text: widget.mahasiswa?.prodi ?? '');
    _kelasController = TextEditingController(text: widget.mahasiswa?.kelas ?? '');
  }

  @override
  void dispose() {
    _nimController.dispose();
    _namaController.dispose();
    _prodiController.dispose();
    _kelasController.dispose();
    super.dispose();
  }

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      final mahasiswaHasil = Mahasiswa(
        nim: _nimController.text.trim(),
        nama: _namaController.text.trim(),
        prodi: _prodiController.text.trim(),
        kelas: _kelasController.text.trim(),
      );

      Navigator.pop(context, mahasiswaHasil);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Data Mahasiswa' : 'Form Tambah Mahasiswa'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primary,
                      child: Icon(
                        isEditing ? Icons.edit_note_rounded : Icons.person_add_rounded,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isEditing ? 'Perbarui Data Mahasiswa' : 'Tambah Mahasiswa Baru',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isEditing
                                ? 'Ubah informasi formulir di bawah lalu simpan perubahan.'
                                : 'Lengkapi semua data mahasiswa pada formulir di bawah ini.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form Field: NIM
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(
                  labelText: 'NIM',
                  hintText: 'Contoh: 231001',
                  prefixIcon: const Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Form Field: Nama
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: 'Contoh: Andi Saputra',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Form Field: Program Studi
              TextFormField(
                controller: _prodiController,
                decoration: InputDecoration(
                  labelText: 'Program Studi',
                  hintText: 'Contoh: Informatika',
                  prefixIcon: const Icon(Icons.school_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  suffixIcon: PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    tooltip: 'Pilih Prodi Cepat',
                    onSelected: (String prodi) {
                      setState(() {
                        _prodiController.text = prodi;
                      });
                    },
                    itemBuilder: (context) => _daftarProdi
                        .map(
                          (prodi) => PopupMenuItem<String>(
                            value: prodi,
                            child: Text(prodi),
                          ),
                        )
                        .toList(),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Program Studi wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Form Field: Kelas
              TextFormField(
                controller: _kelasController,
                decoration: InputDecoration(
                  labelText: 'Kelas',
                  hintText: 'Contoh: TI-3A',
                  prefixIcon: const Icon(Icons.meeting_room_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kelas wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Button Simpan
              ElevatedButton.icon(
                onPressed: _simpanData,
                icon: Icon(isEditing ? Icons.check_circle_outline : Icons.save_rounded),
                label: Text(
                  isEditing ? 'Simpan Perubahan' : 'Simpan Mahasiswa',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
