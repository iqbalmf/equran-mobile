import 'package:equatable/equatable.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';

class DetailsurahState extends Equatable {
  String? message;
  SurahEntity? surah;
  bool? isloading;

  DetailsurahState({this.message, this.surah, this.isloading});

  DetailsurahState copyWith(
          {String? message, SurahEntity? surah, bool? isloading}) =>
      DetailsurahState(message: message, surah: surah ?? this.surah, isloading: isloading);

  @override
  List<Object?> get props => [message, surah, isloading];
}
