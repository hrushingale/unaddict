import 'dart:async';

import 'package:antiaddiction/model/DayTracker.dart';
import 'package:antiaddiction/providers/duration_provider.dart';
import 'package:antiaddiction/providers/home_screen_provider.dart';
import 'package:antiaddiction/providers/onboarding_provider.dart';
import 'package:antiaddiction/providers/time_screen_provider.dart';
import 'package:antiaddiction/screens/home_screen.dart';
import 'package:antiaddiction/screens/loading_screen.dart';
import 'package:antiaddiction/screens/onboarding_screen.dart';
import 'package:antiaddiction/screens/user_registration_screens.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'api/notification_api.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  MobileAds.instance.initialize();
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // FirebaseCrashlytics.instance.crash();
  // NotificationApi.init(initScheduled: true);
  await Hive.initFlutter();
  Hive.registerAdapter(DayTrackerAdapter());
  await Hive.openBox<DayTracker>('day-tracker');
  tz.initializeTimeZones();




  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Un-addict: Challenge Tracker',

      theme: ThemeData(

        primarySwatch: Colors.blue,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent)
      ),

      initialRoute: OnboardingScreens.route,
      onGenerateRoute: (value){
        switch(value.name){

          case UserRegistrationScreen.route:
            return MaterialPageRoute(builder: (context)=>MultiProvider(

                providers: [
                  ChangeNotifierProvider(
                    create: (_)=>TimeScreenProvider(),

                  ),
                  ChangeNotifierProvider(
                    create: (_)=>HomeScreenProvider(),

                  ),
                  ChangeNotifierProvider(
                    create: (_)=>DurationProvider(),

                  ),
                  ChangeNotifierProvider(
                    create: (_)=>OnboardingProvider(),

                  ),
                ],
                
                child: UserRegistrationScreen()));

          case HomeScreen.route:
            return MaterialPageRoute(builder: (context)=>ChangeNotifierProvider(

              create: (_)=>HomeScreenProvider(),

                child: HomeScreen()));

          case OnboardingScreens.route:
            return MaterialPageRoute(builder: (context)=>ChangeNotifierProvider(create: (_)=>OnboardingProvider(),child: OnboardingScreens(),)

            );

          case LoadingScreen.route:
            return MaterialPageRoute(builder: (context)=>LoadingScreen());
        }


      },
    );
  }
}
