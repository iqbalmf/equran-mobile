import 'package:equatable/equatable.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';

class TafsirState extends Equatable {
  String? message;
  SurahEntity? surah;
  bool? isLoading;

  TafsirState({this.message, this.surah, this.isLoading});

  TafsirState copyWith(
          {String? message, SurahEntity? surah, bool? isLoading}) =>
      TafsirState(message: message, surah: surah, isLoading: isLoading);

  @override
  List<Object?> get props => [message, surah, isLoading];
}
