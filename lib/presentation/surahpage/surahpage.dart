import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';
import 'package:my_equran/presentation/detailsurahpage/detail_surah_page.dart';
import 'package:my_equran/presentation/surahpage/bloc/listsurahbloc.dart';
import 'package:my_equran/presentation/surahpage/bloc/listsurahstate.dart';
import 'package:my_equran/presentation/surahpage/item/item_surah.dart';
import 'package:my_equran/utils/network_status.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollPosition != null) {
        scrollController.jumpTo(scrollPosition!);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context
          .read<SurahBloc>()
          .getListSurah(await NetworkStatus.isNetworkOnline());
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
        if (state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }
        if(state.surah.isNotEmpty){
          filterSurah = state.surah;
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

  List<SurahEntity> filterSurah = [];
  Future<void> searchSurah(String search, {List<SurahEntity>? listSurat}) async {
      setState(() {
        filterSurah = listSurat
            ?.where((surah) =>
            surah.namaLatin.toLowerCase().contains(search.toLowerCase()))
            .toList() ?? [];
      });
  }

  Widget listOfSurah(SurahState surahState) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            onChanged: (q) => searchSurah(q, listSurat: surahState.surah),
            decoration: InputDecoration(
              hintText: "Search",
              prefix: Icon(Icons.search),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                SurahEntity surah = filterSurah[index];
                return ItemSurah(
                    surahEntity: surah,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailSurahPage(
                                      surahName: surah.namaLatin, noSurah: surah.id)
                          )
                      );

                    });
              },
              itemCount: filterSurah.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
