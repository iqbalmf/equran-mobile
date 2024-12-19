import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';

class DetailHeader extends StatelessWidget {
  final SurahEntity? surah;

  const DetailHeader({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      decoration: BoxDecoration(
        color: Colors.white70, // Background color
        border: Border.all(
          color: Colors.black12,
          width: 3.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            surah?.namaLatin ?? 'nama_surah',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            surah?.nama ?? 'arabic',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.normal),
          ),
          Text(
            surah?.arti ?? 'arti',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic),
          ),
          Html(data: surah?.deskripsi ?? 'deskripsi')
        ],
      ),
    );
  }
}
