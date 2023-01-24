import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  AdState({
    required this.initialization,
  });
  Future<InitializationStatus> initialization;
  String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2121562439585067/7795728370';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2121562439585067/2471534916';
    } else {
      return null;
    }

    // Platform.isAndroid
    //     ? 'ca-app-pub-3940256099942544/6300978111'
    //     : 'ca-app-pub-3940256099942544/2934735716';
  }
}
