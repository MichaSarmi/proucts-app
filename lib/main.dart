import 'package:flutter/material.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
 // const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ProductsService()),//si se [one el lazy en false, se diparara la pet en el login OJO]
        ChangeNotifierProvider(create: (_)=>AuthService())//provider loguin reggister
      ],
      child: MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos app',
      initialRoute: 'login/',
      routes: {
        'login/': ((context) => const LoginScreen()),
        'home/': ((context) => const HomeScreen()),
        'product/': ((context) => const ProductScreen()),
        'register/': ((context) => const RegisterScreen())
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo

        ),
        floatingActionButtonTheme:  FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo.shade900
        )
      ),
      
    );
  }
}