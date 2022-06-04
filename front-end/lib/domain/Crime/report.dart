
import 'package:crime_reporter/domain/User/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(explicitToJson: true)
class Report{
  
  @JsonKey(name: "_id")
   String crimeId;
   String title;
   String location;
   String time;
   String description;
   String imageURL ;
   @JsonKey(name: "report_to")
   String reportTo ;
   String status;
   User reporter ;

   Report({
      required this.crimeId,
      required this.title,
      required this.location,
      required this.time,
      required this.description,
      required this.imageURL,
      required this.reportTo,
      required this.status,
      required this.reporter,

   });

    factory Report.fromJson(Map<String,dynamic> json) =>_$ReportFromJson(json);
    Map<String,dynamic> toJson() =>_$ReportToJson(this);
       
}