part of 'fav_cubit.dart';

@immutable
abstract class FavState {}

class FavInitial extends FavState {}
class GetAllAudioListState extends FavState {}
class initStatePlayingState extends FavState {}
class ChangeDurationState extends FavState {}
class ChangePostionDurationState extends FavState {}
class ChangeSliderValueState extends FavState {}
class PlaySoundState extends FavState {}
