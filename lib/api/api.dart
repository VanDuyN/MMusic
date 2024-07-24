import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
const url = "http://192.168.1.9:3000/";

class API{
  String getUrl(){
    return url;
  }
   Future<bool> register(String email, String password,String name) async{
    var regBody={
      "name":name,
      "email":email,
      "password" :password,
    };
    var response = await http.post(Uri.parse("${url}register"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody)
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['status'];
   }
   Future<String> login(String email, String password) async{
     var regBody={
       "email":email,
       "password" :password,
     };
     var response = await http.post(Uri.parse("${url}login"),
         headers: {"Content-Type":"application/json"},
         body: jsonEncode(regBody)
     );
     return response.body;
   }
   Future<String> getUser(String email) async{
     var regBody={
       "email":email,
     };
     var response = await http.post(Uri.parse("${url}getDataUser"),
         headers: {"Content-Type":"application/json"},
         body: jsonEncode(regBody)
     );
     return response.body;
   }
   Future<String> getAllArist() async{
    var response = await http.get(Uri.parse("${url}getAllArist"),
        headers: {"Content-Type":"application/json"},
    );
    return response.body;
  }
  Future<String> getAllSong() async{
    var response = await http.get(Uri.parse("${url}getAllSong"),
      headers: {"Content-Type":"application/json"},
    );
    return response.body;
  }
  Future<String> getArtistById(String id) async{
    var regBody={
      "id":id,
    };
    var response = await http.post(Uri.parse("${url}getArtistById"),
      headers: {"Content-Type":"application/json"},
      body:jsonEncode(regBody)
    );
    return response.body;
  }
  Future<String> getSongByIdArtist(String id) async{
    var regBody={
      "id":id,
    };
    var response = await http.post(Uri.parse("${url}getSongByIdArtist"),
        headers: {"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    return response.body;
  }
  Future<String> getSongByIdCategory(String id) async{
    var regBody={
      "id":id,
    };
    var response = await http.post(Uri.parse("${url}getSongByIdCategory"),
        headers: {"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    return response.body;
  }
  Future<String> getAllCategories() async{
    var response = await http.get(Uri.parse("${url}getAllCategory"),
      headers: {"Content-Type":"application/json"},
    );
    return response.body;
  }
  Future<String> getAllAlbum() async{
    var response = await http.get(Uri.parse("${url}getAllAlbum"),
      headers: {"Content-Type":"application/json"},
    );
    return response.body;
  }
  Future<String> checkFavourite(String id,String email) async{
    var regBody={
      "id":id,
      "email": email
    };
    var response = await http.post(Uri.parse("${url}checkFavourite"),
      headers: {"Content-Type":"application/json"},
      body:jsonEncode(regBody)
    );
    return response.body;
  }
  Future<String> addFavourite(String id,String email) async{
    var regBody={
      "id":id,
      "email": email
    };
    var response = await http.post(Uri.parse("${url}addFavourite"),
        headers: {"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    return response.body;
  }
  Future<String> deleteFavourite(String id,String email) async{
    var regBody={
      "id":id,
      "email": email
    };
    var response = await http.post(Uri.parse("${url}deleteFavourite"),
        headers: {"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    return response.body;
  }
  Future<String> getSongByIds(List<String> id) async{
    var regBody={
      "ids":id,
    };
    var response = await http.post(Uri.parse("${url}getSongByIds"),
        headers: {"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    return response.body;
  }

}
