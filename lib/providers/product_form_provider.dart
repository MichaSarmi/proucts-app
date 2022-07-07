import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier{

  //otra forma de implementar provider el login esta mas de otra

  GlobalKey<FormState> formKey =  GlobalKey<FormState>();

  Product product;
  //reciobimos la copia del product para no modificar
  ProductFormProvider(this.product);

  //va;idar fomrulario 
  bool isValidForm(){
    return formKey.currentState?.validate()?? false;
  } 

  updateAvailability(bool value){
    product.available= value;
    notifyListeners();

  }


}