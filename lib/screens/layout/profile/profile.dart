import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saghi/main_layout/cubit/main_cubit.dart';
import 'package:saghi/screens/auth/login/login_screen.dart';
import 'package:saghi/screens/auth/register/register_screen.dart';
import 'package:saghi/screens/darwer/about_us/about_us.dart';
import 'package:saghi/screens/darwer/contact_us/contact_us.dart';
import 'package:saghi/screens/darwer/fav_screen/fav_screen.dart';
import 'package:saghi/screens/darwer/guide_screen/guidelines%20_screen.dart';
import 'package:saghi/shared/helper/mangers/assets_manger.dart';
import 'package:saghi/shared/helper/mangers/colors.dart';
import 'package:saghi/shared/helper/mangers/constants.dart';
import 'package:saghi/shared/helper/mangers/size_config.dart';
import 'package:saghi/widget/app_text.dart';
import 'package:saghi/widget/custom_button.dart';
import 'package:saghi/widget/custom_loading.dart';
import 'package:saghi/widget/custom_text_form_field.dart';

import '../../../shared/helper/methods.dart';

class ProfileScreen extends StatelessWidget {
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  bool isFromMain ;
  var formKey = GlobalKey<FormState>();
  var pageController = PageController(initialPage: 0);

  ProfileScreen(this.isFromMain);

  @override
  Widget build(BuildContext context) {

    if(isFromMain){

      return BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if(state is UpdateProfileInfo){
            FocusManager.instance.primaryFocus?.unfocus();
            pageController.previousPage(duration: const Duration(microseconds: 200), curve: Curves.fastLinearToSlowEaseIn);
          }
        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return
            cubit.userModel != null ?
             PageView(
               controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
               Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfigManger.bodyHeight * .02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfigManger.bodyHeight * .02),
                      InkWell(
                          onTap: ()=>pageController.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.fastLinearToSlowEaseIn),
                          child: AppText(text: "Edit",color: ColorsManger.darkPrimary,fontWeight: FontWeight.bold,textSize: 24,textDecoration: TextDecoration.underline)),
                      SizedBox(height: SizeConfigManger.bodyHeight * .02,),
                      Image.asset("assets/images/personal.png",
                        color: Colors.black,
                        fit: BoxFit.cover,
                        height: SizeConfigManger.bodyHeight * .15,
                        width: SizeConfigManger.bodyHeight * .15,

                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfigManger.bodyHeight*.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(text: "${cubit.userModel!.firstName} ${cubit.userModel!.lastName}",textSize: 22,fontWeight: FontWeight.bold,),
                            AppText(text: "${cubit.userModel!.email}",textSize: 16,fontWeight: FontWeight.w400,),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfigManger.bodyHeight * .02),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: SizeConfigManger.bodyHeight*.02),
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[400],
                      ),
                      InkWell(
                        onTap: ()=>navigateTo(context, FavScreen()),
                        child: Row(
                          children: [
                            Expanded(child: AppText(text: "History",fontWeight: FontWeight.bold,textSize: 20,color: Colors.black)),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: SizeConfigManger.bodyHeight*.02),
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[400],
                      ),
                      InkWell(
                        onTap: ()=>navigateTo(context, GuidelinesScreen()),
                        child: Row(
                          children: [
                            Expanded(child: AppText(text: "How to use SAGHI",fontWeight: FontWeight.bold,textSize: 20,color: Colors.black)),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: SizeConfigManger.bodyHeight*.02),
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[400],
                      ),
                      InkWell(
                        onTap: ()=>navigateTo(context, const ContactUsScreen()),
                        child: Row(
                          children: [
                            Expanded(child: AppText(text: "Contact us",fontWeight: FontWeight.bold,textSize: 20,color: Colors.black)),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: SizeConfigManger.bodyHeight*.02),
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[400],
                      ),
                      InkWell(
                        onTap: ()=>navigateTo(context, const AboutUsScreen()),
                        child: Row(
                          children: [
                            Expanded(child: AppText(text: "About us",fontWeight: FontWeight.bold,textSize: 20,color: Colors.black)),
                            const Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: SizeConfigManger.bodyHeight*.02),
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[400],
                      ),
                      InkWell(
                        onTap: ()async{
                          await FirebaseAuth.instance.signOut();
                          navigateToAndFinish(context, LoginScreen());
                        },
                        child: Row(
                          children: [
                            Expanded(child: AppText(text: "Sign out",fontWeight: FontWeight.bold,textSize: 20,color: Colors.black)),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: SizeConfigManger.bodyHeight*.02),
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfigManger.bodyHeight * .02),
                  child: Form(
                    key:formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: SizeConfigManger.bodyHeight * .1),
                        GestureDetector(
                          onTap: () => cubit.pickUserImage(),
                          child: CircleAvatar(
                            radius: getProportionateScreenHeight(60),
                            backgroundColor: ColorsManger.darkPrimary,
                            backgroundImage: cubit.userModel!.image ==
                                ConstantsManger.defaultValue
                                ? const AssetImage(AssetsManger.profile)
                                : NetworkImage(cubit.userModel!.image) as ImageProvider,
                          ),
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * .04),
                        CustomTextFormField(
                          controller: firstName..text = cubit.userModel!.firstName,
                          type: TextInputType.text,
                          hintText: "الإسم الأول",
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "الإسم الأول مطلوب";
                            }
                          },
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * 0.04),
                        CustomTextFormField(
                          controller: lastName..text = cubit.userModel!.lastName,
                          type: TextInputType.text,
                          hintText: "الإسم الأخير",
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "الإسم الأخير مطلوب";
                            }
                          },
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * 0.04),
                        CustomButton(text: "Save Changes", press: () {
                          if(formKey.currentState!.validate()){
                            cubit.updateUserInfo(first: firstName.text, last: lastName.text);
                          }
                        }),
                      ],
                    ),
                  ),
                )

            ],
          ):
            const CustomLoading();
        },
      );
    }
    else{
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfigManger.screenWidth*.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(text: "You are not currently logged in",color: Colors.grey,textSize: 22,maxLines: 2,),
            SizedBox(height: SizeConfigManger.bodyHeight*0.1),
            CustomButton(press: ()=>navigateToAndFinish(context,LoginScreen()),text: "Sign In",),
            SizedBox(height: SizeConfigManger.bodyHeight*0.04),
            CustomButton(press: ()=>navigateToAndFinish(context,RegisterScreen()),text: "Sign Up",),
          ],
        ),
      );
    }

  }
}














