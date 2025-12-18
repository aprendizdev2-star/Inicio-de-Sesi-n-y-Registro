import 'package:flutter/material.dart';

// --- CONSTANTES DE COLOR ---
// Color de fondo para las áreas principales
var defaultBackgroundColor = const Color.fromARGB(255, 255, 255, 255); 

// Color de la barra superior (AppBar) - Un azul oscuro profesional
var appBarColor = const Color.fromARGB(255, 231, 10, 10); 

var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: const Text(
    "Entrada y Salida de vehículos",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  centerTitle: true,
  iconTheme: const IconThemeData(color: Colors.white), // Hace que el icono del menú sea blanco
);

var drawerTextColor = const TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.w600,
);

var tilePadding = const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0);

// --- EL DRAWER (MENÚ LATERAL) ---
var myDrawer = Drawer(
  backgroundColor: Colors.white, // Fondo blanco para que resalte
  elevation: 0,
  child: Column(
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 245, 245), // Fondo sutil para el encabezado
        ),
        child: Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueAccent,
            // Reemplaza el Icon por esta línea cuando tengas tu imagen:
            // backgroundImage: AssetImage('assets/tu_foto.png'), 
            child: Icon(
              Icons.person, // Icono de usuario por defecto
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
      
      // Items del menú
      createDrawerItem(Icons.home, 'M E N U'),
      createDrawerItem(Icons.settings, 'CO N F I G U R A C I O N'),
      createDrawerItem(Icons.info, 'N O T I C I A S'),
      const Spacer(), // Empuja el Logout hacia abajo
      createDrawerItem(Icons.logout, 'S A L I R'),
      const SizedBox(height: 20),
    ],
  ),
);

// Función para no repetir código en cada item del menú
Widget createDrawerItem(IconData icon, String text) {
  return Padding(
    padding: tilePadding,
    child: ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(text, style: drawerTextColor),
      onTap: () {
        // Aquí puedes agregar la navegación después
      },
    ),
  );
}