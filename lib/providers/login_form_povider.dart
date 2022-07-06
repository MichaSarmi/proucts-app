import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{
  //por q estoy dentro de un form
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  
  String email = '';
  String password = '';
  //es privada por q no quiero ingersar y dibujar los widgets cuando cambio
  bool _isLoadding = false;
  bool get isLoading => _isLoadding;
  set isLoading(bool value){
    _isLoadding =  value;
    notifyListeners();
  }


  bool isValidForm(){
    return formKey.currentState?.validate() ?? false ;
  }



}
