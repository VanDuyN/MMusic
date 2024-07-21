import 'dart:convert';
import 'package:http/http.dart' as http;
const url = "http://192.168.10.137:3000/";

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

}
