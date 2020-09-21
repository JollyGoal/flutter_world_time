part of 'world_time_cubit.dart';

@immutable
abstract class WorldTimeState {
  const WorldTimeState();
}

class WorldTimeInitial extends WorldTimeState {
  const WorldTimeInitial();
}

class WorldTimeLoading extends WorldTimeState {
  const WorldTimeLoading();
}

class WorldTimeLoaded extends WorldTimeState {
  final WorldTime instance;

  const WorldTimeLoaded(this.instance);
}

class WorldTimeError extends WorldTimeState {
  final String message;

  const WorldTimeError(this.message);
}
