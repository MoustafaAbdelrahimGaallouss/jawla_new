import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jawla/core/constants/colors.dart';
import 'package:jawla/core/constants/images.dart';
import 'package:jawla/view%20model/onboarding/on_boarding_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jawla/view/modules/onboarding/widgets/white_ellipse.dart';
import 'package:jawla/view/modules/onboarding/widgets/yellow_ellipse.dart';
import 'package:sizer/sizer.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  late OnBoardingCubit controller;

  @override
  void initState() {
    super.initState();
    controller = OnBoardingCubit();

    // بعد 3 ثواني يتم الانتقال تلقائياً
    Timer(const Duration(seconds: 3), () {
      controller.goToOnBoarding3();
      // لو تستخدم GetX أو Navigator عادي:
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => OnBoarding3()));
      // أو مع GetX:
      // Get.off(() => OnBoarding3());
    });
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: Scaffold(
        backgroundColor: AppColor.secondColor,
        body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages().bj1),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
              ),
              Positioned(
                width: 80.w,
                height: 35.h,
                top: 7.h,
                left: 11.w,
                child: Image.asset(AppImages().circle, fit: BoxFit.fill),
              ),
              Positioned(
                top: 17.h,
                left: 17.w,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 70.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages().logo1),
                    ),
                  ),
                ),
              ),
              const WhiteEllipse(),
              const YellowEllipse(),
              Positioned(
                top: 50.h,
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "ENJOY YOUR JOURNEY \nin Egypt with us",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // CustomButton(
              //   controller: controller,
              //   name: "START",
              //   function: () {
              //     controller.goToOnBoarding3();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
