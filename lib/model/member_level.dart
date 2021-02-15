class MemberLevel {
  int id;
  String name;
  String description;
  int min_point;
  String image_url;


  MemberLevel(
  {this.id, this.name, this.description, this.min_point, this.image_url});

  MemberLevel.fromJson(Map<String, dynamic> json) :
      id = json["id"],
      name = json["name"],
      description = json["description"],
      min_point = json["min_point"],
      image_url = json["image_url"];

  Map<String, dynamic> toJson() =>
      {
        "id" : id,
        "name" : name,
        "description" : description,
        "min_point" : min_point,
        "image_url" : image_url,
      };

}