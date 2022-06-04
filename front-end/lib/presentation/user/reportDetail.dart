import 'package:crime_reporter/infrastructure/repository/user_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';

import '../../application/user/bloc/userbloc_bloc.dart';


class CrimeDetail extends StatefulWidget {
 CrimeDetail({ Key? key , this.foundStations}) : super(key: key);
   dynamic foundStations;
  dynamic user;
  @override
  State<CrimeDetail> createState() => _DetailScreenState();
  }


class _DetailScreenState extends State<CrimeDetail> {
dynamic _timeOfDay = const TimeOfDay(hour: 10, minute: 30);
 TextEditingController descriptionControler = TextEditingController();
 TextEditingController placeControler = TextEditingController();
 ScrollController scrollController = ScrollController();
 UserRepository userRepo = UserRepository();
  dynamic _dueDate = DateTime.now();
  String selectedValue ='';
  final List<XFile?> _image = [];
  late IO.Socket socket;
  dynamic myreports;
  dynamic response;
  dynamic response3;
  dynamic targetID;
  

  Future getImage(ImageSource source) async {
    
    try {
      if (source == ImageSource.gallery) {
        final image = await ImagePicker().pickMultiImage();
        if (image == null) return;
            final userBloc =BlocProvider.of<UserblocBloc>(context);
            userBloc.add(UploadFromGallery(image),);
           } else {
              final image = await ImagePicker().pickImage(source: ImageSource.camera);
              if (image == null) return;
              
              final userBloc =BlocProvider.of<UserblocBloc>(context);
              userBloc.add(UploadFromCamera(image),);
              }
   } catch (eror) {}}

  

  @override
  void initState() {super.initState();connect();}

   dynamic connect(){
     try {
        socket = IO.io('http://10.0.2.2:3000', <String, dynamic>
        {'transports': ['websocket'], 'autoConnect': false,});
              socket.connect();
              socket.emit("login",widget.user.userId);
              socket.onConnect((data) {
                  });
                  
    socket.on('disconnect', (_) => print('disconnect'));
    } catch (e) {print(e.toString());}}


