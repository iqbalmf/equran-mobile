import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/domain/entities/ayat_entity.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_bloc.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_state.dart';
import 'package:my_equran/presentation/detailsurahpage/item/ayat_item.dart';
import 'package:my_equran/presentation/detailsurahpage/item/detail_header.dart';
import 'package:my_equran/presentation/tafsirsurahpage/tafsir_surah_page.dart';

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
            Stack(
              children: [
                DetailHeader(surah: state.surah),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      // todo play audio surah
                      print("play audio");
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () {
                      //todo go to tafsir
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TafsirSurahPage(
                                  surahName: state.surah?.namaLatin ?? "",
                                  noSurah: state.surah?.id ?? -1)));
                    },
                    child: Image.asset(
                      'assets/open-book.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                AyatEntity ayat = state.surah!.ayatEntity![index];
                return AyatItem(ayatEntity: ayat);
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
}
