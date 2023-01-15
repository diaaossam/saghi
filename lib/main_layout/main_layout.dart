import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saghi/main_layout/cubit/main_cubit.dart';
import 'package:saghi/shared/helper/mangers/size_config.dart';
import '../models/language_model.dart';
import '../shared/helper/mangers/colors.dart';
import '../widget/app_text.dart';
import '../widget/drawer_design.dart';

class MainLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    SizeConfigManger().init(context);
    return BlocProvider(
      create: (context) => MainCubit()..init(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            drawer: DrawerDesign(cubit: cubit),
            appBar: AppBar(
              title: AppText(
                  text: cubit.titles[cubit.currentIndex],
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  textSize: 22),
              actions: [
                GestureDetector(
                  onTap: () => _scaffoldKey.currentState!.openDrawer(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfigManger.screenWidth * .03),
                    child: Icon(
                      size: SizeConfigManger.bodyHeight * .045,
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              leading:Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfigManger.bodyHeight*0.02),
                child: PopupMenuButton<LanguageModel>(
                    icon: Icon(Icons.language,color: Colors.white,size: SizeConfigManger.bodyHeight*.05),
                    onSelected: (LanguageModel item) async{
                      cubit.changeLanguage(langCode: item.languageCode);
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<LanguageModel>>[
                      PopupMenuItem<LanguageModel>(
                        value: LanguageModel.choices[0],
                        child: Row(
                          children: [
                            Text(LanguageModel.getCountryFlag('US')),
                            SizedBox(width: SizeConfigManger.bodyHeight*.02),
                            AppText(text: "English")
                          ],
                        ),
                      ),
                      PopupMenuItem<LanguageModel>(
                        value: LanguageModel.choices[1],
                        child: Row(
                          children: [
                            Text(LanguageModel.getCountryFlag('SA')),
                            SizedBox(width: SizeConfigManger.bodyHeight*.02),
                            AppText(text: "Arabic")
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavItems,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) => cubit.changeCurrentIndex(index: index),
            ),
          );
        },
      ),
    );
  }
}
