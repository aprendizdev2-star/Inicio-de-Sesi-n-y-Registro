import 'package:flutter/material.dart';
import '../constants.dart';
import '../util/my_tile.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  Widget botonColorido(String texto, Color colorBorde) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorBorde, width: 2),
          shape: const StadiumBorder(),
          backgroundColor: Colors.white,
        ),
        child: Text(texto, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text("Menú de Operaciones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3, 
              childAspectRatio: 3.5,
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5, 
              itemBuilder: (context, index) => const MyTile()
            ),
          ],
        ),
      ),
    );
  }
}