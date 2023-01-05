import 'package:get/get.dart';

class AuthProvider extends GetConnect{
  // final _baseUrl = "http://wood-chips.herokuapp.com/api/";
  final _baseUrl = "https://softvi.xyz/wcapp/api/";

  Future<Response> doPost(String url, Map data) => post(_baseUrl+url, data, headers: _headers());

  _headers(){
    return {
      'Content-type' : 'application/json',
      'Accept' : 'application/json',
    };
  }
}