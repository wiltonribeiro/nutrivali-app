import 'package:firebase_admob/firebase_admob.dart';
import 'package:app/config/Environment.dart';

class AdsController {

  static final AdsController _adsController = new AdsController._internal();
  bool _isOpened;

  factory AdsController(){
      return _adsController;
  }

  InterstitialAd _myInterstitial;

  AdsController._internal();


  void load(){
    if(_isOpened!=true){
      _myInterstitial = InterstitialAd(
        adUnitId: Environment.intersticial,
        targetingInfo: MobileAdTargetingInfo(
          keywords: <String>['food', 'health', 'home', 'family'],
          childDirected: false,
        ),
        listener: (MobileAdEvent event) {
          if(event == MobileAdEvent.closed){
            _isOpened = false;
          }
        },
      );

      _myInterstitial..load()..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
      _isOpened = true;
    }
  }

  void dispose(){
    _myInterstitial?.dispose();
  }

}