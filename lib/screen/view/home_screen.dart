import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:untitled4/utils/ads_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AdsHelper.adsHelper.initBanner();
    AdsHelper.adsHelper.initReward();
    AdsHelper.adsHelper.initInterstitial();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                if (AdsHelper.adsHelper.rewardedAd != null) {
                  AdsHelper.adsHelper.rewardedAd!.show(
                    onUserEarnedReward: (ad, reward) {
                      Get.snackbar("Reward ${reward.amount}", "Message");
                      AdsHelper.adsHelper.initReward();
                    },
                  );
                } else {
                  AdsHelper.adsHelper.initReward();
                }
              },
              child: const Text("Reward")),
          AdsHelper.adsHelper.bannerAd == null
              ? Container()
              : SizedBox(
                  height: 100,
                  child: AdWidget(ad: AdsHelper.adsHelper.bannerAd!),
                ),
          ElevatedButton(
              onPressed: () {
                if (AdsHelper.adsHelper.interstitialAd != null) {
                  AdsHelper.adsHelper.interstitialAd!.show();
                  AdsHelper.adsHelper.initInterstitial();
                  AdsHelper.adsHelper.interstitialAd!
                      .fullScreenContentCallback = FullScreenContentCallback(
                    onAdDismissedFullScreenContent: (ad) {
                      Get.snackbar("title", "message");
                    },
                  );
                } else {
                  AdsHelper.adsHelper.initInterstitial();
                }
              },
              child: const Text("Interstitial")),
        ],
      ),
    ));
  }
}
