import 'package:flutter/material.dart';
//no redibuja nada por eso no va el chnge ntoify
class NotificationProivder{
  //mantener la referencia al material app

  static GlobalKey<ScaffoldMessengerState> messegerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message){

    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 20),),
    );

    messegerKey.currentState!.showSnackBar(snackBar);

  }

}