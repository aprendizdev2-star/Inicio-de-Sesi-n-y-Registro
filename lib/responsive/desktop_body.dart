import 'package:flutter/material.dart';
import '../constants.dart';
import '../util/my_box.dart';
import '../util/my_tile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Menú lateral (Drawer fijo en escritorio)
          myDrawer,

          // 2. Cuerpo principal
          Expanded(
            flex: 3, // Ocupa más espacio
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Primera mitad: Cuadrícula de 4 productos
                  AspectRatio(
                    aspectRatio: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: 4,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          return const MyBox();
                        },
                      ),
                    ),
                  ),

                  // Segunda mitad: Información y publicidad
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return const MyTile(); // Información de productos
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Compartimiento lateral (Imágenes Publicitarias)
          Expanded(
            flex: 1, // Ocupa menos espacio
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // 🎯 Reto: 2 imágenes publicitarias en los compartimientos laterales
                  // Espacio para la primera imagen publicitaria
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: const Center(child: Text("Ingreso")),
                    ),
                  ),
                  // Espacio para la segunda imagen publicitaria
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: const Center(child: Text("Salida")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}