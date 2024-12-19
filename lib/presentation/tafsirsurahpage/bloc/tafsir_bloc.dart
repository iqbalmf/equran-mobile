import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/domain/usecase/get_tafsir_surah_usecase.dart';
import 'package:my_equran/presentation/tafsirsurahpage/bloc/tafsir_state.dart';

class TafsirBloc extends Cubit<TafsirState> {
  final GetTafsirSurahUsecase getTafsirSurahUsecase;

  TafsirBloc(this.getTafsirSurahUsecase) : super(TafsirState());

  getTafsirSurah(int noSurah) async {
    emit(state.copyWith(isLoading: true));
    try {
      var result = await getTafsirSurahUsecase.execute(noSurah);
      result.fold(
          (l) async => emit(state.copyWith(isLoading: false, message: 'error')),
          (r) async => emit(state.copyWith(surah: r, isLoading: false)));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    }
  }
}
