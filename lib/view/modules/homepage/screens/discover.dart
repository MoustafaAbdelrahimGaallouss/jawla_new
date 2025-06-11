import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jawla/core/constants/colors.dart';
import 'package:jawla/view%20model/app_state.dart';
import 'package:jawla/view%20model/homepage/discover_cubit.dart';
import 'package:jawla/view/modules/homepage/widgets/discover_destination_widget.dart';
import 'package:jawla/view/modules/homepage/widgets/discover_search.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverCubit(),
      child: Builder(
        builder: (context) {
          var controller = context.read<DiscoverCubit>();
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.secondColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DiscoverSearch(controller: controller),
                  BlocBuilder<DiscoverCubit, AppState>(
                    builder: (context, state) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DiscoverDestinationWidget(
                              destination: controller.data[index],
                            );
                          },
                        ),
                      );
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
