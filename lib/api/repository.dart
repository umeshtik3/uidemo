import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as client;
import 'package:uidemo/models/data_model.dart';

class Repository {
  Future<List<DataModel>?> getPage(int pageKey) async {
    debugPrint("$runtimeType getPage");

    final pageUrl = Uri.parse("https://reqres.in/api/users?page=$pageKey");
    List<DataModel>? dataList;
    var response = await client.get(pageUrl);
    try {
      debugPrint("response status code ${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        final jsonString = (response.body);

        final pageModel = pageModelFromJson(jsonString);
        dataList = pageModel.listOfDataModel;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return dataList;
  }

  Future<SingleUserModel?> getSingleUser(int userId) async {
    debugPrint("$runtimeType getSingleUser");
    final singleUserUrl = Uri.parse("https://reqres.in/api/users/$userId");
    SingleUserModel? singleUser;
    try {
      var response = await client.get(singleUserUrl);
      debugPrint("response status code ${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        final jsonString = response.body;
        singleUser = singleUserModelFromJson(jsonString);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return singleUser;
  }
}
