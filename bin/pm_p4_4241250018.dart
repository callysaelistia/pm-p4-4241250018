import 'package:pm_p4_4241250018/model.dart';
import 'package:pm_p4_4241250018/perpustakaan.dart';

Future<void> main() async {
  final perpus = Perpustakaan('Perpustakaan FMIPA');
  perpus.log.listen((pesan) => print('[LOG] $pesan'));

  perpus
      .tambah(Buku('B01', 'Dasar-Dasar Dart', 'A. Siregar'))
      .tambah(Majalah('M01', 'Majalah Teknologi', 112))
      .tambah(EBook('E01', 'Flutter in Action', 'Eric Windmill', 'https://contoh.id/e01'))
      .tambah(Skripsi('S01', 'Sistem Informasi Kampus', 'Budi Santoso'));

  for (final item in perpus.koleksiTersedia) {
    print('${ikon(item)} ${item.info()}');
  }

  final butet = Anggota('A01', 'Butet', maksPinjam: 1);
  final ucok = Anggota('A02', 'Ucok');

  final p1 = await perpus.pinjam(butet, 'B01', tanggal: DateTime(2026, 10, 1));
  print('Jatuh tempo: ${p1.jatuhTempo}');

  for (final (anggota, kode) in [
    (ucok, 'B01'),
    (butet, 'M01'),
    (ucok, 'X99'),
    (ucok, 'S01'),
  ]) {
    try {
      await perpus.pinjam(anggota, kode);
    } on PeminjamanGagal catch (e) {
      print(e);
    }
  }

  final denda = perpus.kembalikan(p1, tanggal: DateTime(2026, 10, 18));
  print('Denda: Rp$denda');
  print('Tersedia: ${perpus.koleksiTersedia.map((k) => k.judul).join(', ')}');

  await Future.delayed(const Duration(milliseconds: 50));
  await perpus.tutup();
}