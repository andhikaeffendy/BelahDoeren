class GetReward{

  int id;
  String name;
  String image_url;

  GetReward({this.id, this.name, this.image_url});

  GetReward.fromJson(Map<String, dynamic> json):
      id = json["id"],
  name = json["name"],
  image_url = json["image_url"];

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "image_url" : image_url
  };


}