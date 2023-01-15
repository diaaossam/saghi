import 'package:flutter/material.dart';
import 'package:saghi/models/audio_model.dart';
import 'package:saghi/screens/darwer/fav_screen/cubit/fav_cubit.dart';
import 'package:saghi/shared/helper/mangers/size_config.dart';

import '../../../../widget/app_text.dart';

class FavItemDesign extends StatelessWidget {
  final AudioModel model;
  final FavCubit cubit;

  const FavItemDesign({Key? key, required this.model,required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10),vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(20))),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: AppText(
                text: model.text ?? "",
                textSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                maxLines: 20,
              )),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.black, width: 3)),
                  child: IconButton(
                      onPressed: () async{
                        cubit.playSoundOrStopPlaying(soundLink: "${model.link}");
                      },
                      icon: Icon(cubit.isPlaying ? Icons.pause : Icons.play_arrow))),
              Slider(
                  min: 0,
                  max: cubit.duration.inSeconds.toDouble(),
                  value: cubit.position.inSeconds.toDouble(),
                  onChanged: (value) => cubit.changeSlider(value)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: cubit.formatTime(cubit.position.inSeconds)),
                AppText(text: cubit.formatTime((cubit.duration - cubit.position).inSeconds)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
