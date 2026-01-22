import 'package:flutter/material.dart';
// Importamos las vistas del dashboard para cuando necesites navegar
import 'responsive/desktop_body.dart';
import 'responsive/tablet_body.dart';
import 'responsive/mobil_body.dart';
import 'responsive/responsive_layout.dart';
// Importamos tu nueva página de login
import 'login_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Vehículos',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // Esto asegura que los botones y textos usen fuentes limpias
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // CAMBIO CLAVE: Aquí debe decir LoginPage() para que sea lo primero en verse
      home: LoginPage(), 
    );
  }
}
