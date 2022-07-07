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
            child:  image == null
              ? const Image(
              image: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover,
            )
              : FadeInImage(
              image:  NetworkImage(image!),
              placeholder: const AssetImage('assets/jar-loading.gif'),
              fit: BoxFit.cover,
            ),
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
}