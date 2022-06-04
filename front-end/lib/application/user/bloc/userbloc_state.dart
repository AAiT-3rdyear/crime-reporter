part of 'userbloc_bloc.dart';

abstract class UserblocState extends Equatable {
  const UserblocState();

  @override
  List<Object> get props => [];
}

class UserblocInitial extends UserblocState {}

class SelectDateTimeFailed extends UserblocState {}

class SelectDateSucessful extends UserblocState {
  final date;
  const SelectDateSucessful({this.date});
}

class SelectTimeSucessful extends UserblocState {
  final time;
  const SelectTimeSucessful({this.time});
}

class SelectDestinationSucessful extends UserblocState {
  final destination;
  const SelectDestinationSucessful({this.destination});
}

class ImageUploaded extends UserblocState {
  final image;
  ImageUploaded({this.image});
}

class ImageDeleted extends UserblocState {
  final index;
  ImageDeleted({this.index});
}
class ImageDeleteFailed extends UserblocState {}

class CameraImageAded extends UserblocState {
  dynamic image;
  CameraImageAded({this.image});
}
class ImageNotAded extends UserblocState {}


class GalleryImageAded extends UserblocState {
  dynamic image;
  GalleryImageAded({this.image});
}

class StationFound extends UserblocState {
  dynamic stations;
  StationFound({this.stations});
}
class StationNotFound extends UserblocState {}

class ImagePosted extends UserblocState {
  dynamic response;
  ImagePosted({this.response});
}

class ImagePostFailed extends UserblocState {}

class SampleFound extends UserblocState {}

class SampleFoundFailed extends UserblocState {}

class ReportFound extends UserblocState {
  dynamic myreports;
  ReportFound({required this.myreports});
}

class ReportFoundFailed extends UserblocState {}

class SucessfullyReported extends UserblocState {}

class EditProfileFailed extends UserblocState {}

class EditProfileSucessfull extends UserblocState {
  dynamic response;
  EditProfileSucessfull({required this.response});
}

class DeleteSucessfull extends UserblocState {}

class DeleteFailed extends UserblocState {}
class SelectDestinationFailed extends UserblocState {}
