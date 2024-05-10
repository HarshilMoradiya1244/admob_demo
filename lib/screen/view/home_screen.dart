import 'dart:async';

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
    AdsHelper.adsHelper.initInterstitial();
    AdsHelper.adsHelper.initReward();
    AdsHelper.adsHelper.initOpenAds();

    Timer(Duration(seconds: 3), () {
      if (AdsHelper.adsHelper.appOpenAd != null) {
        AdsHelper.adsHelper.appOpenAd!.show();
        AdsHelper.adsHelper.appOpenAd!.fullScreenContentCallback =
            FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {

              },
            );
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admob Demo APP"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                child: const Text("Interstitial Ads"),
              ),
              const SizedBox(
                height: 10,
              ),
              AdsHelper.adsHelper.bannerAd == null
                  ? Container()
                  : SizedBox(
                height: 200,
                child: AdWidget(
                  ad: AdsHelper.adsHelper.bannerAd!,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (AdsHelper.adsHelper.rewardedAd != null) {
                    AdsHelper.adsHelper.rewardedAd!.show(
                      onUserEarnedReward: (ad, reward) {
                        Get.snackbar("Reward ${reward.amount}", "message");
                        AdsHelper.adsHelper.initReward();
                      },
                    );
                  } else {
                    AdsHelper.adsHelper.initReward();
                  }
                },
                child: const Text("Reward Ads"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (AdsHelper.adsHelper.appOpenAd != null) {
                    AdsHelper.adsHelper.appOpenAd!.show();
                    AdsHelper.adsHelper.initOpenAds();
                  } else {
                    AdsHelper.adsHelper.initOpenAds();
                  }
                },
                child: const Text("AppOpen Ads"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}