import 'package:flutter/material.dart';
import 'register_page.dart';
import 'responsive/desktop_body.dart';
import 'responsive/tablet_body.dart';
import 'responsive/mobil_body.dart';
import 'responsive/responsive_layout.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController emailInputController = TextEditingController();

  void mostrarError(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  // Función para ir directo al Dashboard
  void entrarAlDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileBody: MobileScaffold(),
          tabletBody: TabletScaffold(),
          desktopBody: DesktopScaffold(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Inicio de Sesión',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  shadows: [
                    Shadow(blurRadius: 10.0, color: Colors.red.withOpacity(0.3), offset: const Offset(0, 5)),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              const Text('Crea una cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Escribe tu email para registrarte en esta app', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              TextField(
                controller: emailInputController,
                decoration: InputDecoration(
                  hintText: 'email@equitel.com.co',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (!emailInputController.text.contains('@')) {
                      mostrarError(context, "El correo debe incluir @");
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(initialEmail: emailInputController.text),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Registrarse', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.red)),
                      child: const Text('o', style: TextStyle(color: Colors.red, fontSize: 12)),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 30),
              _buildSocialButton(context, "Ingresar como Administrador"),
              const SizedBox(height: 15),
              _buildSocialButton(context, "Ingresar con Usuario"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, String text) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () => entrarAlDashboard(context), // Navegación directa
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFF0F0F0),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
      ),
    );
  }
}