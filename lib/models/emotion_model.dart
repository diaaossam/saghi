import 'package:flutter/material.dart';
import 'package:saghi/shared/helper/mangers/assets_manger.dart';
import 'package:saghi/shared/helper/mangers/colors.dart';

class EmotionModel{
  final int id;
  final String emojy;
  final String title;
  final Color color;

  EmotionModel({required this.id,required this.emojy,required this.title , required this.color});


}

List<EmotionModel> emojiList= [
  EmotionModel(id: 1, emojy: AssetsManger.angry, title: "Angry" , color: ColorsManger.red),
  EmotionModel(id: 2, emojy: AssetsManger.sad, title: "sad" , color: ColorsManger.orange),
  EmotionModel(id: 3, emojy: AssetsManger.surprise, title: "Surprised" , color: ColorsManger.orangeLight),
  EmotionModel(id: 4, emojy: AssetsManger.happy, title: "Happy" , color: ColorsManger.blue),
];