import 'dart:io';

class AdmobService {
  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  // String? getInterstitialAdUnitId() {
  //   if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/4411468910';
  //   } else if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/1033173712';
  //   }
  //   return null;
  // }
}
