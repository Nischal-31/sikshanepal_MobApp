class User {
  final int id;
  final String username;
  final String email;
  final String? phoneNo;
  final String? firstName;
  final String? lastName;
  final bool termsAgree;
  final bool rememberMe;
  final String? userType;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNo,
    this.firstName,
    this.lastName,
    this.termsAgree = false,
    this.rememberMe = false,
    this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    phoneNo: json['phone_no'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    termsAgree: json['terms_agree'] == true || json['terms_agree'] == 'true',
    rememberMe: json['remember_me'] == true || json['remember_me'] == 'true',
    userType: json['user_type'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'phone_no': phoneNo,
    'first_name': firstName,
    'last_name': lastName,
    'terms_agree': termsAgree,
    'remember_me': rememberMe,
    'user_type': userType,
  };
}
