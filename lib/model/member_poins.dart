import 'package:belah_duren/model/member_level.dart';

class MemberPoints{

  int points;
  String member_level_name;
  String image_url;
  List<MemberLevel> levels = [];

  MemberPoints(
      this.points,
      this.member_level_name,
      this.image_url);

  MemberPoints.fromJson(Map<String, dynamic> json) :
      points = json["points"],
      member_level_name = json["member_level_name"],
      image_url = json["image_url"];

  Map<String, dynamic> toJson() => {
    "points" : points,
    "member_level_name" : member_level_name,
    "image_url" : image_url
  };

}