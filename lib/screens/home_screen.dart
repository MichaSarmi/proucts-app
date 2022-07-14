import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/providers/products_service.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    //COMO EL sericio-provider esta inicializado en el amin solo lo leo
    final productProvider =  Provider.of<ProductsService>(context);
    if (productProvider.isLoading) return const LoadingScreen();
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      //es perezoso
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: productProvider.listProducts.length,
        itemBuilder: ((context, index) => GestureDetector(
          child:  ProductCard(product: productProvider.listProducts[index]),
          onTap: (){
            //lalameos el metodo copy del producto seleccionado
            productProvider.selectedProduct = productProvider.listProducts[index].copyProduct();
            Navigator.pushNamed(context, 'product/');
          },
          )
        )
        
        ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: (){
          //necesitamos la isntancia de prodictp [asar;e a; [rpvider para q no de errores]]
          productProvider.selectedProduct =  Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product/');
        },
        child: const Icon(Icons.add),
        ),
      
    );
  }
}