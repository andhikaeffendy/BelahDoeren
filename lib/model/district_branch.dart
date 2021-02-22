import 'package:belah_duren/model/branch.dart';

class DistrictBranch{
  int id;
  String name;
  List<Items> branchs = [];

  DistrictBranch(
      this.id,
      this.name
      );

  DistrictBranch.fromJson(Map<String, dynamic> json) :
      id = json["id"],
      name = json["name"];

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name
  };

}