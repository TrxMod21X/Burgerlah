class SignUpBody {
  String email;
  String password;
  String phone;
  String name;

  SignUpBody({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;

    return data;
  }
}
