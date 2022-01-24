
class User {
  final int id;
  final String lastName;
  final String firstName;
  final String url;
  final bool status;
  final String createdAt;
  final String updatedAt;

  User(this.id, this.lastName, this.firstName, this.url, this.status, this.createdAt, this.updatedAt,
        );

  User.fromJson(Map<String, dynamic> json)
      :   id = json['id'],
    lastName= json['last_name'],
    firstName = json['first_name'],
    url = json['url'],
    status = json['status']=="active"?true:false,
    createdAt = json['created_at'],
    updatedAt = json['updated_at'];

}

