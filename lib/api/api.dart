import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
const url = "http://192.168.1.3:3000/";
final SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
class API{
   Future<bool> register(String email, String password,String name) async{
    var regBody={
      "name":name,
      "email":email,
      "password" :password,
    };
    var response = await http.post(Uri.parse("${url}registration"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody)
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['status'];
  }
   Future<bool> login(String email, String password) async{
     var regBody={
       "email":email,
       "password" :password,
     };
     var response = await http.post(Uri.parse("${url}login"),
         headers: {"Content-Type":"application/json"},
         body: jsonEncode(regBody)
     );
     var jsonResponse = jsonDecode(response.body);
     var myToken = jsonResponse['token'];
     prefs.setString('token', myToken);
     return jsonResponse['status'];
   }

}
