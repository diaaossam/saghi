import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saghi/main_layout/cubit/main_cubit.dart';
import 'package:saghi/shared/helper/mangers/colors.dart';
import 'package:saghi/shared/helper/mangers/size_config.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared/helper/mangers/assets_manger.dart';
import '../../../widget/app_text.dart';
import '../../../widget/custom_button.dart';
import 'widgets/bottom_sheet_design.dart';

class TextToSpeechScreen extends StatelessWidget {
  var text = TextEditingController();
  var formKey = GlobalKey<FormState>();

  TextToSpeechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: SizeConfigManger.bodyHeight * .02),
                Container(
                  height: SizeConfigManger.bodyHeight * .4,
                  padding: const EdgeInsets.all(20),
                  width: SizeConfigManger.screenWidth * 0.8,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(20))),
                  child: TextFormField(
                    controller: text,
                    style: TextStyle(
                      fontSize: 22,
                      color: ColorsManger.darkPrimary,
                    ),
                    maxLines: 100,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "من فضلك قم بكتابه نص";
                      }
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfigManger.bodyHeight * .02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfigManger.screenWidth * .15),
                  child: CustomButton(
                    text: "Convert",
                    press: () {
                      if (formKey.currentState!.validate()) {
                        cubit.createAudioScript(script: text.text);
                      }
                    },
                  ),
                ),
                SizedBox(height: SizeConfigManger.bodyHeight * .05),
                Visibility(
                  visible: cubit.soundUrl != null,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: SizeConfigManger.bodyHeight * .25,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfigManger.bodyHeight * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => cubit.saveAudioToFav(
                                    link: "${cubit.soundUrl}", text: text.text),
                                icon: Icon(
                                  cubit.favIcon,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.fast_rewind_outlined)),
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black, width: 3)),
                                child: IconButton(
                                    onPressed: () async{
                                      cubit.playSoundOrStopPlaying(soundLink: "${cubit.soundUrl}");
                                    },
                                    icon: Icon(cubit.isPlaying ? Icons.pause : Icons.play_arrow))),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.fast_forward_outlined)),
                            IconButton(
                                onPressed: () async {
                                  Share.share("${cubit.soundUrl}");
                                },
                                icon: const Icon(Icons.file_upload_outlined)),
                          ],
                        ),
                        Slider(
                            min: 0,
                            max: cubit.duration.inSeconds.toDouble(),
                            value: cubit.position.inSeconds.toDouble(),
                            onChanged: (value) => cubit.changeSlider(value)),
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
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
