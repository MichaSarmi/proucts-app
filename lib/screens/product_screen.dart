
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    return  Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
        
                  ProductImage(image: productProvider.selectedProduct.picture,),
                  Positioned(
                    top: 16,
                    left: 16,
                    child:IconButton(onPressed: (){
                      Navigator.of(context).pop();
        
                    }, icon:  const Icon(Icons.arrow_back_ios_new_rounded, size: 40, color: Colors.white,))
                  ),
                  Positioned(
                    top: 16,
                    right: 32,
                    child:IconButton(onPressed: (){
                      //Todo camara o galeria
        
                    }, icon:  const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,))
                  )
        
                ],
              ),
              const _ProductForm(),
              //scroll para el input
              const SizedBox(height: 100,)
        
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          elevation: 0,
          child: const Icon(Icons.save_outlined),
          onPressed: (){
            //todo guardar
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: _formBoxDecoration(),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0 , bottom: 32, left: 16, right: 16),
            child: Column(
              children: [
                 TextField(
                  decoration: InputDecorations.dauthInputDecoration(
                    hintText: 'Product name',
                    labelText: 'Name:'
                  ),
                  
                 ),
                 const SizedBox(height: 32,),

                 TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.dauthInputDecoration(
                    hintText: '\$150',
                    labelText: 'Precio'
                  ),
                 ),
                const SizedBox(height: 32,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Disponible',style: TextStyle(fontSize: 16),),
                    CupertinoSwitch(
                      value: true,
                      onChanged: (value){
                        
                      },
                      activeColor: Colors.indigo,
                    ),
                    
                  ],
                )
              ],
            ),
          )
        ),
        
      ),
    );
  }

  BoxDecoration _formBoxDecoration() =>  BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(32), bottomLeft: Radius.circular(32)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),blurRadius: 5,offset: const Offset(0,5),
      )
    ]
    );
}

