import 'package:flutter/material.dart';
import '../constants.dart';
import '../util/my_tile.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  // Función para los botones ovalados
  Widget botonColorido(String texto, Color colorBorde) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorBorde, width: 2),
          shape: const StadiumBorder(),
          backgroundColor: Colors.white,
        ),
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      drawer: myDrawer,
      body: SingleChildScrollView( // Permite hacer scroll si hay muchos botones
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text("Menú de Operaciones", style: TextStyle(fontWeight: FontWeight.bold)),
            
            // Rejilla que se ajusta al contenido
            GridView.count(
              shrinkWrap: true, // Importante: ajusta el tamaño al contenido
              physics: const NeverScrollableScrollPhysics(), // Evita conflicto de scroll
              crossAxisCount: 2, 
              childAspectRatio: 3.0,
              padding: const EdgeInsets.all(10),
              children: [
                botonColorido("Ingreso", Colors.red),
                botonColorido("Salida", Colors.green),
                botonColorido("Verificación", Colors.orange),
                botonColorido("Buscar", Colors.cyan),
                botonColorido("Comentarios", Colors.yellow[700]!),
                botonColorido("Parqueadero", Colors.purple),
                botonColorido("Facturación", Colors.brown),
                botonColorido("Cédula", Colors.blue),
                botonColorido("Horarios", Colors.pink),
                botonColorido("Contratiempos", Colors.lightGreen),
              ],
            ),
            
            const Divider(),
            
            // Lista de información
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => const MyTile(),
            ),
          ],
        ),
      ),
    );
  }
}