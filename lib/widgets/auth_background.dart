import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
   //recibir un wodget que se dibujar en la mitad
  final Widget widgetchild;
  const AuthBackground({
    super.key,
    required this.widgetchild
    });
 
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),

          SafeArea(
            child: Container(
              width: double.infinity,
              margin:  EdgeInsets.only(top: size.height * 0.02),
              child: const Icon(Icons.person_pin, color: Colors.white, size: 100,),
            ),
          ),

          widgetchild




        ],
      ),

    );
  }
}

class _PurpleBox extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height*0.4,
      decoration: _purpleGradient(),
      child: Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            child:  _Buggle(),
          ),
           Positioned(
            top: -40,
            left: -30,
            child:  _Buggle(),
          ),
           Positioned(
            top: -50,
            right: -20,
            child:  _Buggle(),
          ),
           Positioned(
            bottom: -50,
            left: 10,
            child:  _Buggle(),
          ),
           Positioned(
            bottom: 60,
            right: 20,
            child:  _Buggle(),
          )

        ],
      ),
    );
  }

  BoxDecoration _purpleGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(91, 70, 178, 1),
      ])
      
    );
  }
  
}
class _Buggle extends StatelessWidget {
    
  
    @override
    Widget build(BuildContext context) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)
        ),

      );
    }
  }