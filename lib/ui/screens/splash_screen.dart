import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foxfund_alpha/core/view_models/startup_vm.dart';
import 'package:foxfund_alpha/utils/base_view.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (StartUpViewModel model) => model.isLoggedIn(),
      builder: (_, StartUpViewModel model, __) => Scaffold(
          backgroundColor: Styles.colorWhite,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('images/logo.svg',
                    height: screenHeight(context) / 6),
                verticalSpaceSmall,
                TypewriterAnimatedTextKit(
                  speed: const Duration(milliseconds: 300),
                  text: const <String>['SplashNews'],
                  textStyle: GoogleFonts.nunito(
                      fontSize: 25.0,
                      color: Styles.colorPurple,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}
