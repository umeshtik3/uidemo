import 'dart:convert';

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));
List<DataModel> dataModelList(String str) => List<DataModel>.from(json.decode(str).map((e) => PageModel.fromJson(e)));
SingleUserModel singleUserModelFromJson(String str) => SingleUserModel.fromJson(json.decode(str));

String page = "page";
String perPage = "per_page";
String total = "total";
String totalPages = "total_pages";
String userData = "data";
String userDataId = "id";
String userEmail = "email";
String userFirstName = "first_name";
String userLastName = "last_name";
String userAvatarLink = "avatar";

class PageModel {
  final int? pageNumber;
  final int? perPageItems;
  final int? totalNumberOfItems;
  final int? totalNumberOfPages;
  final List<DataModel>? listOfDataModel;

  factory PageModel.fromJson(Map<String, dynamic> fromJsonMap) {
    return PageModel(
        pageNumber: fromJsonMap[page],
        perPageItems: fromJsonMap[perPage],
        totalNumberOfItems: fromJsonMap[total],
        totalNumberOfPages: fromJsonMap[totalPages],
        listOfDataModel: List<DataModel>.from(fromJsonMap[userData].map((e) => DataModel.fromJson(e))));
  }

  PageModel({this.pageNumber, this.perPageItems, this.totalNumberOfItems, this.totalNumberOfPages, this.listOfDataModel});
}

class DataModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatarLink;

  DataModel({this.id, this.email, this.firstName, this.lastName, this.avatarLink});

  factory DataModel.fromJson(Map<String, dynamic> fromJsonMap) {
    return DataModel(
        id: fromJsonMap[userDataId],
        email: fromJsonMap[userEmail],
        firstName: fromJsonMap[userFirstName],
        lastName: fromJsonMap[userLastName],
        avatarLink: fromJsonMap[userAvatarLink]);
  }
}

class SingleUserModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatarLink;

  SingleUserModel({this.id, this.email, this.firstName, this.lastName, this.avatarLink});

  factory SingleUserModel.fromJson(Map<String, dynamic> fromJsonMap) {
    return SingleUserModel(
        id: fromJsonMap[userData][userDataId],
        email: fromJsonMap[userData][userEmail],
        firstName: fromJsonMap[userData][userFirstName],
        lastName: fromJsonMap[userData][userLastName],
        avatarLink: fromJsonMap[userData][userAvatarLink]);
  }
}
