import 'package:equatable/equatable.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';

class DetailsurahState extends Equatable {
  String? message;
  SurahEntity? surah;
  bool? isloading;
  bool? isPlayAudio = false;

  DetailsurahState({this.message, this.surah, this.isloading, this.isPlayAudio = false});

  DetailsurahState copyWith(
          {String? message, SurahEntity? surah, bool? isloading, bool? isPlayAudio}) =>
      DetailsurahState(message: message, surah: surah ?? this.surah, isloading: isloading, isPlayAudio: isPlayAudio ?? this.isPlayAudio);

  @override
  List<Object?> get props => [message, surah, isloading, isPlayAudio];
}
