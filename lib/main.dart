import 'package:flutter/material.dart';
import 'responsive/desktop_body.dart';
import 'responsive/tablet_body.dart';
import 'responsive/mobil_body.dart';
import 'responsive/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const ResponsiveLayout(
        // Nota: Las variables del ResponsiveLayout se definen como 'final'
        // pero se pasan aquí los widgets correspondientes a cada cuerpo.
        mobileBody: MobileScaffold(), // Usando el nombre de la clase en mobil_body.dart
        tabletBody: TabletScaffold(), // Usando el nombre de la clase en tablet_body.dart
        desktopBody: DesktopScaffold(), // Usando el nombre de la clase en desktop_body.dart
      ),
    );
  }
}