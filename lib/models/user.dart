class UserModel {
  String? uid;
  String? name;
  String? address;
  String? nid;
  String? role;
  String? pic;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    address = json['address'];
    nid = json['nid'];
    role = json['role'];
    pic = json['pic'];
  }
}
