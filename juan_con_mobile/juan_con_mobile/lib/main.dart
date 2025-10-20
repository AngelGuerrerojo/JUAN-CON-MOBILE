import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const JuanConApp());
}

class JuanConApp extends StatelessWidget {
  const JuanConApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JUAN-CON',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF9C27B0),
          secondary: Color(0xFFEC407A),
        ),
        useMaterial3: false,
      ),
      home: const MainMenuPage(),
    );
  }
}

/* ------------------ MAIN MENU ------------------ */
class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});
  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  bool modalShown = false;

  @override
  void initState() {
    super.initState();
    _checkModal();
  }

  Future<void> _checkModal() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool('juancon_modal_shown') ?? false;
    if (!shown) {
      // show after build
      WidgetsBinding.instance.addPostFrameCallback((_) => _showWelcomeModal());
      await prefs.setBool('juancon_modal_shown', true);
    }
  }

  void _showWelcomeModal() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)).resolve,
        title: const Text('¡Bienvenido a JUAN-CON!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('¡Hola! Te damos la bienvenida al menú principal de JUAN-CON.'),
            SizedBox(height: 8),
            Text('Última actualización: JUAN-CON 2.0 — estilos, traducciones, kits.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('¡Entendido!'),
          )
        ],
      ),
    );
  }

  Widget _card(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          height: 150,
          child: Row(
            children: [
              Container(
                width: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF9C27B0), Color(0xFFEC407A)]),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)
                  )
                ),
                child: Center(child: Icon(icon, size: 56, color: Colors.white)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFD1F0))),
                      const SizedBox(height: 8),
                      Text(subtitle, style: const TextStyle(color: Colors.white70))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú JUAN-CON'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, padding.bottom + 12),
        child: Column(
          children: [
            const Text('Elige para donde quieres ir', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 700 ? 3 : 1,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 3,
                children: [
                  _card('Personaje', 'Editar hoja de personaje, habilidades y equipo.', Icons.person, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PersonajePage()));
                  }),
                  _card('Kits de Expansión', 'Ver kits, posesiones y tablas.', Icons.extension, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const KitsPage()));
                  }),
                  _card('Categorías', 'Información sobre categorías del sistema.', Icons.category, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CategoriasPage()));
                  }),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text('© 2025 JUAN-CON', style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}

/* ------------------ PERSONAJE PAGE ------------------ */
class PersonajePage extends StatefulWidget {
  const PersonajePage({super.key});
  @override
  State<PersonajePage> createState() => _PersonajePageState();
}

