import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/core/network/resulet_firebase.dart';
import 'package:tasky/features/home/data/firebase/home_firebase.dart';
import 'package:tasky/features/home/data/models/app_task_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<AppTaskModel> tasks = [];
  DateTime date = DateTime.now();

  Future<void> getTasks(List<AppTaskModel> tasks) async {
    emit(HomeLoading());

    final resulte = await HomeFirebase.getTasks(date);

    switch (resulte) {
      case Success<List<AppTaskModel>>():
        tasks = resulte.data;
        if (tasks.isEmpty) {
          emit(HomeEmpty());
        } else {
          emit(HomeSuccess());
        }
      case Error<List<AppTaskModel>>():
        emit(HomeError(resulte.error));
    }
  }
}
