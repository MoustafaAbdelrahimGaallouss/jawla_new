import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jawla/data/static%20data/static_data.dart';
import 'package:jawla/model/static%20data/static_data_model.dart';
import 'package:jawla/view%20model/app_state.dart';

class DiscoverCubit extends Cubit<AppState> {
  DiscoverCubit() : super(Initial()) {
    allData = StaticData().staticData;
    data = allData;
  }

  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();

  late List<StaticDataModel> allData; // النسخة الأصلية
  late List<StaticDataModel> data; // البيانات المعروضة

  void searchFun() {
    String query = search.text.toLowerCase().trim();
    if (query.isEmpty) {
      data = allData;
    } else {
      data = allData
          .where((item) => item.label.toLowerCase().startsWith(query))
          .toList();
    }
    emit(SearchUpdated()); // حالة جديدة للتحديث
  }
}
