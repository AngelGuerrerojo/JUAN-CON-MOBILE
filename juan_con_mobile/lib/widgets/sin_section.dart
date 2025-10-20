import 'package:flutter/material.dart';

class SinSection extends StatefulWidget {
  final List<bool> sinPuntos;
  final List<dynamic> sinMarks;
  final Function(List<bool>, List<dynamic>) onSinChanged;

  const SinSection({
    super.key,
    required this.sinPuntos,
    required this.sinMarks,
    required this.onSinChanged,
  });

  @override
  State<SinSection> createState() => _SinSectionState();
}

class _SinSectionState extends State<SinSection> {
  @override
  Widget build(BuildContext context) {
    final sinMarcados = widget.sinPuntos.where((punto) => punto).length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SIN',
            style: TextStyle(
              color: Color(0xFFFFD1F0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Contador
          Text(
            'Puntos marcados: $sinMarcados/10',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Grid de puntos SIN
          _buildSinGrid(),
          
          const SizedBox(height: 20),
          
          // Sección de SIN MARKS
          _buildSinMarksSection(),
        ],
      ),
    );
  }

  Widget _buildSinGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildSinPunto(index);
      },
    );
  }

  Widget _buildSinPunto(int index) {
    final estaMarcado = widget.sinPuntos[index];
    
    return GestureDetector(
      onTap: () {
        final nuevosPuntos = List<bool>.from(widget.sinPuntos);
        nuevosPuntos[index] = !nuevosPuntos[index];
        widget.onSinChanged(nuevosPuntos, widget.sinMarks);
      },
      child: Container(
        decoration: BoxDecoration(
          color: estaMarcado 
              ? const Color(0xFF9B27B0).withOpacity(0.87)
              : Colors.grey[700]!.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: estaMarcado ? const Color(0xFFEC407A) : const Color(0xFF9C27B0),
            width: 2,
          ),
          boxShadow: estaMarcado
              ? [
                  BoxShadow(
                    color: const Color(0xFFDF044D).withOpacity(0.918),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: estaMarcado ? const Color(0xFFEC407A) : Colors.transparent,
                border: Border.all(
                  color: estaMarcado ? Colors.white : Colors.grey[400]!,
                  width: 2,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSinMarksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SIN MARKS',
          style: TextStyle(
            color: Color(0xFFFFD1F0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Grid de SIN MARKS disponibles
        _buildSinMarksGrid(),
        
        const SizedBox(height: 20),
        
        // Selector y Inventario de SIN MARKS
        _buildSinMarksSelector(),
      ],
    );
  }

  Widget _buildSinMarksGrid() {
    final sinMarksDisponibles = {
      'EYES': 'Apariencia típica: Esclerótica negra o alterada, iris blanco, pupila partida o duplicada.',
      'JAW': 'Apariencia típica: Mandíbula partida o extendida, colmillos, lengua negra, saliva viscosa.',
      'BACK OR CHEST': 'Apariencia típica: Espinas, lesiones, piel endurecida o suelta, alas vestigiales, costillas extras.',
      'ARMS OR HANDS': 'Apariencia típica: Garras, manos partidas, brazo extra, dedos adicionales.',
      'SKIN, HAIR, OR LEGS': 'Apariencia típica: Decoloración, piel transparente, marcha alterada, piernas múltiples.',
    };

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: sinMarksDisponibles.length,
      itemBuilder: (context, index) {
        final key = sinMarksDisponibles.keys.elementAt(index);
        final descripcion = sinMarksDisponibles[key]!;
        
        return _buildSinMarkItem(key, descripcion);
      },
    );
  }

  Widget _buildSinMarkItem(String nombre, String descripcion) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[800]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF9C27B0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFEC407A),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              descripcion,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSinMarksSelector() {
    final sinMarksDisponibles = {
      'EYES': [
        '1. Puedes ver con claridad a distancias extremas, como si hicieras zoom.',
        '2. Puedes ver a través de paredes y materia no viva a corta distancia.',
        '3. Cuando están cerrados, puedes percibir el estado emocional ambiental...',
        '4. Una vez por misión, puedes paralizar momentáneamente a un humano con la mirada...',
        '5. Puedes ver en la oscuridad y no te afectan condiciones de oscuridad...',
        '6. Gana +1D a Surveillance. (Podría subirte hasta 4D).',
      ],
      'JAW': [
        '1. Puedes escupir veneno negro a corta distancia...',
        '2. Gana 1d3 Sin para volver a tirar cualquier tirada que requiera hablar...',
        '3. Puedes susurrar hasta 6 palabras que un objetivo elegido oirá a larga distancia.',
        '4. Gana +1D al negociar, mandar o convencer humanos.',
        '5. Una vez por misión, puedes dar una orden de una sola palabra a un humano...',
        '6. Gana +1D a Authority. (Podría subirte hasta 4D).',
      ],
      // ... añadir más sin marks según necesites
    };

    String? marcaPrincipalSeleccionada;
    String? subMarcaSeleccionada;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gestión de SIN MARKS',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selectores
            Expanded(
              child: Column(
                children: [
                  _buildSinMarkDropdown(
                    label: 'Seleccionar marca principal:',
                    value: marcaPrincipalSeleccionada,
                    items: sinMarksDisponibles.keys.toList(),
                    onChanged: (value) {
                      setState(() {
                        marcaPrincipalSeleccionada = value;
                        subMarcaSeleccionada = null;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildSinMarkDropdown(
                    label: 'Seleccionar sub-marca:',
                    value: subMarcaSeleccionada,
                    items: marcaPrincipalSeleccionada != null
                        ? sinMarksDisponibles[marcaPrincipalSeleccionada] ?? []
                        : [],
                    onChanged: (value) {
                      setState(() {
                        subMarcaSeleccionada = value;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  ElevatedButton(
                    onPressed: marcaPrincipalSeleccionada != null && subMarcaSeleccionada != null
                        ? () => _agregarSinMark(marcaPrincipalSeleccionada!, subMarcaSeleccionada!)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9C27B0),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Agregar marca'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 20),
            
            // Inventario
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Inventario de marcas:',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                    ),
                    child: ListView.builder(
                      itemCount: widget.sinMarks.length,
                      itemBuilder: (context, index) {
                        return _buildSinMarkInventarioItem(
                          widget.sinMarks[index].toString(),
                          index,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Puedes editar las marcas directamente en el inventario.',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSinMarkDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800]!.withOpacity(0.95),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF9C27B0)),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            items: [
              DropdownMenuItem(
                value: null,
                child: Text(
                  label.contains('principal') 
                      ? 'Selecciona una marca principal'
                      : 'Selecciona una sub-marca',
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
              ...items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.length > 50 ? '${item.substring(0, 50)}...' : item,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                );
              }),
            ],
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            dropdownColor: Colors.grey[900],
          ),
        ),
      ],
    );
  }

  Widget _buildSinMarkInventarioItem(String marca, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              marca,
              style: const TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 16, color: Colors.red),
            onPressed: () => _eliminarSinMark(index),
          ),
        ],
      ),
    );
  }

  void _agregarSinMark(String marcaPrincipal, String subMarca) {
    final nuevasMarks = List<dynamic>.from(widget.sinMarks);
    nuevasMarks.add('$marcaPrincipal: $subMarca');
    widget.onSinChanged(widget.sinPuntos, nuevasMarks);
  }

  void _eliminarSinMark(int index) {
    final nuevasMarks = List<dynamic>.from(widget.sinMarks);
    nuevasMarks.removeAt(index);
    widget.onSinChanged(widget.sinPuntos, nuevasMarks);
  }
}