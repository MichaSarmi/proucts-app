import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
 

  final Widget childWidget;

   const CardContainer({
    Key? key,
    
    required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        width: double.infinity,
        decoration: _createCardShape(),
        padding: const EdgeInsets.all(24),
        child: childWidget,
      ),
    );
  }

  BoxDecoration _createCardShape() {
    return  BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15,
          offset: Offset(0,0)
        )
      ]
      
      
    );
  }
}