import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/domain/usecase/get_surah_usecase.dart';
import 'package:my_equran/presentation/surahpage/bloc/listsurahstate.dart';

class SurahBloc extends Cubit<SurahState> {
  final GetSurahUsecase getSurahUsecase;

  SurahBloc(this.getSurahUsecase) : super(SurahState());

  getListSurah(bool isOnline) async {
    emit(state.copyWith(isloading: true));
    try {
      if(isOnline && state.surah.isEmpty) {
        var result = await getSurahUsecase.execute();
        result.fold((l) async => emit(state.copyWith(isloading: false, message: l.toString())),
                (r) async => emit(state.copyWith(surah: r, isloading: false)));
      } else {
        emit(state.copyWith(isloading: false, message: "No Internet Connection!"));
      }
    } on Exception catch (e) {
      emit(state.copyWith(isloading: false, message: e.toString()));
    }
  }
}
