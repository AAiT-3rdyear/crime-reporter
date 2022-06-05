import 'package:json_annotation/json_annotation.dart';

part 'samplecrimes.g.dart';

@JsonSerializable()
class SampleCrime{
  @JsonKey(name: 'imageURL')
  String image;
  String name;

  SampleCrime({
    required this.image,
    required this.name
  });

  factory SampleCrime.fromJson(Map<String,dynamic> json) =>_$SampleCrimeFromJson(json);
  Map<String,dynamic> toJson() =>_$SampleCrimeToJson(this);
       
}

