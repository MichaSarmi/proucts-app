
import 'package:flutter/material.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    //no se redibuja listen: false)
    final authService = Provider.of<AuthService>(context,listen: false);
    return  Scaffold(
      body: Center(
         child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if(!snapshot.hasData){
                return const Text('');
            } else{
            //ojo el widget debe termiar de contruirse para ahcer una rediccion a otra pantalla
            //para ello se usa microtask
            if(snapshot.data == ''){
              Future.microtask( (){

              //QUITAR EL SALTO DE NAVEGACION
              // una navegacion Manual
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_,__,___) => const LoginScreen(),
                transitionDuration: const Duration(seconds: 0)
                ) 
              );
   
            });

            }else{
              Future.microtask( (){

              //QUITAR EL SALTO DE NAVEGACION
              // una navegacion Manual
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_,__,___) => const HomeScreen(),
                transitionDuration: const Duration(seconds: 0)
                ) 
              );
               
              
               
            });
            }
            
            return Container();

            }
          }
        )
      ),
    );
  }
}