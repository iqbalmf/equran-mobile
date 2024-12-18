import 'package:equatable/equatable.dart';

class TafsirEntity extends Equatable {
  int ayat;
  String text;

  TafsirEntity({
    required this.ayat,
    required this.text,
  });

  @override
  List<Object?> get props => [ayat, text];
}