class _PersonajePageState extends State<PersonajePage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _data = {
    'nombre': '', 'edad': '', 'faccion': '', 'descripcion': '',
    'atributos': {
      'fuerza': 0,'agilidad':0,'percepcion':0,'voluntad':0,'interfacing':0,'investigation':0,
      'surveillance':0,'negotiation':0,'authority':0,'connection':0
    },
    'kitPoints': 0,'scrip': 0,'inventario': '',
    'sinMarksInventario': [], 'habilidadesInventario': []
  };

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString('juancon_cain_sheet');
    if (s != null) {
      try {
        final obj = jsonDecode(s) as Map<String, dynamic>;
        setState(() { _mergeFromJson(obj); });
      } catch (e) {
        debugPrint('error cargando: $e');
      }
    }
  }

  void _mergeFromJson(Map<String, dynamic> obj) {
    obj.forEach((k, v) => _data[k] = v);
    // atributos:
    if (obj['atributos'] != null) {
      _data['atributos'] = Map<String, dynamic>.from(obj['atributos']);
    }
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1200);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _saveLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(_data);
    await prefs.setString('juancon_cain_sheet', jsonStr);
    Fluttertoast.showToast(msg: 'Hoja guardada localmente');
  }

  Future<void> _exportJson() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/juancon_sheet_${DateTime.now().millisecondsSinceEpoch}.json');
      await file.writeAsString(jsonEncode(_data));
      Fluttertoast.showToast(msg: 'Exportado: ${file.path}');
      // option: show share/save dialog or copy path - kept simple
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error exportando: $e');
    }
  }

  Future<void> _importJson() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      final content = await File(path).readAsString();
      final obj = jsonDecode(content) as Map<String, dynamic>;
      setState(() {
        _mergeFromJson(obj);
      });
      Fluttertoast.showToast(msg: 'Importado correctamente');
    }
  }

  Widget _numberField(String label, String keyAttr) {
    return TextFormField(
      initialValue: _data['atributos'][keyAttr].toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      onChanged: (v) { setState(() { _data['atributos'][keyAttr] = int.tryParse(v) ?? 0; }); },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoja de Personaje - CAIN'),
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveLocal,
        label: const Text('Guardar'),
        icon: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // imagen y controles
                Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 110, height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFEC407A)),
                          image: _imageFile != null ? DecorationImage(image: FileImage(_imageFile!), fit: BoxFit.cover) : null,
                          color: Colors.white10
                        ),
                        child: _imageFile == null ? const Icon(Icons.add_a_photo, size: 32) : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: _data['nombre'],
                            decoration: const InputDecoration(labelText: 'Nombre'),
                            onChanged: (v) => _data['nombre'] = v,
                          ),
                          TextFormField(
                            initialValue: _data['faccion'],
                            decoration: const InputDecoration(labelText: 'Facción'),
                            onChanged: (v) => _data['faccion'] = v,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: _data['descripcion'],
                  decoration: const InputDecoration(labelText: 'Descripción', alignLabelWithHint: true),
                  minLines: 2, maxLines: 4,
                  onChanged: (v) => _data['descripcion'] = v,
                ),
                const SizedBox(height: 14),
                Card(
                  color: Colors.white10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text('Atributos', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8, runSpacing: 6,
                          children: [
                            SizedBox(width: 160, child: _numberField('Fuerza', 'fuerza')),
                            SizedBox(width: 160, child: _numberField('Agilidad', 'agilidad')),
                            SizedBox(width: 160, child: _numberField('Percepción', 'percepcion')),
                            SizedBox(width: 160, child: _numberField('Voluntad', 'voluntad')),
                            SizedBox(width: 160, child: _numberField('Interfacing', 'interfacing')),
                            SizedBox(width: 160, child: _numberField('Investigation', 'investigation')),
                            SizedBox(width: 160, child: _numberField('Surveillance', 'surveillance')),
                            SizedBox(width: 160, child: _numberField('Negotiation', 'negotiation')),
                            SizedBox(width: 160, child: _numberField('Authority', 'authority')),
                            SizedBox(width: 160, child: _numberField('Connection', 'connection')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Card(
                  color: Colors.white10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      const Text('Equipo'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: _data['kitPoints'].toString(),
                              decoration: const InputDecoration(labelText: 'Kit Points'),
                              keyboardType: TextInputType.number,
                              onChanged: (v) => _data['kitPoints'] = int.tryParse(v) ?? 0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              initialValue: _data['scrip'].toString(),
                              decoration: const InputDecoration(labelText: 'Scrip'),
                              keyboardType: TextInputType.number,
                              onChanged: (v) => _data['scrip'] = int.tryParse(v) ?? 0,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _data['inventario'],
                        decoration: const InputDecoration(labelText: 'Inventario'),
                        minLines: 2, maxLines: 4,
                        onChanged: (v) => _data['inventario'] = v,
                      )
                    ]),
                  ),
                ),

                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _exportJson,
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Exportar JSON'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _importJson,
                      icon: const Icon(Icons.download),
                      label: const Text('Importar JSON'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Text('Inventarios (editable): añade o borra entradas en el JSON importado/exportado'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ------------------ KITS PAGE (estructura base) ------------------ */
class KitsPage extends StatelessWidget {
  const KitsPage({super.key});
  @override
  Widget build(BuildContext context) {
    // Implementación simplificada: muestra una lista de kits (puedes poblar desde JSON si lo deseas)
    final kits = [
      {'name': 'Cuerpo Negro', 'cost': '3 BBB : 1,750', 'type': 'Consumible'},
      {'name': 'Artemisia', 'cost': '4 BBB : 2,450', 'type': 'Consumible'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Kits de Expansión')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: kits.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final k = kits[i];
          return Card(
            color: Colors.white10,
            child: ListTile(
              title: Text(k['name'] ?? ''),
              subtitle: Text('${k['type']} • ${k['cost']}'),
            ),
          );
        },
      ),
    );
  }
}

/* ------------------ CATEGORÍAS PAGE (estructura base) ------------------ */
class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key});
  @override
  Widget build(BuildContext context) {
    // Estructura base reproduciendo secciones; puedes ampliarla con datos reales desde el HTML original
    final categories = [
      {'title': 'BEAST', 'desc': 'Provocar una pelea / Contenerse'},
      {'title': 'DOOMED', 'desc': 'Demostrar tu humanidad / Demostrar distancia'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: categories.length,
        itemBuilder: (_, i) {
          final c = categories[i];
          return Card(
            color: Colors.white10,
            child: ListTile(
              title: Text(c['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(c['desc'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
