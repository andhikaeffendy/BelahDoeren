class Profile{

  int id;
  String name;
  String email;
  String photo;
  String phone_number;
  int gender;
  String birth_date;
  String address;
  int district_id;
  String district_name;

  Profile(
      this.id,
      this.name,
      this.email,
      this.photo,
      this.phone_number,
      this.gender,
      this.birth_date,
      this.address,
      this.district_id,
      this.district_name);

  Profile.fromJson(Map<String, dynamic> json ) :
      id = json["id"],
  name = json["name"],
  email = json["email"],
  photo = json["photo"],
  phone_number = json["phone_number"],
  gender = json["gender"],
  birth_date = json["birth_date"],
  address = json["address"],
  district_id = json["district_id"],
  district_name = json["district_name"]
  ;

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "email" : email,
    "photo" : photo,
    "phone_number" : phone_number,
    "gender" : gender,
    "birth_date" : birth_date,
    "address" : address,
    "district_id" : district_id,
    "district_name" : district_name
  };

}