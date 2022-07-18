
import 'package:flutter/material.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
  
   
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return   Scaffold(
      body: AuthBackground(
        widgetchild: SingleChildScrollView(
          child: Column(
            children:  [
                SizedBox(height: size.height*0.4 - 130 ,),
                CardContainer(
                  childWidget: Column(
                    children: [
                      const SizedBox(height: 8,),
                      Text('Register', style: Theme.of(context).textTheme.headline4,),
                      const SizedBox(height: 24,),
                      //Formulario
                      ChangeNotifierProvider(
                        create: (_)=> LoginFormProvider(),
                        child: const _LoginForm(),
                        ),
                    ],
                  )
                  
                  
                  ),
                  const SizedBox(height: 54,),
                  TextButton(
                    onPressed: ()=> Navigator.pushReplacementNamed(context, 'login/'),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(const StadiumBorder())
                    ),
                    child:  const Text('Ya tienes una cuenta?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.purple),),
                    
                  ),

                  const SizedBox(height: 54,),

              

            ],
          ),
         
        ),
        
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {

  const _LoginForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //proivder para apitar al ley
      final loginFormProvider =  Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginFormProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        //key no hace ver si psaron las validaciones
        child: Column(
          children: [
            TextFormField(
              enabled: !loginFormProvider.isLoading,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:  InputDecorations.dauthInputDecoration(
                hintText: 'mail@mail.com',
                labelText: 'Email',
                prefixIcon: Icons.alternate_email_rounded),
                validator: (value) {
                  value = value==null?'':value.trim();
                  
                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  =  RegExp(pattern);
                  return regExp.hasMatch(value)?
                  null
                  :'Format invalid';
                },
                onChanged: ((value) {
                  loginFormProvider.email = value;
                }),
              

            ),
            const SizedBox(height: 24,),
            TextFormField(
              enabled: !loginFormProvider.isLoading,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration:  InputDecorations.dauthInputDecoration(
                hintText: '***',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline),
                validator: (value) {
                  if(value!=null && value.length>=6){
                    return null;
                  }else{
                    return 'Password 6 characters';
                  }
                  
                },
                 onChanged: ((value) {
                  loginFormProvider.password = value;
                }),

            ),
            const SizedBox(height: 24,),
            //para que el boton se desacrtive hay q mandar null
            MaterialButton(
              onPressed: loginFormProvider.isLoading?null: () async{
              //quitar el teclado
               FocusScope.of(context).unfocus();
               //lsitener false por que nmo se debe escuchar en un metodo si no en el build
               final authService = Provider.of<AuthService>(context,listen: false);
              //si se valida el formulario desde el ley de form
              if(!loginFormProvider.isValidForm()){
                //loginFormProvider.isLoading = !loginFormProvider.isLoading;
                return ;
              }else{
                loginFormProvider.isLoading = true;

                await authService.createUser(loginFormProvider.email, loginFormProvider.password).then(
                  (data){

                    print(data);
                    if(data['error']['code']!=200){
                      print('es un error');
                      NotificationProivder.showSnackbar('Usuario no valido');
                      //todo mostrar error en pantalla
                    }else{
                      authService.createTokenStorage(data['idToken']);
                      
                      Navigator.pushReplacementNamed(context, 'home/');
                      
                    }

                  }
                  
                  ).catchError((err){
                   print('es un error catch');
                    NotificationProivder.showSnackbar('No podemos procesar el login intentalo mas tarde');
                    print(err);
                  });

                
                loginFormProvider.isLoading = false;
               

              }
          

              //Todo login for,
            },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              disabledColor: Colors.grey,
              color: Colors.purple,
              elevation: 0,
              child:  Container(
                constraints: const BoxConstraints( maxWidth: 200,minWidth: 200),
                //padding:  const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child:  
                loginFormProvider.isLoading==true
                ? const _LoadingLogin()
                : const Text(

                    'Register',
                    textAlign: TextAlign.center,
                    style:  TextStyle(color: Colors.white, fontSize: 18),
                  ) 
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

class _LoadingLogin extends StatelessWidget {
  const _LoadingLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 90),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle
      ),
      child:const CircularProgressIndicator(color: Colors.white,),
    );
  }
}