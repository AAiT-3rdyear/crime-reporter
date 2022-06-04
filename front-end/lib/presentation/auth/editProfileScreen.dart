import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../application/user/bloc/userbloc_bloc.dart';


class EditProfile extends StatefulWidget {
  EditProfile({Key? key ,this.user}) : super(key: key);
  dynamic user;

  @override
  State<EditProfile> createState() => _EditProfileState();
  }

class _EditProfileState extends State<EditProfile> {
  
  final List<XFile?> _image = [];  
  TextEditingController namecontroler = TextEditingController();
  TextEditingController phonecontroler = TextEditingController();
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();
 
  
Future getImage(ImageSource source) async {
    try {
        final image = await ImagePicker().pickMultiImage();
        final userBloc =BlocProvider.of<UserblocBloc>(context);
            userBloc.add(EditProfiles(image,widget.user.email),);

       } catch (eror) {}}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Edit Profile",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Center(
            child: Text("Edit Profile",
            style: TextStyle(color: Colors.black),)),
          leading: IconButton(
            onPressed: () {context.go('/myprofile',extra:widget.user);},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          margin:const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                       _image.isEmpty? Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black45.withOpacity(0.7)),
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('http://10.0.2.2:3000/uploads/${widget.user.imgUrl}'),
                                fit: BoxFit.cover)),
                      ) 
                  :
              BlocBuilder <UserblocBloc, UserblocState>(
              builder: (_,UserblocState userState){
                
                  if (userState is EditProfileSucessfull){
                   _image.removeAt(0);
                   _image.addAll(userState.response);
                   return Container(
                    width: 130,
                    height: 130,
                     decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(spreadRadius: 2,blurRadius: 10,
                              color: Colors.black45.withOpacity(0.7)),
                        ],),
                    child: ClipRRect(
                     borderRadius: BorderRadius.circular(100.0),
                      child: Image.file( 
                        File(_image[0]!.path),
                        fit: BoxFit.cover,),
                      ),
                    );
                  }else{
                    return const Text('');
                  }}),

                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: InkWell(
                      onTap: ()=>{_bottomSheet(context)},
                      child: MouseRegion(
                        cursor: SystemMouseCursors.zoomIn,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            border: Border.all(
                              width: 4,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name"),
                    TextFormField(
                      controller: namecontroler,
                      textInputAction: TextInputAction.go,
                      decoration:  InputDecoration(
                         hintText:widget.user.fullname,
                          suffixIcon:  const Icon(Icons.person_off_outlined)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Email"),
                    TextFormField(
                      controller: emailcontroler,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                           hintText: widget.user.email,
                          suffixIcon: const  Icon(Icons.email)),
                    ),
                  ],
                ),
               
               const  SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text( "password",
                      style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    TextFormField(
                      controller: passwordcontroler,
                      textInputAction: TextInputAction.go,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: widget.user.fullname,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility)
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Phone Number"),
                    TextFormField(
                      controller: phonecontroler,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: widget.user.phoneNo,
                          suffixIcon: const Icon(Icons.phone),
                          suffixIconColor: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),


             BlocConsumer<UserblocBloc, UserblocState>(
                  listener: (context, state) {
                    if (state is EditProfileSucessfull ){
                      showDialog(context: context, builder: (context){
                          return const  AlertDialog(
                            title : Text('successfuly updated'),
                            );
                        });

                      }},

                  builder:(_, UserblocState state){
                    return Container(
                     child: Center(
                      child: ElevatedButton(
                        child: const Text("Update",
                          style: TextStyle(color: Colors.black),
                        ),
                         onPressed: () async{
                           final userBloc =BlocProvider.of<UserblocBloc>(context);
                              userBloc.add(UpdateProfile(
                              passwordcontroler.text,
                              emailcontroler.text,
                              phonecontroler.text,
                              namecontroler.text,
                        ),);
                        if (state is EditProfileSucessfull){
                        context.go('/welcomeScreen',extra:state.response);
                        }
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                      ),
                    ),
                  ); 
                 },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                      CustomButton(
                          title: 'pick from gallllery',
                          icon: Icons.image_outlined,
                          OnClick: () => getImage(ImageSource.gallery)),
                    const SizedBox(
                      height: 30,
                    ),
                      
                  ],
                ),
              ),
            ],
          );
        });
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
}
