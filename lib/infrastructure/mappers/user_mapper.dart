


import 'package:aegis/domain/entities/user.dart';

class UserMapper {

  static User toEntity(Map<String,dynamic> json) => User.fromJson(json);

}