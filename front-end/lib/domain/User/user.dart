import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User{
  @JsonKey(name: "_id")
   String userId;
   String fullname;
   String email;
   @JsonKey(name:'phone_no')
   String phoneNo;
   String password;
   String role;
   String imgUrl;

  User({
      required this.userId,
      required this.fullname,
      required this.email,
      required this.phoneNo,
      required this.password,
      required this.role,
      required this.imgUrl
    });

    factory User.fromJson(Map<String,dynamic> json) =>_$UserFromJson(json);
    Map<String,dynamic> toJson() =>_$UserToJson(this);
       
    
}