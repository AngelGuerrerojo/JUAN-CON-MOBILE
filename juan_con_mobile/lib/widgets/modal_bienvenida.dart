import 'package:flutter/material.dart';

class ModalBienvenida extends StatelessWidget {
  final VoidCallback onClose;

  const ModalBienvenida({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xFFEC407A), width: 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9C27B0), Color(0xFF6A1B9A)],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFEC407A), width: 2),
                  ),
                ),
                child: Text(
                  '¡Bienvenido a JUAN-CON!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF8BBD0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Roman',
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Body
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '¡Hola! Te damos la bienvenida al menú principal de JUAN-CON.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Permanent Marker',
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Criticas ya sabes por que agujero te caben pa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Permanent Marker',
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Ultima actualizacion: JUAN-CON 2.O, Estilos, traduccion, categorias y kits de expansion!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Permanent Marker',
                      ),
                    ),
                  ],
                ),
              ),
              
              // Footer
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFF9C27B0), width: 1),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: onClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Color(0xFFF8BBD0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color(0xFFF8BBD0), width: 2),
                    ),
                    shadowColor: Color(0xFFEC407A).withOpacity(0.5),
                    elevation: 10,
                  ),
                  child: Text(
                    '¡Entendido!',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Times New Roman',
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}