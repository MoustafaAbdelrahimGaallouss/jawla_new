import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jawla/core/constants/colors.dart';
import 'package:jawla/view%20model/homepage/bottom_nav_cubit.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Builder(
        builder: (context) {
          var controller = context.read<BottomNavCubit>();

          return PersistentTabView(
            context,
            controller: controller.controller,
            screens: controller.pages,
            items: controller.items,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardAppears: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            confineToSafeArea: true,
            navBarHeight: kBottomNavigationBarHeight,
            decoration: const NavBarDecoration(
              gradient: LinearGradient(
                colors: [AppColor.bottomNavColor, AppColor.bottomNavColor2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            animationSettings: const NavBarAnimationSettings(
              navBarItemAnimation: ItemAnimationSettings(
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimationSettings(
                animateTabTransition: true,
                duration: Duration(milliseconds: 200),
                screenTransitionAnimationType:
                    ScreenTransitionAnimationType.fadeIn,
              ),
            ),
            navBarStyle: NavBarStyle.style10,
          );
        },
      ),
    );
  }
}
