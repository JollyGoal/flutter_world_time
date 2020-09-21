import 'package:bloc/bloc.dart';
import 'package:flutter_world_time/data/models/world_time.dart';
import 'package:flutter_world_time/data/network/worldtimeapi.dart';
import 'package:meta/meta.dart';

part 'world_time_state.dart';

class WorldTimeCubit extends Cubit<WorldTimeState> {
  final WorldTimeApi _worldTimeApi;

  WorldTimeCubit(this._worldTimeApi) : super(WorldTimeInitial());

  Future<void> getTimeData(WorldTime worldTime) async {

    try {
      emit(WorldTimeLoading());
      final instance = await _worldTimeApi.getTime(worldTime);
      emit(WorldTimeLoaded(instance));
    } on NetworkException {
      emit(WorldTimeError('Failed to fetch data from network'));
    }
  }

  void setInitialState() {
    emit(WorldTimeInitial());
  }
}
