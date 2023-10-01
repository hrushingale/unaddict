import 'package:antiaddiction/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  static const route='/loadingscreen';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin{

  late AnimationController loadingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingController=AnimationController(vsync: this,duration: Duration(seconds: 5));
    loadingController.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        print("donme");
        Navigator.pushNamed(context, HomeScreen.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DADADA"),
      body: Center(
        child: Lottie.asset(
            "lottie/circles_loading.json",

          controller: loadingController,
          onLoaded: (value){
              loadingController.forward();

          }
        ),
      ),
    );
  }
}
