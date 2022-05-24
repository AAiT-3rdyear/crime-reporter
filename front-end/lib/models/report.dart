
import 'package:crime_reporter/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(explicitToJson: true)
class Report{
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