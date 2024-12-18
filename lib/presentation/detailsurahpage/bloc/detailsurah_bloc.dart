import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_equran/domain/usecase/get_detail_surah_usecase.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_state.dart';

class DetailsurahBloc extends Cubit<DetailsurahState> {
  final GetDetailSurahUsecase getDetailSurahUsecase;

  DetailsurahBloc(this.getDetailSurahUsecase) : super(DetailsurahState());

  getDetailSurah(int noSurah) async {
    emit(state.copyWith(isloading: true));
    try {
      var result = await getDetailSurahUsecase.execute(noSurah);
      result.fold((l) async => emit(state.copyWith(isloading: false, message: 'error')),
          (r) async => emit(state.copyWith(surah: r, isloading: false)));
    } on Exception catch (e) {
      emit(state.copyWith(isloading: false, message: e.toString()));
    }
  }
}
