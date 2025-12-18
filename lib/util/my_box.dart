import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  const MyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Los 'MyBox' representan los 4 productos.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[400], // Color de fondo para los "productos"
        ),
        child: const Center(
          child: Text(
            'Opcion #', // Texto representativo
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}