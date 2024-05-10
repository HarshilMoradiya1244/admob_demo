import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  static AdsHelper adsHelper = AdsHelper._();

  AdsHelper._();

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  AppOpenAd? appOpenAd;

  var bannerId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  var interstitialId = Platform.isAndroid
      ? "ca-app-pub-3940256099942544/1033173712"
      : "ca-app-pub-3940256099942544/4411468910";

  var rewardedId = Platform.isAndroid
      ? "ca-app-pub-3940256099942544/5224354917"
      : "ca-app-pub-3940256099942544/1712485313";

  var openAppId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-3940256099942544/5575463023';

  void initBanner() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerId,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );
    bannerAd!.load();
  }

  void initInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad Loaded.');
          interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("$error");
        },
      ),
    );
  }

  void initReward() {
    RewardedAd.load(
      adUnitId: rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("$error");
        },
      ),
    );
  }

  void initNative() {}

  void initOpenAds() {
    AppOpenAd.load(
      adUnitId: openAppId,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("$error");
        },
      ),
    );
  }
}
