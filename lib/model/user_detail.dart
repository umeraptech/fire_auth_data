class UserDetails{
  final String firstName;
  final String lastName;
  final String city;

  UserDetails({required this.firstName, required this.lastName, required this.city});

  UserDetails.fromJson(Map<dynamic,dynamic> json):
        firstName=json['firstName'] as String,
        lastName =json['lastName'] as String,
        city = json['city'] as String;


  Map<dynamic,dynamic> toJson() => <dynamic,dynamic>{
    'firstName':firstName,
    'lastName':lastName,
    'city':city,
  };

  Map<String,dynamic> toMap()=> <String,dynamic>{
    'firstName':firstName,
    'lastName':lastName,
    'city':city
  };
}