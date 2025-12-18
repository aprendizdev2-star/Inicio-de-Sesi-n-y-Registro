import 'package:flutter/material.dart';
import '../constants.dart';
import '../util/my_box.dart';
import '../util/my_tile.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      drawer: myDrawer,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 1. Los primeros 4 boxes en grid (Fotos de Productos)
            AspectRatio(
              aspectRatio: 1, // Proporción 1:1 para la cuadrícula superior
              child: SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  itemCount: 4, // 🎯 Reto: Incluir 4 fotos de productos
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columnas
                  ),
                  itemBuilder: (context, index) {
                    return const MyBox();
                  },
                ),
              ),
            ),

            // 2. Lista de información de productos (en los espacios debajo)
            Expanded(
              child: ListView.builder(
                itemCount: 7, // Número de elementos de lista
                itemBuilder: (context, index) {
                  return const MyTile(); // Usando MyTile para la información
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}