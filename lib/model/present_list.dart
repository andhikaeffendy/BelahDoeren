class PresentList{
  int id;
  String name;
  String description;
  int point;
  String image_url;
  int present_status;

  PresentList({
    this.id,
    this.name,
    this.description,
    this.point,
    this.image_url,
    this.present_status});

  PresentList.fromJson(Map<String, dynamic> json ) :
      id = json["id"],
      name = json["name"],
  description = json["description"],
  point = json["point"],
  image_url = json["image_url"],
  present_status = json["present_status"];

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "description" : description,
    "point" : point,
    "image_url" : image_url,
    "present_status" : present_status
  };

}