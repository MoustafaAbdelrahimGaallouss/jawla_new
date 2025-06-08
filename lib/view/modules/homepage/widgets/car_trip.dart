import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:jawla/core/constants/colors.dart';
import 'package:jawla/core/constants/images.dart';
import 'package:jawla/model/bookings/bookings_car_model.dart';
import 'package:jawla/view%20model/homepage/bookings_cubit.dart';
import 'package:sizer/sizer.dart';

class CarTrip extends StatelessWidget {
  final CarTripModel carTripModel;
  final BookingsCubit controller;

  const CarTrip({
    super.key,
    required this.carTripModel,
    required this.controller,
  });

  String _formatDate(String? date) {
    if (date == null) return 'Unknown';
    try {
      final parsedDate = DateTime.parse(date);
      final formattedDate = DateFormat('dd/MM - HH:mm').format(parsedDate);
      return formattedDate;
    } catch (e) {
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 2.h),
        width: 90.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages().bj1),
            fit: BoxFit.fill,
            opacity: 0.8,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: EdgeInsets.all(2.5.w),
          padding: const EdgeInsets.all(7),
          width: 85.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(
              255,
              218,
              223,
              235,
            ).withOpacity(0.8).withAlpha(230),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.car_repair_outlined,
                    color: AppColor.secondColor,
                    size: 30.sp,
                  ),
                  carTripModel.state != "Pending"
                      ? InkWell(
                        onTap: () {},
                        child: Container(
                          width: 25.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Accepted",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                      : InkWell(
                        onTap: () {},
                        child: Container(
                          width: 25.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${carTripModel.carType}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.secondColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18.sp,
                        color: AppColor.secondColor,
                      ),
                      Text(
                        "${carTripModel.receivePlace}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColor.secondColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: Colors.white, thickness: 1),
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    size: 17.sp,
                    color: AppColor.secondColor,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "${_formatDate(carTripModel.startDate)}  -->  ${_formatDate(carTripModel.endDate)}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.secondColor,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.groups, size: 17.sp, color: AppColor.secondColor),
                  SizedBox(width: 3.w),
                  Text(
                    "${carTripModel.numberOfPersons}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.secondColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              SizedBox(
                width: double.infinity,
                child:
                    carTripModel.price == null
                        ? Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Admin has not set the price yet",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.red.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // السعر على الشمال
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  size: 17.sp,
                                  color: AppColor.secondColor,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  "${carTripModel.price} L.E",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColor.secondColor,
                                  ),
                                ),
                              ],
                            ),

                            // الزرار على اليمين حسب الحالة
                            carTripModel.state == "Accepted"
                                ? InkWell(
                                  onTap: () {
                                    TextEditingController priceController =
                                        TextEditingController();

                                    Get.defaultDialog(
                                      title: "Set Price",
                                      content: Column(
                                        children: [
                                          const Text(
                                            "Enter a new price for the trip:",
                                          ),
                                          const SizedBox(height: 10),
                                          TextField(
                                            controller: priceController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "Enter price",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      textConfirm: "Confirm",
                                      textCancel: "Cancel",
                                      confirmTextColor: Colors.white,
                                      cancelTextColor: AppColor.secondColor,
                                      buttonColor: AppColor.secondColor,
                                      onConfirm: () {
                                        final input = priceController.text;
                                        if (input.isNotEmpty) {
                                          final price = int.tryParse(input);
                                          if (price != null) {
                                            controller.updatePrice(
                                              carTripModel.type,
                                              carTripModel.id,
                                              price,
                                            );
                                            Get.back();
                                          } else {
                                            Get.snackbar(
                                              "Invalid input",
                                              "Please enter a valid number",
                                            );
                                          }
                                        } else {
                                          Get.snackbar(
                                            "Empty field",
                                            "Please enter a price",
                                          );
                                        }
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColor.secondColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    width: 25.w,
                                    height: 3.h,
                                    child: Center(
                                      child: Text(
                                        "Change price",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                : Row(
                                  children: [
                                    Text(
                                      "Awaiting Admin",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: AppColor.secondColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.hourglass_empty,
                                      color: AppColor.secondColor,
                                    ),
                                  ],
                                ),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
