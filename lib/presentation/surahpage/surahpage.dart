import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';
import 'package:my_equran/presentation/surahpage/bloc/listsurahbloc.dart';
import 'package:my_equran/presentation/surahpage/bloc/listsurahstate.dart';
import 'package:my_equran/presentation/surahpage/item/item_surah.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  double? scrollPosition;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    if (scrollPosition != null) {
      scrollController.jumpTo(scrollPosition!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SurahBloc>().getListSurah();
    });
  }

  @override
  void dispose() {
    scrollPosition = scrollController.position.pixels;
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<SurahBloc, SurahState>(
      listener: (context, state) {
        if (state.surah.isEmpty && (!state.isLoading!)) {
          context
              .read<SurahBloc>()
              .getListSurah(); // Trigger fetch on first load
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('E-Quran'),
          ),
          body: state.isLoading!
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(color: Colors.white70, child: listOfSurah(state)),
        );
      },
    );
  }

  Widget listOfSurah(SurahState surahState) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          SurahEntity surah = surahState.surah[index];
          return ItemSurah(
              surahEntity: surah,
              onTap: () {
                print(surah.namaLatin);
              });
        },
        controller: scrollController,
        itemCount: surahState.surah.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
