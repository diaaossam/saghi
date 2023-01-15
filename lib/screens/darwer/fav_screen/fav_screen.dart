import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saghi/main_layout/cubit/main_cubit.dart';
import 'package:saghi/screens/darwer/fav_screen/cubit/fav_cubit.dart';
import 'package:saghi/screens/darwer/fav_screen/widget/fav_item_design.dart';
import 'package:saghi/shared/helper/mangers/size_config.dart';
import 'package:saghi/widget/app_text.dart';

class FavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavCubit()..getAllFavAudio(),
      child: BlocConsumer<FavCubit, FavState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          FavCubit cubit = FavCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: AppText(text: "المفضلات",color: Colors.white,fontWeight: FontWeight.bold,textSize: 22),
            ),
            body: SafeArea(
              child: cubit.audioList.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfigManger.bodyHeight * .02),
                      child: ListView.separated(
                          itemBuilder: (context, index) =>
                              FavItemDesign(model: cubit.audioList[index],cubit: cubit),
                          separatorBuilder: (context, index) => SizedBox(
                              height: SizeConfigManger.bodyHeight * .02),
                          itemCount: cubit.audioList.length),
                    )
                  : Center(
                      child: AppText(
                      text: "لا يوجد بيانات",
                      textSize: 24,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    )),
            ),
          );
        },
      ),
    );
  }
}