      reportHandler() async {
      response = await userRepo.reportCrime({
           "description":descriptionControler.text,
           "location":placeControler.text,
           "time": _dueDate.toString()+ "at" +_timeOfDay.toString(),
           "imageURL":json.decode(response3.body)['path'],
           "report_to":selectedValue,
           "status":"reported",
           "reporter":jsonEncode(widget.user)
           });}

      


  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          backgroundColor: Colors.white,
          title: const Center(
            child: Text("Incidents",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: SizedBox(
          height: 1000,

           child:BlocBuilder <UserblocBloc, UserblocState>(
              
              builder: (_,UserblocState userState){
     
              if (userState is SelectDateSucessful){
                  _dueDate = userState.date;}
              if (userState is SelectTimeSucessful){
                  _timeOfDay = userState.time;}
              if (userState is SelectDestinationSucessful){
                  selectedValue = userState.destination;}
              if (userState is ImageDeleted){
                 _image.removeAt(userState.index);}
              if (userState is CameraImageAded){
                  _image.add(userState.image);}
              if (userState is GalleryImageAded){
                  _image.addAll(userState.image);}
    
          return ListView(
            controller: scrollController,
            children: [
              Container(
                height: 45,
                color: Colors.yellow[700],
                child: const ListTile(
                  leading: Icon(
                    Icons.local_police_rounded,
                    color: Colors.black, size: 30,
                  ),
                  title: Text("Incidents details",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              
          
               Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text( "When did it happen ?",
                                style: TextStyle(fontSize: 20),),
                          const Divider(color: Colors.black,),
                           
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Date',style: TextStyle(fontSize: 18.0),),
                              TextButton(
                                child: const Text('Select'),
                                onPressed: () async {
                                  final currentDate = DateTime.now();
                                  final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: currentDate,
                                      firstDate: currentDate,
                                      lastDate: DateTime(currentDate.year + 5),);
                                   
                                    final userBloc =BlocProvider.of<UserblocBloc>(context);
                                    userBloc.add(SelectDate(selectedDate),);
                                   },
                              ),
                            ],
                          ),
                          Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
                        ],
                      ),
                     
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Time',style: TextStyle(fontSize: 18.0),),
                              TextButton(
                                child: const Text('Select'),
                                onPressed: () async {
                                    final timeOfDay = await showTimePicker(
                                    initialTime: TimeOfDay.now(),
                                    context: context,);
                                  final userBloc =BlocProvider.of<UserblocBloc>(context);
                                  userBloc.add(SelectTime(timeOfDay)); 
                                },
                              ),
                            ],
                          ),
                          Text(_timeOfDay.format(context)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
             
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text("Where did it happen ?",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextField(
                        controller: placeControler,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "place where the crime happen"),
                      ),
                    ],
                  ),
                ),
              ),
              
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text("What happened?",
                        style: TextStyle(fontSize: 20),
                      ),
                     TextField(
                        controller: descriptionControler,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "place where the crime happen"),
                            maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ),
             
              
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Select Destination",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: DropdownButton<String>(
                            value: selectedValue,
                            dropdownColor: const Color.fromARGB(255, 205, 245, 207),
                            onChanged: (String? newValue) {
                              final userBloc =BlocProvider.of<UserblocBloc>(context);
                              userBloc.add(SelectDestination(newValue),);   
                            },
                            items:widget.foundStations['stations'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                       ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Card(
                child: Column(
                  children: [
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow[700],),
                        child: const Text( "Upload image",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          scrollController.animateTo(800,
                          duration: const Duration(milliseconds: 1000),
                           curve: Curves.easeInOut);
                          final userBloc =BlocProvider.of<UserblocBloc>(context);
                          userBloc.add(UploadImage(),);
                        },
                      ),
                    )
                  ],
                ),
              ),
              
            (userState is ImageUploaded || userState is CameraImageAded 
            || userState is GalleryImageAded)? 
              Positioned(
              child: Container(height: 400,
              child: Center(
                child: Column(
              children: <Widget>[
                Expanded(
                 child: Container(
                          margin: const EdgeInsets.all(15),
                          child: _image.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(15.0),
                                  color: const Color.fromARGB(255, 170, 182, 191),
                                  margin: const EdgeInsets.all(15),
                                  width: double.infinity,
                                )
                                
                              : Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(File(_image[0]!.path),fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                        top: 5,
                                        right: 10,
                                        child: Container(
                                          child: IconButton(
                                            onPressed: () {
                                              final userBloc =BlocProvider.of<UserblocBloc>(context);
                                              userBloc.add(DeleteImage(0),);
                                            },
                                            icon: const Icon(Icons.remove_circle_outline),
                                            color: const Color.fromARGB(221, 170, 6, 6),
                                            iconSize: 25.0,
                                          ),
                                          padding: const EdgeInsets.all(1.0),
                                          margin: const EdgeInsets.fromLTRB(0, 5.0, 0, 0.0),
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(198, 233, 216, 34),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0)),
                                          ),
                                        ))
                                  ],
                                ))   
                           ),
            
                const SizedBox(height: 10,),
            
                if (_image.length == 1)
                  CustomButton(title: 'Report now',
                      icon: Icons.image_outlined,
                    OnClick: ()async{
                        
                        selectDestin();
                        response3 = await  userRepo.postImage(_image[0]!.path);  
                        sendCrime();
                         final userBloc =BlocProvider.of<UserblocBloc>(context);
                          userBloc.add(ReportNows());
                        showDialog(context: context, builder: (context){
                          return  AlertDialog(
                            title :const Text('successfuly reported'),
                            actions: [
                          FlatButton(onPressed:()=>context.go('/crimeDetail'),
                          child: const Text('report another'
                          ,style: TextStyle(color: Color.fromARGB(255, 20, 144, 247)),)),
                            ],
                          );
                        });
                         }),
            
                if (_image.isEmpty)
                  CustomButton(
                      title: 'pick image',
                      icon: Icons.image_outlined,
                      OnClick: () => _bottomSheet(context)),
                      ],
                      ),)),):const Text('') 
              ],
            );
         
          })
        ),
      ),
    )
  );

  }

  void sendCrime()async{
        try {
         socket.emit("report",{"crime":{
           "description":descriptionControler.text,
           "location":placeControler.text,
           "time":_dueDate.toString()+ "at" +_timeOfDay.toString(),
           "imageURL":json.decode(response3.body)['path'],
           "report_to":selectedValue,
           "status":"reported",
           "reporter":widget.user},
           "sourceID":'89765645345566',
           "targetID":targetID
           });
            await reportHandler();
      } catch (e) {print(e.toString());}
    }

void selectDestin( ){
for (var i=0 ; i < json.decode(widget.foundStations['response2'].body).length ; i++){
       if (json.decode(widget.foundStations['response2'].body)[i]["fullname"]== selectedValue){
       targetID = json.decode(widget.foundStations['response2'].body)[i]["_id"] ;
    }
}
}
_bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Wrap(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      height: 2.0,
                    ),
                    if (_image.length != 4)
                      CustomButton(
                          title: 'pick from gallllery',
                          icon: Icons.image_outlined,
                          OnClick: () => getImage(ImageSource.gallery)),
                    const SizedBox(
                      height: 30,
                    ),
                    if (_image.length != 4)
                      CustomButton(
                          title: 'pick up for camera',
                          icon: Icons.image_outlined,
                          OnClick: () => getImage(ImageSource.camera)),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback OnClick,
}) {
  return Container(
    width: 200,
    child: ElevatedButton(
        onPressed: OnClick,
        child: Row(
          children: <Widget>[
            Icon(icon),
            const SizedBox(
              width: 20,
            ),
            Text(title),
          ],
        )),
  );
}










