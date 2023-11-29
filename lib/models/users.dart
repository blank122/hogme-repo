class Users {
  //initialized the user data models into null safety values
  String id;
  String firstname;
  String lastname;
  String contactnumber;
  String profilepicture;
  String facilitypicture;
  String valididpicture;
  String email;
  String password;
  String status;
  String role;

  //assigned the values
  Users({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.contactnumber,
    required this.profilepicture,
    required this.facilitypicture,
    required this.valididpicture,
    required this.email,
    required this.password,
    required this.status,
    required this.role,
  });

  //convert the data format into json format
  factory Users.fromJson(Map<String, dynamic> json) {
    // return Users(
    //   id: json['id'],
    //   firstname: json['firstname'],
    //   lastname: json['lastname'],
    //   contactnumber: json['contactnumber'],
    //   profilepicture: json['facilitypicture'],
    //   email: json['email'],
    //   password: json['password'],
    //   status: json['status'],
    //   role: json['role'],
    // );
    return Users(
      id: json['id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      contactnumber: json['contactnumber'] ?? '',
      profilepicture: json['profilepicture'] ?? '',
      facilitypicture: json['facilitypicture'] ?? '',
      valididpicture: json['valididpicture'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      status: json['status'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "contactnumber": contactnumber,
        "profilepicture": profilepicture,
        "facilitypicture": facilitypicture,
        "valididpicture": valididpicture,
        "email": email,
        "password": password,
        "status": status,
        "role": role,
      };
}
