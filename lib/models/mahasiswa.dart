class Mahasiswa {
  String nim;
  String nama;
  String prodi;
  String kelas;

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.prodi,
    required this.kelas,
  });

  Mahasiswa copyWith({
    String? nim,
    String? nama,
    String? prodi,
    String? kelas,
  }) {
    return Mahasiswa(
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      prodi: prodi ?? this.prodi,
      kelas: kelas ?? this.kelas,
    );
  }
}
