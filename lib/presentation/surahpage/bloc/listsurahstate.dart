import 'package:equatable/equatable.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';

class SurahState extends Equatable {
  String? message;
  List<SurahEntity> surah;
  bool? isLoading;

  SurahState(
      {this.message, this.surah = const <SurahEntity>[], this.isLoading = false});

  SurahState copyWith(
          {String? message, List<SurahEntity>? surah, bool? isloading}) =>
      SurahState(
          message: message, surah: surah ?? this.surah, isLoading: isloading);

  @override
  List<Object?> get props => [message, surah];
}
