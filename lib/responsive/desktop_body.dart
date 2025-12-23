import 'package:flutter/material.dart';
import '../constants.dart';
import '../util/my_tile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  
  // 1. FUNCIÓN DE BOTONES (Debe estar AQUÍ, dentro de la clase pero fuera del build)
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
        child: Text(
          texto,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Menú lateral fijo
          myDrawer,

          // Cuerpo principal
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text("Menú de Operaciones", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  // Rejilla de botones ovalados
                  SizedBox(
                    height: 220, 
                    child: GridView.count(
                      crossAxisCount: 4, 
                      childAspectRatio: 2.8,
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
                  ),

                  const Divider(),

                  // Lista de información inferior
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => const MyTile(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Panel derecho de accesos directos
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text("Accesos Rápidos", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  
                  // Botón grande de Ingreso
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: const Center(
                        child: Text("INGRESO", 
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  // Botón grande de Salida
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.red, width: 2),
                      ),
                      child: const Center(
                        child: Text("SALIDA", 
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}