import 'package:flutter/material.dart';
import 'personaje_screen.dart';
import 'kits_screen.dart';
import 'categorias_screen.dart';
import '../widgets/modal_bienvenida.dart';
import '../widgets/quejas_widget.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool _showWelcomeModal = true;

  @override
  void initState() {
    super.initState();
    // Aquí puedes agregar lógica para verificar si es la primera vez
  }

  void _closeWelcomeModal() {
    setState(() {
      _showWelcomeModal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://preview.redd.it/179for5z8rtf1.png?width=320&crop=smart&auto=webp&s=17c2cd086b95521527d08e654b8d7b24709a2dc6'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Contenido principal
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  
                  // Header
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Text(
                          'Menú JUAN-CON',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Segoe UI',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Elige para donde quieres ir',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            fontFamily: 'Segoe UI',
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Grid de cards
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                    children: [
                      _buildMenuCard(
                        'Personaje',
                        'https://preview.redd.it/tgcf4hvohrtf1.png?width=640&crop=smart&auto=webp&s=d82e27d2fe6f65a7dae4cc95b50338f5d9486a1a',
                        'Editar hoja de personaje, habilidades y equipo.',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PersonajeScreen()),
                          );
                        },
                      ),
                      
                      _buildMenuCard(
                        'Kits de Expansión',
                        'https://preview.redd.it/x6pepvhajqtf1.jpeg?width=640&crop=smart&auto=webp&s=9bc6d29b2197a7651a9e6959bef8cfbe57b7a04e',
                        'Ver kits, posesiones y tablas.',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => KitsScreen()),
                          );
                        },
                      ),
                      
                      _buildMenuCard(
                        'Categorías',
                        'https://preview.redd.it/to3ps5guhrtf1.png?width=320&crop=smart&auto=webp&s=eea9f297ec41b2bc8a70a5aeb1627d5717867b94',
                        'Información sobre categorías del sistema.',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CategoriasScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Footer
                  Text(
                    '© 2025 JUAN-CON',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Modal de bienvenida
          if (_showWelcomeModal)
            ModalBienvenida(onClose: _closeWelcomeModal),
            
          // Widget de quejas
          Positioned(
            bottom: 15,
            right: 15,
            child: QuejasWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, String imageUrl, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Contenido
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD1F0),
                        fontFamily: 'Segoe UI',
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: 'Segoe UI',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF9C27B0), Color(0xFFEC407A)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Abrir $title',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}