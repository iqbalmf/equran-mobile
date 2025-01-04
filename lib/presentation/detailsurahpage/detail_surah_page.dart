import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/domain/entities/ayat_entity.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_bloc.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_state.dart';
import 'package:my_equran/presentation/detailsurahpage/item/ayat_item.dart';
import 'package:my_equran/presentation/detailsurahpage/item/detail_header.dart';
import 'package:my_equran/presentation/tafsirsurahpage/tafsir_surah_page.dart';
import 'package:my_equran/utils/network_status.dart';

class DetailSurahPage extends StatefulWidget {
  DetailSurahPage({super.key, required this.surahName, required this.noSurah});

  final String surahName;
  final int noSurah;

  @override
  State<DetailSurahPage> createState() => _DetailSurahPageState();
}

class _DetailSurahPageState extends State<DetailSurahPage> {
  late AudioPlayer _audioPlayer;
  bool loadingAudio = false;
  int? _currentPlayingIndex;
  bool _isPlaying = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<DetailsurahBloc>().getDetailSurah(
          widget.noSurah, await NetworkStatus.isNetworkOnline());
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      _playNextAyat();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void playAudioSurah(String audioUrl, int index) async {
    if (_currentPlayingIndex == index && _isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      setState(() {
        _currentPlayingIndex = index;
        _isPlaying = true;
      });
      await _audioPlayer.play(UrlSource(audioUrl));
    }
  }

  void playAudio(String audioUrl) async {
    setState(() {
      loadingAudio = true;
    });
    try {
      await _audioPlayer.play(UrlSource(audioUrl));
      context.read<DetailsurahBloc>().playAudio();
    } catch (e) {
      setState(() {
        loadingAudio = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing audio: $e')),
      );
    } finally {
      setState(() {
        loadingAudio = false;
      });
    }
  }

  void stopAudioAyat() async {
    await _audioPlayer.stop();
    setState(() {
      _currentPlayingIndex = null;
      _isPlaying = false;
    });
  }

  void _playNextAyat() {
    if (_currentPlayingIndex != null) {
      int nextIndex = _currentPlayingIndex! + 1;
      DetailsurahState state = context.read<DetailsurahBloc>().state;

      if (nextIndex < (state.surah?.ayatEntity?.length ?? 0)) {
        AyatEntity nextAyat = state.surah!.ayatEntity![nextIndex];
        playAudioSurah(nextAyat.audioEntity.abdullah_al_juhany ?? '',
            nextIndex);
        _scrollToAyat(nextIndex);
      } else {
        stopAudio();
      }
    }
  }

  void _scrollToAyat(int index) {
    double position = index * 100.0;
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void pauseAudio() async {
    await _audioPlayer.pause();
    context.read<DetailsurahBloc>().pauseAudio();
  }

  void stopAudio() async {
    await _audioPlayer.stop();
  }

  void resumeAudio() async {
    await _audioPlayer.resume();
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
            return state.isloading ?? false
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
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                DetailHeader(surah: state.surah, state: state, audioPlayer: _audioPlayer,),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TafsirSurahPage(
                                  surahName: state.surah?.namaLatin ?? "",
                                  noSurah: state.surah?.id ?? -1)));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/open-book.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          color: Colors.purple.withOpacity(0.6),
                        ),
                        Text(
                          "Tafsir",
                          style: TextStyle(fontSize: 14, color: Colors.purple),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                AyatEntity ayat = state.surah!.ayatEntity![index];
                return AyatItem(
                    ayatEntity: ayat,
                    isPlayAudio: _currentPlayingIndex == index && _isPlaying,
                    playAudio: () => playAudioSurah(
                        ayat.audioEntity.abdullah_al_juhany ?? '', index),
                  stopAudio: () => stopAudioAyat(),
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
}
