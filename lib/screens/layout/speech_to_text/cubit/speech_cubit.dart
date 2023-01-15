import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  SpeechCubit() : super(SpeechInitial());

  static SpeechCubit get(context) => BlocProvider.of(context);

  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  void init() async {
    speechEnabled = await speechToText.initialize();
    emit(State1());
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult,);
    emit(State2());
  }


  void stopListening() async {
    await speechToText.stop();
    emit(State3());
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    lastWords = result.recognizedWords;
    emit(State4());
  }

  void recordMsg(){

  }

  File? audioFile;
  String personEmoji = '';

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["mp3", "m4a", "wav", "avi"],
    );
    if (result != null) {
      audioFile = File(result.files.single.path!);
      Dio dio = Dio();
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          audioFile!.path,
          filename: audioFile!
              .path
              .split('/')
              .last,
        ),
      });
      dio.post('http://10.0.2.2:5000/', data: formData).then((value) {
        personEmoji = value.data;
        emit(GetUserEmoji());
      });
    } else {}
  }
}
