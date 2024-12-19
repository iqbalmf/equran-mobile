import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/domain/entities/tafsir_entity.dart';
import 'package:my_equran/presentation/tafsirsurahpage/bloc/tafsir_bloc.dart';
import 'package:my_equran/presentation/tafsirsurahpage/bloc/tafsir_state.dart';
import 'package:my_equran/presentation/tafsirsurahpage/item/tafsir_item.dart';

class TafsirSurahPage extends StatefulWidget {
  final String surahName;
  final int noSurah;

  const TafsirSurahPage(
      {super.key, required this.surahName, required this.noSurah});

  @override
  State<TafsirSurahPage> createState() => _TafsirSurahPageState();
}

class _TafsirSurahPageState extends State<TafsirSurahPage> {
  @override
  void initState() {
    super.initState();
    context.read<TafsirBloc>().getTafsirSurah(widget.noSurah);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.surahName)),
      body: BlocConsumer<TafsirBloc, TafsirState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          return state.isLoading!
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.white70,
                  child: detailTafsir(state),
                );
        },
      ),
    );
  }

  Widget detailTafsir(TafsirState tafsir) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        itemBuilder: (context, index) {
          TafsirEntity tafsirEntity = tafsir.surah!.tafsirEntity![index];
          return TafsirItem(tafsirEntity: tafsirEntity,);
        },
        itemCount: tafsir.surah?.tafsirEntity?.length ?? 0,
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }
}
