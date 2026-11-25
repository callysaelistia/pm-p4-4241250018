sealed class Koleksi {
  final String kode;
  final String judul;
  bool _dipinjam = false;

  Koleksi(this.kode, this.judul);

  int get lamaPinjam;
  bool get tersedia => !_dipinjam;

  /// Mengubah status peminjaman lewat method publik agar aman dari luar library
  void ubahStatusPinjam(bool dipinjam) {
    _dipinjam = dipinjam;
  }

  String info() => '[$kode] $judul';
}

mixin BisaDiunduh {
  String get url;
  String unduh() => 'Mengunduh dari $url ...';
}

class Buku extends Koleksi {
  final String penulis;
  Buku(super.kode, super.judul, this.penulis);

  @override
  int get lamaPinjam => 14;

  @override
  String info() => '${super.info()} oleh $penulis';
}

class Majalah extends Koleksi {
  final int edisi;
  Majalah(super.kode, super.judul, this.edisi);

  @override
  int get lamaPinjam => 7;

  @override
  String info() => '${super.info()} edisi $edisi';
}

class EBook extends Buku with BisaDiunduh {
  @override
  final String url;
  EBook(super.kode, super.judul, super.penulis, this.url);

  @override
  int get lamaPinjam => 30;
}

class Skripsi extends Koleksi {
  final String penulis;
  Skripsi(super.kode, super.judul, this.penulis);

  @override
  int get lamaPinjam => 0;

  @override
  String info() => '${super.info()} oleh $penulis (baca di tempat)';
}

class Anggota {
  final String id;
  final String nama;
  final int maksPinjam;

  Anggota(this.id, this.nama, {this.maksPinjam = 2});
}

class Peminjaman {
  final Anggota anggota;
  final Koleksi koleksi;
  final DateTime tanggal;

  Peminjaman(this.anggota, this.koleksi, this.tanggal);

  DateTime get jatuhTempo => tanggal.add(Duration(days: koleksi.lamaPinjam));

  int dendaPada(DateTime kembali) {
    final telat = kembali.difference(jatuhTempo).inDays;
    return telat > 0 ? telat * 1000 : 0;
  }
}

class PeminjamanGagal implements Exception {
  final String alasan;
  PeminjamanGagal(this.alasan);

  @override
  String toString() => 'Peminjaman gagal: $alasan';
}

String ikon(Koleksi k) => switch (k) {
      EBook() => '💻',
      Buku() => '📘',
      Majalah() => '📰',
      Skripsi() => '🎓',
    };