import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saghi/models/emotion_model.dart';
import 'package:saghi/screens/layout/speech_to_text/cubit/speech_cubit.dart';
import 'package:saghi/shared/helper/mangers/assets_manger.dart';
import 'package:saghi/shared/helper/mangers/size_config.dart';
import 'package:saghi/widget/app_text.dart';
import 'package:saghi/widget/custom_button.dart';
import 'package:saghi/widget/emotion_deisgn.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../shared/helper/mangers/colors.dart';

class SpeechToTextScreen extends StatelessWidget {
 final bool isFromMain;
 PageController pageController = PageController(initialPage: 0);

   SpeechToTextScreen({super.key, required this.isFromMain});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechCubit()..init(),
      child: BlocConsumer<SpeechCubit, SpeechState>(
        listener: (context, state) {
          if(state is GetUserEmoji){
            pageController.animateToPage(1, duration: const Duration(milliseconds: 100), curve: Curves.easeInCirc);
          }
        },
        builder: (context, state) {
          SpeechCubit cubit = SpeechCubit.get(context);
          return isFromMain ?
          SafeArea(
            child: PageView(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              children: [
                setUpBody(cubit),

              ],
            ),
          ) :
          Scaffold(
            body: SafeArea(
              child: PageView(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                children: [
                  setUpBody(cubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget setUpBody(SpeechCubit cubit) {
    return Column(
      children: [
        SizedBox(height: SizeConfigManger.bodyHeight * .2),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfigManger.screenWidth * .15),
          child: CustomButton(
            text: "Upload Audio File",
            press: () =>cubit.pickFile(),
          ),
        ),
        SizedBox(height: SizeConfigManger.bodyHeight * .1),
        GestureDetector(
          onTap: ()async {
             cubit.startListening();
            pageController.animateToPage(1, duration: const Duration(milliseconds: 1), curve: Curves.fastLinearToSlowEaseIn);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/circle.png",
                  height: SizeConfigManger.bodyHeight * .2,
                  width: SizeConfigManger.bodyHeight * .2,
                ),
              ),
              Center(
                child: Image.asset(
                  AssetsManger.mic,
                  color: ColorsManger.darkPrimary,
                  height: SizeConfigManger.bodyHeight * .2,
                  width: SizeConfigManger.bodyHeight * .2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SizeConfigManger.bodyHeight * .02),
        AppText(
            text: "Tap to record", textSize: 22, fontWeight: FontWeight.w400),
      ],
    );
  }
  Widget setBody2(SpeechCubit cubit){
    return Column(
      children: [
        SizedBox(height: SizeConfigManger.bodyHeight * .02),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfigManger.bodyHeight * .05),
          child: Align(
              alignment: AlignmentDirectional.topStart,
              child: AppText(
                  text: "Speaker is mostly:",
                  fontWeight: FontWeight.w500,
                  textSize: 22)),
        ),
        EmotionDesign(getEmotionModel(emo: cubit.personEmoji)),
        SizedBox(height: SizeConfigManger.bodyHeight * .02),
      ],
    );
  }

 EmotionModel getEmotionModel({required String emo}){
    switch (emo){
      case "angry":
        return emojiList[0];
      case "sad":
        return emojiList[1];
      case "surprise":
        return emojiList[2];
      case "happy":
        return emojiList[3];
      default :
        return emojiList[0];
    }
 }

/*  Widget setUpBody2(SpeechCubit cubit) {
    return Column(
      children: [
        SizedBox(height: SizeConfigManger.bodyHeight * .05),
        Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/circle.png",
                height: SizeConfigManger.bodyHeight * .2,
                width: SizeConfigManger.bodyHeight * .2,
              ),
            ),
            Center(
              child: Image.asset(
                AssetsManger.mic,
                color: ColorsManger.darkPrimary,
                height: SizeConfigManger.bodyHeight * .2,
                width: SizeConfigManger.bodyHeight * .2,
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfigManger.bodyHeight * .02),
        Center(
          child: GestureDetector(
            onTap: () =>cubit.stopListening(),
            child: Image.asset(
              "assets/images/pause.png",
              height: SizeConfigManger.bodyHeight * .05,
              width: SizeConfigManger.bodyHeight * .05,
            ),
          ),
        ),
        SizedBox(height: SizeConfigManger.bodyHeight * .02),
        Container(
          height: SizeConfigManger.bodyHeight * .4,
          width: SizeConfigManger.screenWidth * 0.8,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(getProportionateScreenHeight(20))),
          child: AppText(
            text:cubit.lastWords ,
            maxLines: 5,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            textSize: 22,
          ),
        ),
        SizedBox(height: SizeConfigManger.bodyHeight * .02),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfigManger.screenWidth * .15),
          child: CustomButton(
            text: "Recognize emotion",
            press: () {},
          ),
        ),
      ],
    );
  }

  Widget setUpBody3() {

    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfigManger.bodyHeight * .02),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfigManger.bodyHeight * .05),
              child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: AppText(
                      text: "Speaker is mostly:",
                      fontWeight: FontWeight.w500,
                      textSize: 22)),
            ),
            EmotionDesign(emojiList[1]),
            SizedBox(height: SizeConfigManger.bodyHeight * .02),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfigManger.bodyHeight * .02),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(20))),
              child: Column(
                children: [
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      isVisible: false,

                    ),
                    primaryYAxis: NumericAxis(
                      isVisible: false,

                    ),
                    enableAxisAnimation: true,
                    series: <ChartSeries>[
                      ColumnSeries<EmotionModel, String>(
                          dataSource: [
                            emojiList[0],
                            emojiList[1],
                            emojiList[2],
                            emojiList[3],
                          ],
                          xValueMapper: (EmotionModel model, _) => model.title,
                          yValueMapper: (EmotionModel model, _) => model.id),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: SizeConfigManger.screenWidth * .1),
                      EmotionDesign(emojiList[0]),
                      SizedBox(width: SizeConfigManger.screenWidth * .06),
                      EmotionDesign(emojiList[1]),
                      SizedBox(width: SizeConfigManger.screenWidth * .06),
                      EmotionDesign(emojiList[2]),
                      SizedBox(width: SizeConfigManger.screenWidth * .06),
                      EmotionDesign(emojiList[3]),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }*/

}

















