class About{
  int id;
  String name;
  String body;

  About(this.id, this.name, this.body);

  About.fromJson(Map<String, dynamic> json) :
      id = json["id"],
      name = json["name"],
      body = json["body"];

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "body" : body
  };
}