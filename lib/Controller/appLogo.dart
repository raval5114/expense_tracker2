import 'package:flutter/material.dart';

class AppLogo extends StatefulWidget {
  const AppLogo({super.key});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 240,
        child: Hero(
          tag: 'splash',
          child:
              Image.asset('assets/images/appLogo.png', width: 240, height: 200),
        ));
  }
}
