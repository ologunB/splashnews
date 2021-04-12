import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/ui/screens/home_screen.dart';
import 'package:foxfund_alpha/ui/screens/profile_screen.dart';
import 'package:foxfund_alpha/ui/screens/saved_screen.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 3;

  Widget _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const SavedScreen();
      case 1:
        return const ProfileScreen();
      case 3:
        return const HomeScreen();
      default:
        return const Text('Error');
    }
  }

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  final List<IconData> iconList = <IconData>[
    EvaIcons.bookmark,
    EvaIcons.person
  ];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    curve = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(curve);

    Future<void>.delayed(
        const Duration(seconds: 1), () => _animationController.forward());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _getDrawerItemWidget(_bottomNavIndex),
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: Styles.colorWhite,
          child: Icon(EvaIcons.home, color: Styles.colorBlack),
          onPressed: () {
            _animationController.reset();
            _animationController.forward();
            setState(() => _bottomNavIndex = 3);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 2,
        tabBuilder: (int index, bool isActive) {
          final Color color = isActive ? Styles.colorBlack : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconList[index], size: 24, color: color),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomText(
                  index == 0 ? 'Saved' : 'Profile',
                  color: color,
                  fontSize: 13
                ),
              )
            ],
          );
        },
        backgroundColor: Styles.colorWhite,
        activeIndex: _bottomNavIndex,
        splashColor: Styles.colorBlack,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (int index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
