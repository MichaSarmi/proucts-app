
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    //para tener acceso dentro de los elementos tanto del formulario camara
    //necesitamos poner un change y pasarle la referecia del provder
    return ChangeNotifierProvider(create: ((_) => ProductFormProvider(productProvider.selectedProduct) ), 
    child:_ProductsScreenBody(productProvider: productProvider),);
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    Key? key,
    required this.productProvider,
  }) : super(key: key);

  final ProductsProvider productProvider;

  @override
  Widget build(BuildContext context) {
     final productFormProvider = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        // al ahcer scroll se ocukta
        //physics: const BouncingScrollPhysics(),
        //keyboardDismissBehavior:  ScrollViewKeyboardDismissBehavior .onDrag,
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(image: productProvider.selectedProduct.picture,),
                  Positioned(
                    top: 16,
                    left: 16,
                    child:IconButton(
                      
                      onPressed: (){
                      Navigator.of(context).pop();
        
                    }, icon:   Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 40, 
                      color:Colors.white,
                      shadows: [
                          ShadowIcons()
                          ],
                        )
                      )
                  ),
                  Positioned(
                    top: 16,
                    right: 32,
                    child:IconButton(onPressed: (){
                      //Todo camara o galeria
        
                    }, icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                      shadows: [
                          ShadowIcons()
                          ],
                      ))
                  ),
                  
        
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
          onPressed: () async {
            //todo guardar
              //print(productFormProvider.product.id);
             if(!productFormProvider.isValidForm()) {
              return;

             }else{
              //paticion con majeos de eerores
              await productProvider.saveOrCreateProduct(productFormProvider.product).then(( product) {

                productProvider.updateListProduct(product);
                Navigator.of(context).pop();


              }).catchError((err){
                print(err);
                //rnviar mensajes de errpr
              });
             }
            
            

          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  BoxShadow ShadowIcons() {
    return BoxShadow(
                        blurRadius: 8,
                        blurStyle: BlurStyle.solid,
                        offset: const Offset(2,2),
                        color: Colors.black.withOpacity(0.5), );
  }
}

class _ProductForm extends StatelessWidget {
  
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final productFormProvider = Provider.of<ProductFormProvider>(context);
     final product = productFormProvider.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: _formBoxDecoration(),
        child: Form(
          //pasamos el ley apra el metodo de validar formulario
          key: productFormProvider.formKey,
          //pasarle la validacion
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0 , bottom: 32, left: 16, right: 16),
            child: Column(
              children: [
                 TextFormField(
                  initialValue: product.name,
                  onChanged: ((value) => product.name = value),
                  validator: ((value)  {
                    if(value == null || value.isEmpty ) {
                      return 'el nombre es olbigatorio';
                    }
                  }),
                  decoration: InputDecorations.dauthInputDecoration(
                    hintText: 'Product name',
                    labelText: 'Name:'
                  ),
                  
                 ),
                 const SizedBox(height: 32,),

                 TextFormField(
                  initialValue: '${product.price}',
                  //para solo pdoer escribir un numero con un solo decimal
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: ((value) {
                    if(double.tryParse(value)==null){
                      product.price = 0;
                    }else{
                      product.price =  double.parse(value);
                    }
                  }),
             
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
                      value: product.available,
                      onChanged: (value){
                        productFormProvider.updateAvailability(value);
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

