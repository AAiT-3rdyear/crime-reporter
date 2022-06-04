import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/repository/user_repositories.dart';
part 'userbloc_event.dart';
part 'userbloc_state.dart';

class UserblocBloc extends Bloc<UserblocEvent, UserblocState> {
  final userRepository = UserRepository();

  UserblocBloc() : super(UserblocInitial()) {
    on<SelectDate>(_onSelectDate);
    on<UploadImage>(_onUploadImage);
    on<SelectTime>(_onSelectTime);
    on<DeleteImage>(_onDeleteImage);
    on<GetStations>(_onGetStations);
    on<PostImage>(_onPostImage);
    on<GetMyReport>(_onGetMyReport);
    on<DeleteReported>(_onDeleteReported);
    on<GetSample>(_onGetSample);
    on<EditProfiles>(_onEditProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UploadFromCamera>(_onUploadFromCamera);
    on<UploadFromGallery>(_onUploadFromGAllery);
    on<SelectDestination>(_onSelectDestination);
    on<ReportNows>(_onReport);
  }

  void _onSelectDate(SelectDate event, Emitter emit) async {
    emit(UserblocInitial());
    if (event.date == null) {
      emit(SelectDateTimeFailed());
    } else {
      emit(SelectDateSucessful(date: event.date));
    }
  }

  void _onSelectTime(SelectTime event, Emitter emit) async {
    emit(UserblocInitial());
    if (event.time == null) {
      emit(SelectDateTimeFailed());
    } else {
      emit(SelectTimeSucessful(time: event.time));
    }
  }

 void _onPostImage(PostImage event, Emitter emit) async {
    final response = await userRepository.postImage(event.path);
    if (response == null) {
      emit(ImagePostFailed);
    } else {
      emit(ImagePosted(response: response));
    }
  }

  void _onSelectDestination(SelectDestination event, Emitter emit) async {
    if(event.destination == null){
      emit(SelectDestinationFailed);
    }else{
    emit(SelectDestinationSucessful(destination: event.destination));

      }
  }

  void _onDeleteImage(DeleteImage event, Emitter emit) async {
     if (event.index == null){
        emit(ImageDeleteFailed);
       }else{
    emit(ImageDeleted(index: event.index));

     }
  }

  void _onUploadFromCamera(UploadFromCamera event, Emitter emit) async {
    
    if (event.image == null ){
      emit(ImageNotAded);
    }else{
    emit(CameraImageAded(image: event.image));
    }  
  }
  
  void _onUploadFromGAllery(UploadFromGallery event, Emitter emit) async {
    if(event.image == null){
      emit(ImageNotAded);
    }else{
    emit(GalleryImageAded(image: event.image));
     }
    
    }

  void _onGetStations(GetStations event, Emitter emit) async {
    final response = await userRepository.getStations();
    if (response == null) {
      emit(StationNotFound);
    } else {
      emit(StationFound(stations: response));
    }
  }

   void _onUploadImage(UploadImage event, Emitter emit) async {
    emit(ImageUploaded());
  }

  void _onGetMyReport(GetMyReport event, Emitter emit) async {
    dynamic myreport = await userRepository.getMyReport(event.id);
    if (myreport == null) {
      emit(ReportFoundFailed);
    } else {
      emit(ReportFound(myreports: myreport));
    }
  }

  void _onGetSample(GetSample event, Emitter emit) async {
    emit(SampleFound());
  }

  void _onEditProfile(EditProfiles event, Emitter emit) async {
    emit(UserblocInitial());
    final response = await userRepository.updateProfileImage(
        event.path[0].path, event.email);
    if (response == null) {
      emit(EditProfileFailed());
    } else {
      emit(EditProfileSucessfull(response: event.path));
    }
  }


  void _onUpdateProfile(UpdateProfile event, Emitter emit) async {
    emit(UserblocInitial());
    final response = await userRepository.updateProfile(
        event.email, event.phoneNo, event.password, event.fullname);
    if (response == null) {
      emit(EditProfileFailed());
    } else {
      final response2 =
          await userRepository.getUser(event.email, event.password);
      emit(EditProfileSucessfull(response: response2));
    }
  }

  void _onReport(ReportNows event, Emitter emit) async {
    emit(SucessfullyReported());
  }

  void _onDeleteReported(DeleteReported event, Emitter emit) async {
    emit(UserblocInitial());
    final response = await userRepository.deleteReported(event.id);
    if (response.statusCode == 200) {
      emit(DeleteSucessfull());
    } else {
      emit(DeleteFailed());
    }
  }
}
