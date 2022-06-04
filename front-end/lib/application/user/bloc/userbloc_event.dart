part of 'userbloc_bloc.dart';

abstract class UserblocEvent extends Equatable {
  const UserblocEvent();

  @override
  List<Object> get props => [];
}

class GetMyReports extends UserblocEvent {
  dynamic msg;
  GetMyReports(this.msg);
}

class AddImage extends UserblocEvent {
  dynamic msg;
  AddImage(this.msg);
}

class DeleteImage extends UserblocEvent {
  int index;
  DeleteImage(this.index);
}

class SelectDestionation extends UserblocEvent {
  dynamic msg;
  SelectDestionation(this.msg);
}

class SendCrime extends UserblocEvent {
  dynamic msg;
  SendCrime(this.msg);
}

class ViewReported extends UserblocEvent {
  dynamic msg;
  ViewReported(this.msg);
}

class SelectDate extends UserblocEvent {
  dynamic date;
  SelectDate(this.date);
}

class SelectTime extends UserblocEvent {
  dynamic time;
  SelectTime(this.time);
}

class SelectDestination extends UserblocEvent {
  dynamic destination;
  SelectDestination(this.destination);
}

class UploadImage extends UserblocEvent {}

class UploadFromCamera extends UserblocEvent {
  dynamic image;
  UploadFromCamera(this.image);
}

class UploadFromGallery extends UserblocEvent {
  dynamic image;
  UploadFromGallery(this.image);
}

class GetStations extends UserblocEvent {}

class ReportNow extends UserblocEvent {
  dynamic image;
  ReportNow(this.image);
}

class PostImage extends UserblocEvent {
  dynamic path;
  PostImage(this.path);
}

class GetSample extends UserblocEvent {}

class GetMyReport extends UserblocEvent {
  dynamic id;
  GetMyReport(this.id);
}

class EditProfiles extends UserblocEvent {
  dynamic path;
  dynamic email;
  EditProfiles(this.path, this.email);
}

class UpdateProfile extends UserblocEvent {
  dynamic password;
  dynamic email;
  dynamic phoneNo;
  dynamic fullname;
  UpdateProfile(this.password, this.email, this.phoneNo, this.fullname);
}

class DeleteReported extends UserblocEvent {
  dynamic id;
  DeleteReported(this.id);
}

class ReportNows extends UserblocEvent {}
