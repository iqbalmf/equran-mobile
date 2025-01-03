import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_bloc.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_state.dart';

class DetailHeader extends StatefulWidget {
  final SurahEntity? surah;
  final DetailsurahState state;

  const DetailHeader({super.key, required this.surah, required this.state});

  @override
  State<DetailHeader> createState() => _DetailHeaderState();
}

class _DetailHeaderState extends State<DetailHeader> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool loadingAudio = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _currentPosition = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      padding: EdgeInsets.symmetric(vertical: 10),
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
            widget.surah?.namaLatin ?? 'nama_surah',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.surah?.nama ?? 'arabic',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.normal),
          ),
          Text(
            widget.surah?.arti ?? 'arti',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic),
          ),
          Html(data: widget.surah?.deskripsi ?? 'deskripsi'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Slider(
                  activeColor: Colors.purple.withOpacity(0.6),
                  value: _currentPosition.inSeconds.toDouble(),
                  max: _totalDuration.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await _audioPlayer.seek(position);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(_currentPosition)),
                    Text(_formatDuration(_totalDuration)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loadingAudio
                            ? CircularProgressIndicator()
                            : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: (widget.state.isPlayAudio ?? false)
                            ? IconButton(
                                icon: Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  await _audioPlayer.pause();
                                  context.read<DetailsurahBloc>().pauseAudio();
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    loadingAudio = true;
                                  });
                                  try {
                                    String audioUrl = widget
                                            .surah
                                            ?.audioFullSurah
                                            ?.abdullah_al_juhany ??
                                        "";
                                    await _audioPlayer
                                        .play(UrlSource(audioUrl));
                                    context.read<DetailsurahBloc>().playAudio();
                                  } catch (e) {
                                    setState(() {
                                      loadingAudio = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Error playing audio: $e')),
                                    );
                                  } finally {
                                    setState(() {
                                      loadingAudio = false;
                                    });
                                  }
                                },
                              )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
