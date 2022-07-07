import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart'as http;

class ProductsProvider extends ChangeNotifier{
  final baseUrl = 'flutter-varios-2d50d-default-rtdb.firebaseio.com';
  final List<Product> listProducts = [];
  bool isLoading = true;
  bool isSaving = true;
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
  // <List<Product>>
  //acuarlaizar o crear
  Future saveOrCreateProduct(Product product) async{
    isSaving=true;
    notifyListeners();
      print(product.id);
    if(product.id==null){
      //hay q crear

    }else{
      await updateProduct(product);

    }



    isSaving=false;
    notifyListeners();

    return product;


  }
  //metodo para pedir al backend
  Future<String?> updateProduct(Product product) async{
    
    final url = Uri.https(baseUrl,'products${product.id}.json');
    //debo mandar un json al backend con el metodo credo de la clase producto
    final resp  = await http.put(url, body: product.toJson());
    final decodeData =  resp.body;
    print(decodeData);
    print(product.id);
    // todo acutlaizar el lsitado de  producto con repsuesta positiva
    return product.id;
    //

  }

  //metodo para acualizar producto en la lsita

  updateListProduct(Product product){

    final index = listProducts.indexWhere((element) => element.id == product.id);
    if(index!=-1){
      listProducts[index] = product;

    }else{
      listProducts.add(product)  ;
    }

  }


  

}