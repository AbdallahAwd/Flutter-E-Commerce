import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:learning/modules/shopApp/login/login.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';

class OnBoardingScreen extends StatelessWidget {

  List<PageViewModel> pages = [
    PageViewModel(
      image: image(0),
      title: 'Choose Product',
      body: 'Choose your product, All what you want is here',
      decoration: pageTextStyle(),
    ),
    PageViewModel(
      image: image(1),
      title: 'Pay Easy',
      body: 'Choose your product, All what you want is here',
      decoration: pageTextStyle(),
    ),
    PageViewModel(
      image: image(2),
      title: 'Fast Delivery',
      body: 'Choose your product, All what you want is here',
      decoration: pageTextStyle(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntroductionScreen(
          color: Colors.amber,
          pages: [
            pages[0],
            pages[1],
            pages[2],
          ],
          done: Text('Done'),
          onDone: () {
            CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
              if (value == true) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                        (route) => false);
              }
            });
          },
          dotsDecorator: DotsDecorator(
            color: Colors.black12,
            size: Size(10, 10),
            activeSize: Size(22, 10),
            activeColor: Colors.amber,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          showSkipButton: true,
          skip: Text('skip'.toUpperCase()),
          onSkip: ()
          {
            CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
              if (value == true) {
                navigateAnd(context, LogInScreen());
              }
            });
          },
          globalBackgroundColor: Colors.white,
          dotsFlex: 2,
          showDoneButton: true,
          isTopSafeArea: true,
          animationDuration: 250,
          next: Icon(Icons.arrow_right_alt_sharp),
          showNextButton: true,
          globalFooter: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(600, 400),
                  topLeft: Radius.circular(10.0)),
            ),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(600, 400),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(600, 300),
                topLeft: Radius.circular(10.0)),
          ),
        ),

      ],
    );
  }
}

Widget image(index) {
  List<String> assets = [
    'assets/shot1.jpg',
    'assets/shot2.jpg',
    'assets/shot3.jpg',
  ];
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.elliptical(150, 150)),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Image.asset(
      '${assets[index]}',
      width: 350,
      fit: BoxFit.cover,
    ),
  );
}

pageTextStyle() => PageDecoration(
      pageColor: Colors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 25.0,
      ),
    );

