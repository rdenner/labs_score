class User {
  String name;
  String email;
  String photoUrl;
  String uid;

  User(this.name, this.email, this.photoUrl, this.uid);

  User.map(dynamic obj) {
    this.name = obj['name'];
    this.email = obj['email'];
    this.photoUrl = obj['photoUrl'];
    this.uid = obj['uid'];
  }

  User.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.email = map['email'];
    this.photoUrl = map['photoUrl'];
    this.uid = map['uid'];
  }

  static Map<String, dynamic> getMap(User user) {
    var map = new Map<String, dynamic>();
      map['name'] = user.name;
      map['email'] = user.email;
      map['photoUrl'] = user.photoUrl;
      map['uid'] = user.uid;

      return map;
  }
}