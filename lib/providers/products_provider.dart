import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart'as http;

class ProductsProvider extends ChangeNotifier{
  final baseUrl = 'flutter-varios-2d50d-default-rtdb.firebaseio.com';
  final List<Product> listProducts = [];
  bool isLoading = true;
  //para mandar los parametros con una variable global
  late Product selectedProduct;


  ProductsProvider(){
    loadProduct();
  }

  //TODO <List<Product>>
  Future <List<Product>> loadProduct() async{
    isLoading =true;
    notifyListeners();

    final url = Uri.https(baseUrl,'products.json');
    final resp  = await http.get(url);

    //convertir la repsuesta en un map
    final Map<String,dynamic> productsMap = json.decode(resp.body) ;

    //transforma el mapa un ;istado de productos por esoe l future retorna <List<Product>>

    productsMap.forEach((key, value) {
      //se usa form map por q retoranmos un map
      final tempProd = Product.fromMap(value);
      //por q se a;ade en este punto id,
      //por q la respuesta de back mete dentro del id lso valores
      /**
       * id{
       *  name,
       * price,
       * valor
       * }
       * 
       */
      tempProd.id = key;
      listProducts.add(tempProd);
      
    });
    isLoading =false;
    notifyListeners();

    return listProducts;
    //print(listProducts[0].name);


  }

  

}