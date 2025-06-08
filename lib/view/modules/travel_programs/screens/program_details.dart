import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jawla/core/constants/colors.dart';
import 'package:jawla/core/constants/lottie.dart';
import 'package:jawla/model/trip/trip_details_model.dart';
import 'package:jawla/view%20model/app_state.dart';
import 'package:jawla/view%20model/homepage/favorite_cubit.dart';
import 'package:jawla/view%20model/travel_programs/program_details_cubit.dart';
import 'package:jawla/view/modules/travel_programs/widgets/about_these_places.dart';
import 'package:jawla/view/modules/travel_programs/widgets/custom_container.dart';
import 'package:jawla/view/modules/travel_programs/widgets/program_details_image_widget.dart';
import 'package:jawla/view/modules/travel_programs/widgets/places_images.dart';
import 'package:jawla/view/widgets/custom_appbar.dart';
import 'package:jawla/view/widgets/warning_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ProgramDetails extends StatelessWidget {
  const ProgramDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgramDetailsCubit(),
      child: Builder(
        builder: (context) {
          var controller = context.read<ProgramDetailsCubit>();
          var favoriteController = context.read<FavoriteCubit>();
          controller.getTripDetails(controller.id);

          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.secondColor,
              body: Column(
                children: [
                  const CustomAppbar(),
                  BlocConsumer<ProgramDetailsCubit, AppState>(
                    listener: (context, state) {
                      if (state is InternetError) {
                        warningWidget(
                          "Connection Error",
                          Icons.wifi_off_rounded,
                          "Please check your internet connection and try again.",
                        );
                      } else if (state is ServerError) {
                        warningWidget(
                          "Server Error",
                          Icons.cloud_off,
                          "Please check your server connection and try again.",
                        );
                      } else if (state is ApiFailure) {
                        warningWidget("Wrong", Icons.error, "${state.error}");
                      }
                    },
                    builder: (context, state) {
                      if (state is Loading) {
                        return SizedBox(
                          width: 100.w,
                          height: 82.h,
                          child: Center(
                            child: Lottie.asset(
                              AppLottie().loading3,
                              height: 200,
                            ),
                          ),
                        );
                      } else {
                        TripDetailsModel tripDetailsModel =
                            TripDetailsModel.fromJson(controller.data[0]);

                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProgramDetailsImageWidget(
                                          favoriteController:
                                              favoriteController,
                                          tripDetailsModel: tripDetailsModel,
                                          controller: controller,
                                        ),
                                        SizedBox(height: 2.h),
                                        PlacesImages(
                                          tripDetailsModel: tripDetailsModel,
                                          controller: controller,
                                        ),
                                        SizedBox(height: 2.h),
                                        AboutThesePlaces(
                                          tripDetailsModel: tripDetailsModel,
                                        ),
                                        SizedBox(height: 2.h),

                                        /// Duration
                                        CustomContainer(
                                          widget: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.date_range,
                                                    color: AppColor.secondColor,
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  const Text(
                                                    "Length",
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.secondColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${tripDetailsModel.duration} Days",
                                                style: const TextStyle(
                                                  color: AppColor.secondColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 1.5.h),

                                        /// Persons Counter
                                        CustomContainer(
                                          widget: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.groups,
                                                    color: AppColor.secondColor,
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  const Text(
                                                    "Persons",
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.secondColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller.decrement();
                                                    },
                                                    child: const CircleAvatar(
                                                      backgroundColor:
                                                          AppColor.secondColor,
                                                      radius: 15,
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  Text(
                                                    "${controller.numOfPersons}",
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.secondColor,
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  InkWell(
                                                    onTap: () {
                                                      controller.increment();
                                                    },
                                                    child: const CircleAvatar(
                                                      backgroundColor:
                                                          AppColor.primaryColor,
                                                      radius: 15,
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// Bottom Booking Bar
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.h,
                                ),
                                width: 100.w,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColor.bottomNavColor,
                                      AppColor.bottomNavColor2,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.numOfPersons * controller.data[0]['price']} L.E",
                                          style: const TextStyle(
                                            color: AppColor.secondColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "(${controller.numOfPersons} Persons)",
                                          style: const TextStyle(
                                            color: AppColor.secondColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: controller.goToPaymentMethods,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 1.2.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: const Text(
                                          "Book Now",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
