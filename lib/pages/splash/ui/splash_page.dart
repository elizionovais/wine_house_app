import 'package:drink_store/app/components/app_name_widget.dart';
import 'package:flutter/material.dart';

import '../../../app/themes/main_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Hero(
            tag: 'app_name',
            child: AppName(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CircularProgressIndicator(
            color: ColorTheme.primary,
          ),
        ],
      ),
    ));
  }
}
