// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['_id'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      phoneNo: json['phone_no'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      imgUrl: json['imgUrl'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.userId,
      'fullname': instance.fullname,
      'email': instance.email,
      'phone_no': instance.phoneNo,
      'password': instance.password,
      'role': instance.role,
      'imgUrl': instance.imgUrl,
    };
