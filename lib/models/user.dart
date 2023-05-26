class UserModel {
  String? uid;
  String? name;
  String? phone;
  String? address;
  String? nid;
  String? role;
  String? pic;

  UserModel({this.uid, this.name, this.phone, this.address, this.nid, this.role, this.pic});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    nid = json['nid'];
    role = json['role'];
    pic = json['pic'];
  }
}
