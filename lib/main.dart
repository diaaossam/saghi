import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saghi/screens/auth/splash_screen/splash_screen.dart';
import 'package:saghi/screens/layout/speech_to_text/speech_to_text.dart';

import 'layout_un_registerd/layout_un_registerd.dart';
import 'main_layout/main_layout.dart';
import 'screens/auth/on_boarding_screen/on_boarding.dart';
import 'shared/services/local/cache_helper.dart';
import 'shared/styles/styles.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachedHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saghi',
      debugShowCheckedModeBanner: false,
     // builder: (_, Widget? child) => Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: ThemeManger.setLightTheme(),
      home: OnBoardingScreen(),
    );
  }
}
