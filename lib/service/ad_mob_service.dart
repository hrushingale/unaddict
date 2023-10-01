import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{

  static String? get bannerAdUnitId{
    if(Platform.isAndroid){

      return 'ca-app-pub-1976589746474575/8150822373';
    }
    else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    return null;
  }

  // static String? get interstitialAdUnitId{
  //   if(Platform.isAndroid){
  //
  //     return 'ca-app-pub-3940256099942544/1033173712';
  //   }
  //   else if(Platform.isIOS){
  //     return 'ca-app-pub-3940256099942544/4411468910';
  //   }
  //   return null;
  //
  // }


  static final BannerAdListener bannerAdListener=BannerAdListener(
    onAdLoaded: (ad)=>debugPrint('Ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load:$error');
    },
    onAdOpened: (ad)=>debugPrint('Ad opened'),
    onAdClosed: (ad)=>debugPrint('Ad closed')

  );

}