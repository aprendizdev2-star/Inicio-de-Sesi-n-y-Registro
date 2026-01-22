import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HorariosPage(),
  ));
}

class HorarioData {
  String hora;
  String empresa;
  bool disponible;
  DateTime objetoFecha;

  HorarioData({
    required this.hora,
    required this.objetoFecha,
    this.empresa = '',
    this.disponible = true,
  });

  // Convierte el objeto a Map para guardarlo como JSON
  Map<String, dynamic> toJson() => {
    'hora': hora,
    'empresa': empresa,
    'disponible': disponible,
    'objetoFecha': objetoFecha.toIso8601String(),
  };

  // Crea el objeto desde un Map de JSON
  factory HorarioData.fromJson(Map<String, dynamic> json) => HorarioData(
    hora: json['hora'],
    empresa: json['empresa'],
    disponible: json['disponible'],
    objetoFecha: DateTime.parse(json['objetoFecha']),
  );
}

class HorariosPage extends StatefulWidget {
  const HorariosPage({super.key});

  @override
  State<HorariosPage> createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage> {
  final Color colorRojo = const Color(0xFFDA0808);
  final Color colorDisponible = const Color(0xFFE0F7FA);
  final Color colorOcupado = const Color(0xFFFFEBEE);
  final Color colorFondoBoton = const Color(0xFF332D2D);

  List<HorarioData> listaHorarios = [];
  int? hoveredIndex; 
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _inicializarDatos();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _limpiarHorariosAntiguos();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // --- LÓGICA DE PERSISTENCIA ---
  
  Future<void> _inicializarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString('horarios_cache');

    if (cachedData != null) {
      // Si hay datos guardados, los cargamos
      final List<dynamic> decodedData = json.decode(cachedData);
      setState(() {
        listaHorarios = decodedData.map((item) => HorarioData.fromJson(item)).toList();
      });
      _limpiarHorariosAntiguos();
    } else {
      // Si es la primera vez, generamos la lista base
      _generarHorarios();
    }
  }

  Future<void> _guardarEnLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(listaHorarios.map((item) => item.toJson()).toList());
    await prefs.setString('horarios_cache', encodedData);
  }

  // ------------------------------

  void _generarHorarios() {
    listaHorarios = [];
    DateTime ahora = DateTime.now();
    for (int h = 7; h <= 17; h++) {
      for (int m = 0; m < 60; m += 15) {
        if (h == 17 && m > 0) break;
        int displayHour = h > 12 ? h - 12 : h;
        if (displayHour == 0) displayHour = 12;
        String amPm = h >= 12 ? "pm" : "am";
        String minutos = m == 0 ? "00" : m.toString();
        DateTime fechaHorario = DateTime(ahora.year, ahora.month, ahora.day, h, m);
        listaHorarios.add(HorarioData(hora: "$displayHour:$minutos $amPm", objetoFecha: fechaHorario));
      }
    }
    _limpiarHorariosAntiguos();
    _guardarEnLocal();
  }

  void _limpiarHorariosAntiguos() {
    setState(() {
      DateTime limite = DateTime.now().subtract(const Duration(minutes: 15));
      listaHorarios.removeWhere((item) => item.objetoFecha.isBefore(limite));
    });
    _guardarEnLocal();
  }

  String _getFechaActual() {
    DateTime now = DateTime.now();
    List<String> meses = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${meses[now.month - 1]} ${now.day}, ${now.year}";
  }

  void _mostrarMenuHorario(int index) {
    final horario = listaHorarios[index];
    TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(25),
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(horario.disponible ? 'Confirmar Horario' : 'Gestionar Reserva',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              if (horario.disponible) ...[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Nombre de Empresa o Placa...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ] else ...[
                Text('¿Eliminar reservación de ${horario.empresa}?', textAlign: TextAlign.center),
              ],
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (horario.disponible && _controller.text.isNotEmpty) {
                      listaHorarios[index].empresa = _controller.text;
                      listaHorarios[index].disponible = false;
                    } else if (!horario.disponible) {
                      listaHorarios[index].empresa = '';
                      listaHorarios[index].disponible = true;
                    }
                  });
                  _guardarEnLocal(); // Persiste el cambio inmediatamente
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: colorRojo, shape: const StadiumBorder()),
                child: Text(horario.disponible ? 'Enviar' : 'Eliminar', style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Gestión de Horarios', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: colorRojo,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Seleccione el horario de su llegada', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorFondoBoton)),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFFF7070), borderRadius: BorderRadius.circular(5)),
              child: Text(_getFechaActual(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            _buildLegend(colorDisponible, 'Disponible'),
            const SizedBox(height: 8),
            _buildLegend(colorOcupado, 'No Disponible'),
            const SizedBox(height: 30),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                mainAxisExtent: 100,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: listaHorarios.length,
              itemBuilder: (context, index) {
                var item = listaHorarios[index];
                bool isHovered = hoveredIndex == index;

                return MouseRegion(
                  onEnter: (_) => setState(() => hoveredIndex = index),
                  onExit: (_) => setState(() => hoveredIndex = null),
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _mostrarMenuHorario(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      transform: isHovered 
                          ? (Matrix4.identity()..translate(-4, -8, 0)..scale(1.05))
                          : Matrix4.identity(),
                      decoration: BoxDecoration(
                        color: item.disponible ? colorDisponible : colorOcupado,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1.2),
                        boxShadow: [
                          if (isHovered)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item.hora, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                          if (item.empresa.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(item.empresa, 
                                style: const TextStyle(fontSize: 12, color: Colors.black54),
                                overflow: TextOverflow.ellipsis),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20, height: 20, 
          decoration: BoxDecoration(
            color: color, 
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black, width: 0.5)
          )
        ),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}