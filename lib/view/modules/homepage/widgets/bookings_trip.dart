import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jawla/core/constants/images.dart';
import 'package:jawla/model/bookings/bookings_trip_model.dart';
import 'package:jawla/view%20model/homepage/bookings_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors.dart';

class BookingsTrip extends StatelessWidget {
  final BookingsTripModel bookingsTripModel;
  final BookingsCubit controller;

  const BookingsTrip({
    super.key,
    required this.bookingsTripModel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          controller.goToProgramDetails(bookingsTripModel.id);
        },
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 2.h),
          width: 90.w,
          height: 23.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // Background Image with Placeholder
                Positioned.fill(
                  child:
                      bookingsTripModel.images?.mainImage == null ||
                              bookingsTripModel.images!.mainImage!.isEmpty
                          ? Image.asset(AppImages().bj1, fit: BoxFit.cover)
                          : CachedNetworkImage(
                            imageUrl: bookingsTripModel.images!.mainImage!,
                            fit: BoxFit.cover,
                          ),
                ),

                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),

                // Ticket Count (instead of CircleAvatar)
                Positioned(
                  top: 1.h,
                  right: 3.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.confirmation_num,
                          size: 18,
                          color: AppColor.secondColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${bookingsTripModel.paymentAmount ?? 1}", // Use actual ticket count
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // VIP Crown
                if (bookingsTripModel.type == "VIP")
                  Positioned(
                    top: 1.2.h,
                    left: 3.w,
                    child: Image.asset(
                      AppImages().crown,
                      width: 9.w,
                      height: 4.h,
                    ),
                  ),

                // Details Container
                Positioned(
                  bottom: 1.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Location
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                bookingsTripModel.title ?? "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.secondColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: AppColor.secondColor,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  bookingsTripModel.location ?? "",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColor.secondColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Duration
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 16,
                              color: AppColor.secondColor,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              "${bookingsTripModel.duration ?? 1} Days",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: AppColor.secondColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Price and Show Details
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  size: 18,
                                  color: AppColor.secondColor,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  "${bookingsTripModel.price} L.E",
                                  style: TextStyle(
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.secondColor,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                controller.goToProgramDetails(
                                  bookingsTripModel.id,
                                );
                              },
                              child: Container(
                                width: 23.w,
                                height: 3.5.h,
                                decoration: BoxDecoration(
                                  color: AppColor.secondColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Show Details",
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
