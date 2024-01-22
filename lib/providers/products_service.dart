import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart'as http;

class ProductsService extends ChangeNotifier{
  final baseUrl = 'flutter-varios-2d50d-default-rtdb.firebaseio.com';
  final List<Product> listProducts = [];
  bool isLoading = true;
  bool isSaving = false;
  dynamic idTemp = null;
  //iamgen temporal para remplezar el previ
  File? newPicturefile;

  //para mandar los parametros con una variable global
  late Product selectedProduct;
  //para lleer el token
    final storage = const FlutterSecureStorage();


  ProductsService(){
    loadProduct();
  }

  Future <List<Product>> loadProduct() async{
    isLoading =true;
    notifyListeners();
    //firebase pide el topken el el url

    //otros backens puden en el headEr OJO

    final url = Uri.https(baseUrl,'products.json',{
      'auth': await storage.read(key: 'token') ?? ''
    });
    final resp  = await http.get(url);

    //convertir la repsuesta en un map
    final Map<String,dynamic> productsMap = json.decode(resp.body) ;
    resp;
    //transforma el mapa un ;istado de productos por esoe l future retorna <List<Product>>
/*
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
      
    });*/
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
      
    if(product.id==null){
      
      await createProduct(product);

    }else{
      await updateProduct(product);

    }



    isSaving=false;
    notifyListeners();

    return product;


  }
  //metodo para pedir al backend
  Future<String?> updateProduct(Product product) async{
    
    final url = Uri.https(baseUrl,'products/${product.id}.json',{
      'auth': await storage.read(key: 'token') ?? ''
    });
    //debo mandar un json al backend con el metodo credo de la clase producto
    final resp  = await http.put(url, body: product.toJson());
    final decodeData =  resp.body;
   if(resp.statusCode != 200 && resp.statusCode !=201 ){
        print('algo salio mal');
        return null;

    }
    return product.id;
    //

  }

  //metodo para acualizar producto en la lsita

  updateListProduct(Product product){
    
    final index = listProducts.indexWhere((element) => element.id == product.id);
    if(index!=-1){
      listProducts[index] = product;
    }else{
      product.id = idTemp;
      listProducts.add(product)  ;
      idTemp = null;
    }

  }

  //cear producto

  Future<String?> createProduct(Product product) async{
    //print('create');
    final url = Uri.https(baseUrl,'products.json',{
      'auth': await storage.read(key: 'token') ?? ''
    });
    //debo mandar un json al backend con el metodo credo de la clase producto
    final resp  = await http.post(url, body: product.toJson());
    final decodeData =  json.decode(resp.body) ;
    //yo paso aqui un di temporal por que se recarga la data dependiendo si el back dio una respuesta posi o mnega
    idTemp = decodeData['name'];
    //print(decodeData);
    if(resp.statusCode != 200 && resp.statusCode !=201 ){
        print('algo salio mal');
        return null;

      }
    // todo acutlaizar el lsitado de  producto con repsuesta positiva
    return product.id;
    //

  }

//trnasformar en un fle el path de la camara 
  void updateSelectedProductImage(String path){
    //actualiza el plath
    selectedProduct.picture = path;
    //gererarl el archivo
    newPicturefile =  File.fromUri(Uri(path: path));
   
    notifyListeners();
  }

  Future<String?> uploadImage() async{
    if(newPicturefile == null){
      return null;

    }else{
      isSaving = true;
      notifyListeners();
      //otro metodo de llamar https
      //otro metodo llamado parse
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dgvqhcabc/image/upload?upload_preset=flutter-post-image');
      final imageUploadRequest = http.MultipartRequest(
        'POST',
        url
      );
      final file = await http.MultipartFile.fromPath('file', newPicturefile!.path);
      imageUploadRequest.files.add(file);
      //la repsuesta del back
      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);
      
      if(resp.statusCode != 200 && resp.statusCode !=201 ){
        print('algo salio mal');
        print(resp.body);
        return null;

      }


      newPicturefile = null; //limpio la propiedad newPicture file

      final decodeData = json.decode(resp.body);
      return decodeData['secure_url'];
      

    }

  }


  

}