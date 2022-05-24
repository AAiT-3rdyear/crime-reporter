import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';


class NetworkHandler{
  String baseUrl = 'http://10.0.2.2:3000';
  var logger = Logger();
 final storage = new FlutterSecureStorage();


  Future <dynamic> get(String url ) async{
    var response = await http.get(Uri.parse(baseUrl+url));
    logger.i(response.statusCode);
    logger.i(response.body);
    return response;
  }

  Future <dynamic> post(String url , Map<String,dynamic>body) async{
      var response = await http.post(Uri.parse(baseUrl+url),
        headers: {"Content.type":"application/json"},
        body:body,);
        logger.i(response.statusCode);
        logger.i(response.body);
        return response;
  }


Future  patchImage(String url , String filepath,) async{
    String? token = await storage.read(key:"token");
    var request = await http.MultipartRequest("Patch",Uri.parse(baseUrl+url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content.type":"multipart/form.data",
      "token":"$token"
       });
       print(token);
      var response = request.send();
      logger.i(response);

      return response;
}


Future  postImage(String url , String filepath,) async{
    String? token = await storage.read(key:"token");
    var request = await http.MultipartRequest("POST",Uri.parse(baseUrl+url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content.type":"multipart/form.data",
      "token":"$token"
       });
      http.StreamedResponse response = await request.send();
      var httpResponse = await http.Response.fromStream(response);
      logger.i(json.decode(httpResponse.body)['path']);
      return httpResponse;
}



Future uploadmultipleimage(String url ,List images) async {
      String? token = await storage.read(key:"token");
  http.MultipartRequest request =  http.MultipartRequest('POST',Uri.parse(baseUrl+url) );

       request.headers.addAll({
      "Content.type":"multipart/form.data",
      "token":"$token"
       });
      List<MultipartFile> newList = <MultipartFile>[];
      for (int i = 0; i < images.length; i++) {
      var imageFile = await http.MultipartFile.fromPath("img", images[i].path);
        newList.add(imageFile);
    }
  request.files.addAll(newList);
  var response = await request.send();
  return response;
}


}



