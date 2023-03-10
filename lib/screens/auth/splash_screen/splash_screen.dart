import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:saghi/layout_un_registerd/layout_un_registerd.dart';
import 'package:saghi/main_layout/main_layout.dart';
import 'package:saghi/screens/auth/login/login_screen.dart';
import 'package:saghi/shared/helper/mangers/assets_manger.dart';
import 'package:saghi/shared/helper/mangers/size_config.dart';
import 'package:saghi/shared/helper/methods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigManger().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsManger.logo,
              height: SizeConfigManger.bodyHeight * .3,
              width: SizeConfigManger.bodyHeight * .3,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }

  void init()async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if(isConnected){
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if(event == null){
          Future.delayed(const Duration(seconds: 2), () => navigateToAndFinish(context,LayoutUnRegisterd()));

        }else{
          Future.delayed(const Duration(seconds: 2), () => navigateToAndFinish(context, MainLayout()));

        }
      });

    }else{
      showToast(msg: "لا يوجد إتصال بالإنترنت",color: Colors.red);
    }

  }
}
