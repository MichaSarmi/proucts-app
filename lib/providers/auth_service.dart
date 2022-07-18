import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class AuthService extends ChangeNotifier{

  final String _baseUrl='identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDqV_ouN5xF0Zu_BXRpA3Zr-Ck3l_30bxU';

  final storage = const FlutterSecureStorage();

  Future<dynamic>createUser(String email, String password) async{
    final Map<String, dynamic> authData = {
      'email': email,
      'password':password,
      'returnSecureToken':true
    };
    //cidado con el erro si usas http dara error de acceso
    final url = Uri.https(_baseUrl,'/v1/accounts:signUp/',{
      'key': _firebaseToken
    } );

    final respuesta = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(respuesta.body);
    print(decodeResp);

    if(decodeResp.containsKey('idToken')){
      //todo guardar el token en un lugar seguro
    } 

    return decodeResp;
  }


  Future<dynamic>loginUser(String email, String password) async{
    final Map<String, dynamic> authData = {
      'email': email,
      'password':password,
      'returnSecureToken':true
    };

    final url = Uri.https(_baseUrl,'/v1/accounts:signInWithPassword',{
      'key': _firebaseToken
    } );

    final respuesta = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(respuesta.body);


    /*if(decodeResp.containsKey('idToken')){
      //todo guardar el token en un lugar seguro
    } */

    return decodeResp;
  }


  void createTokenStorage(String jwt) async{
    
    await storage.write(key: 'token', value: jwt);
  }

  Future logOut() async{
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async{

    return await storage.read(key: 'token')??'';

  }

}