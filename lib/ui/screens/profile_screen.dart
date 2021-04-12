import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CustomText('Profile',
              fontSize: 18, fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 2),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('images/building.svg',
                  height: screenWidthFraction(context, dividedBy: 4)),
              verticalSpaceMedium,
              Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Styles.colorBlack)),
                  child: Text(
                    'WE WILL GO LIVE SOON ENOUGH',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Styles.colorBlack,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
