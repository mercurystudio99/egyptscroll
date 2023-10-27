import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:scrollegypt/utils/nav.dart';

const double mainXpadding = 20;

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
      Scaffold(
        body: Stack(fit: StackFit.expand,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.4),
              child: Center(child:
                SingleChildScrollView(child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 50, horizontal: mainXpadding),
                        child: Text('Egypt Treasure Scrolls', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 40))
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: mainXpadding),
                        child: SizedBox(
                            height: 50, //height of button
                            width: (size.width < size.height)? size.width : 200,
                            child: 
                              InkWell(
                                onTap: () { NavigationRouter.gotoHome(context); },
                                child: Stack(fit: StackFit.expand, children: [
                                    Image.asset('assets/images/button.png'),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text('START', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25))
                                    )
                                  ])
                              )
                            ),
                      ),
                    ],
                  )
                )
              )
            )
          ]
        ));
  }
}
