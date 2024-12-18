import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_equran/domain/entities/ayat_entity.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_bloc.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_state.dart';
import 'package:my_equran/presentation/surahpage/item/item_surah.dart';

class DetailSurahPage extends StatefulWidget {
  DetailSurahPage({super.key, required this.surahName, required this.noSurah});

  final String surahName;
  final int noSurah;

  @override
  State<DetailSurahPage> createState() => _DetailSurahPageState();
}

class _DetailSurahPageState extends State<DetailSurahPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsurahBloc>().getDetailSurah(widget.noSurah);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.surahName)),
        body: BlocConsumer<DetailsurahBloc, DetailsurahState>(
          listener: (context, state) {
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            }
          },
          builder: (context, state) {
            return state.isloading!
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    color: Colors.white70,
                    child: detailSurah(state),
                  );
          },
        ));
  }

  Widget detailSurah(DetailsurahState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.surah?.nama ?? "-",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              state.surah?.namaLatin ?? "-",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              state.surah?.arti ?? "-",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
            ),
            Html(data: state.surah?.deskripsi ?? "",),
            ListView.builder(
                          itemBuilder: (context, index) {
            AyatEntity ayat = state.surah!.ayatEntity![index];
            return Column(
              children: [
                Text(ayat.textArab),
                Text(ayat.textLatin),
                Text(ayat.textIndonesia),
              ],
            );
                          },
                          itemCount: state.surah?.ayatEntity?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        )
          ],
        ),
      ),
    );
  }

  List<TextSpan> parseDynamicText(String text) {
    final List<TextSpan> spans = [];
    final RegExp regex = RegExp(r"<i>(.*?)<\/i>|<br>|([^<]+)");
    final matches = regex.allMatches(text);

    for (final match in matches) {
      if (match.group(1) != null) {
        // Handle <i> italic text
        spans.add(TextSpan(
          text: match.group(1),
          style: TextStyle(fontStyle: FontStyle.italic),
        ));
      } else if (match.group(0) == '<br>') {
        // Handle <br> as a line break
        spans.add(TextSpan(text: '\n\n'));
      } else if (match.group(2) != null) {
        // Handle regular text
        spans.add(TextSpan(text: match.group(2)));
      }
    }

    return spans;
  }
}
