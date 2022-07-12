import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? image;
  const ProductImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 0, top: 8, right: 16.0 ),
      child: Container(
        decoration: _decorationProductImg(),
        width: double.infinity,
        height: 450,
        child:  Stack(
          children:[ 
            ClipRRect(
            borderRadius:  const BorderRadius.only(topLeft: Radius.circular(32), topRight:Radius.circular(32) ),
            child:  getImage(context, image)
            //condicuibal si la iamgen es null
            
            
            
          ),
           ClipRRect(
              borderRadius:  const BorderRadius.only(topLeft: Radius.circular(32), topRight:Radius.circular(32) ),
             child: Container(
                      width: double.infinity,
                      height: 80,
                    decoration:   BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      )
                    )),
           ),
          
          
          ],
        ),
        
      ),
    );
  }

  BoxDecoration _decorationProductImg() =>  BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight:Radius.circular(32) ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.005),blurRadius: 10,offset: const Offset(0,5),
      )
    ]
  );
  
  //metodo
   Widget getImage( BuildContext contex,String? picture ) {

    if ( picture == null ) {
      return const Image(
          width: double.infinity,
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,
        );
    }
    // TODO aqui puede dar un error al pregunta elsif y ver q picture es null OJO
    if ( picture.startsWith('http') ) {
      return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: FadeInImage(
            width: double.infinity,

            image: NetworkImage( picture ),
            fit: BoxFit.cover,
            placeholder:const  AssetImage('assets/jar-loading.gif'),
            placeholderFit: BoxFit.fitHeight,
            alignment: Alignment.center,
          ),
      );
    }


    return Image.file(
      File( picture ),
      fit: BoxFit.cover,
    );
  }
}