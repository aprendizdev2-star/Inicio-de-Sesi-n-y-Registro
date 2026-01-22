import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Importaciones de tu estructura responsive
import 'responsive/desktop_body.dart';
import 'responsive/tablet_body.dart';
import 'responsive/mobil_body.dart';
import 'responsive/responsive_layout.dart';

class RegisterPage extends StatefulWidget {
  final String initialEmail;
  const RegisterPage({Key? key, required this.initialEmail}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  late TextEditingController emailController;
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController plateController = TextEditingController();

  String? selectedRol;
  final List<String> roles = ['usuario', 'facturacion', 'administrador'];
  
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const Text('Creación de cuenta', 
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red)),
                const SizedBox(height: 40),

                _buildInputField("Nombre", "Nombre completo", nameController, 
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))]),
                
                _buildInputField("Correo", "email@equitel.com.co", emailController, null, readOnly: false), 
                
                _buildInputField("Cédula", "Número de identificación", idController, 
                  [FilteringTextInputFormatter.digitsOnly]),
                _buildInputField("Teléfono", "Número de contacto", phoneController, 
                  [FilteringTextInputFormatter.digitsOnly]),
                _buildInputField("Empresa", "Nombre de la empresa", companyController, 
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))]),
                _buildInputField("Placa del Vehículo", "ABC-123", plateController, null),

                const Align(alignment: Alignment.centerLeft, 
                  child: Text("Rol", style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectedRol,
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  hint: const Text("Selecciona tu cargo"),
                  items: roles.map((rol) => DropdownMenuItem(value: rol, child: Text(rol))).toList(),
                  onChanged: (value) => setState(() => selectedRol = value),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty || selectedRol == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Por favor completa el nombre y el rol"))
                        );
                      } else {
                        // NAVEGACIÓN LIMPIA: Elimina el botón de retroceso (flecha blanca)
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResponsiveLayout(
                              mobileBody: MobileScaffold(), 
                              tabletBody: TabletScaffold(), 
                              desktopBody: DesktopScaffold(),
                            ),
                          ),
                          (route) => false, // Elimina todas las rutas previas
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    child: const Text('Crear Cuenta', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, 
      List<TextInputFormatter>? formatters, {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            readOnly: readOnly,
            inputFormatters: formatters,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}