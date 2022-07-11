import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,),
      child: Container(
        margin: const EdgeInsets.only(top: 16, bottom: 24),
        width: double.infinity,
        height: 400,
        decoration: _cardDecoration(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children:  [
            _BackgroundImage(imageUrl:product.picture==null? AssetImage('assets/no-image.png'):NetworkImage(product.picture!) ,),
            _productDetails(name: product.name,id: product.id ?? '',),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(price: product.price),
              ),
            if(!product.available)
            const Positioned(
              top: 0,
              left: 0,
              child: _notAvaible(),
              )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 8)
          )
          
        ]
      );
  }
}

class _notAvaible extends StatelessWidget {
  const _notAvaible({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      width: 100,
      height: 80,
      decoration:  BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(topLeft:  Radius.circular(16), bottomRight:  Radius.circular(16))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
         child:  Text(
            'No disponible',
            maxLines: 1,
            style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),

    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;
  const _PriceTag({
    Key? key, required this.price,
  }) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight:  Radius.circular(16), bottomLeft:  Radius.circular(16))
      ),
      //fittedBox respeta el espacio si no alnvaza el contenido en el padre
      child:   FittedBox(
        fit: BoxFit.contain,
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:  Text(
            '\$$price',
            maxLines: 1,
            style: const TextStyle(color: Colors.white, fontSize: 20),)
          ),
      ),
      
    );
  }
}

class _productDetails extends StatelessWidget {
  final String name;
  final String id;
  const _productDetails({
    Key? key, required this.name, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(right: 70),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: 80,
        
        decoration: _producnterBoxDeoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              name,
              style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis
            ,),
             Text(
              id ,
              style:  const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
              maxLines: 1,
              overflow: TextOverflow.ellipsis
            ,)
          ],
        ),
    
      ),
    );
  }

  BoxDecoration _producnterBoxDeoration() {
    return  const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topRight: Radius.circular(16))
      );
  }
}

class _BackgroundImage extends StatelessWidget {
  final dynamic? imageUrl;
  const _BackgroundImage({
    Key? key, this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ClipRRect por q la imagen no tiene borde reodiado
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child:  FadeInImage(
          placeholder:  const  AssetImage('assets/jar-loading.gif'),
          image: imageUrl!,
          fit: BoxFit.cover,
        ),
    
      ),
    );
  }
}