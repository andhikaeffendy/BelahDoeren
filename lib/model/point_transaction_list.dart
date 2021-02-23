class PointTransactionList{
  int id;
  String present_name;
  int point_redeemed;
  int remaining_point;
  String image_url;

  PointTransactionList({this.id, this.present_name, this.point_redeemed,
      this.remaining_point, this.image_url});

  PointTransactionList.fromJson(Map<String, dynamic> json ) :
      id = json["id"],
  present_name = json["present_name"],
  point_redeemed = json["point_redeemed"],
  remaining_point = json["remaining_point"],
  image_url = json["image_url"];

  Map<String, dynamic> toJson() => {
    "id" : id,
    "present_name" : present_name,
    "point_redeemed" : point_redeemed,
    "remaining_point" : remaining_point,
    "image_url" : image_url
  };

}