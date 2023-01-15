import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:saghi/models/audio_model.dart';

import '../../../../shared/helper/mangers/constants.dart';

part 'fav_state.dart';


class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  static FavCubit get(context)=>BlocProvider.of(context);


  List<AudioModel> audioList = [];

  void getAllFavAudio() {
    FirebaseFirestore.instance
        .collection(ConstantsManger.FAV)
        .where("isFav", isEqualTo: true)
        .get()
        .then((value) {
      audioList.clear();
      for (var element in value.docs) {
        audioList.add(AudioModel.fromJson(map: element.data()));
      }
      emit(GetAllAudioListState());
      init();
    });
  }

  void init() {
    player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      emit(initStatePlayingState());
    });
    player.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      emit(ChangeDurationState());
    });
    player.onPositionChanged.listen((newPosition) {
      position = newPosition;
      emit(ChangePostionDurationState());
    });
  }

  void changeSlider(double value) async {
    final pos = Duration(seconds: value.toInt());
    player.seek(pos);
    await player.resume();
    emit(ChangeSliderValueState());
  }

  String formatTime(int second) {
    return '${(Duration(seconds: second))}'.split(".")[0].padLeft(8, "0");
  }

  final player = AudioPlayer();

  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  void playSoundOrStopPlaying({required String soundLink}) {
    if (isPlaying) {
      player.pause();
    } else {
      player.setPlaybackRate(0.4);
      player.play(UrlSource(soundLink));
    }
    isPlaying = !isPlaying;
    emit(PlaySoundState());
  }



}
