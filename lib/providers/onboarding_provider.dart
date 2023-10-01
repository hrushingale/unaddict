import 'package:antiaddiction/screens/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier{
  int page=0;

  void setPage(int value,BuildContext context){
    page=value;
    if(page==2){
      Navigator.pushNamed(context, LoadingScreen.route);
    }
    notifyListeners();
  }
  Future fetchPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingStatus = prefs.getBool('onboardingStatus')??false;
    return onboardingStatus;
  }

  int _page=0;

  int get getPage=>_page;

  void firstSetPage(int value){
    _page=value;
    notifyListeners();
  }




}