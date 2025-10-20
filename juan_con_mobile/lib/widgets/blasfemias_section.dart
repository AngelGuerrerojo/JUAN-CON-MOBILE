import 'package:flutter/material.dart';

class BlasfemiasSection extends StatefulWidget {
  final Map<String, dynamic> blasfemias;
  final List<String> habilidades;
  final Function(Map<String, dynamic>, List<String>) onBlasfemiaChanged;

  const BlasfemiasSection({
    super.key,
    required this.blasfemias,
    required this.habilidades,
    required this.onBlasfemiaChanged,
  });

  @override
  State<BlasfemiasSection> createState() => _BlasfemiasSectionState();
}

class _BlasfemiasSectionState extends State<BlasfemiasSection> {
  final List<String> _blasfemiasDisponibles = [
    'Tensión', 'Ardence', 'Flux', 'Vector', 'Gate', 'Smother', 
    'Whisper', 'Edit', 'Bind', 'Palace', 'Jaunt', 'Sympathy',
    'Justice', 'Faith', 'Charity', 'Fortitude', 'Hope', 'Prudence'
  ];

  final Map<String, List<String>> _habilidadesPorBlasfemia = {
    'Tensión': ['IRON SOUL: PASIVA', 'AEGIS', 'STASIS', 'SEVERANCE', 'MALLEATE', 'FORTRESS'],
    'Ardence': ['INNER FURNACE: PASIVA', 'HELL', 'SABRE', 'FURY', 'VOID', 'STORM'],
    'Flux': ['STEAL TIME: PASIVA', 'REVERSAL', 'STOP', 'QUICKENING', 'SCHISM', 'STUTTER'],
    'Vector': ['BRAKE: PASIVA', 'FLING', 'LIFT', 'CURRENT', 'BULLET', 'FINESSE'],
    'Gate': ['POCKET: PASIVA', 'TEAR', 'PINCH', 'BLOOM', 'MAZE', 'TRANSMISSION'],
    'Smother': ['ABSENTIA: PASIVA', 'HOLLOW', 'ABSTRACT', 'SMOOTH', 'DARK AGE', 'BLING'],
    'Whisper': ['SHADOW: PASIVA', 'OMEN', 'SHIVER', 'DISSECT', 'PRECOGNITION', 'OMNIPRESENCE'],
    'Edit': ['MIMIC: PASIVA', 'UNIFORM', 'ABSURD', 'UTILITY', 'COPY', 'FILTER'],
    'Bind': ['SIN BINDING: PASIVA', 'HORDE SPIRIT', 'FORBIDDEN SPIRIT', 'SURRENDER', 'PRISON', 'HUNTER SPIRIT'],
    'Palace': ['SANCTUM: PASIVA', 'LIBRARY', 'FOYER', 'PARLOR', 'BAR', 'CELLAR'],
    'Jaunt': ['GHOSTWIRE: PASIVA', 'POSSESSION', 'GEIST', 'THREADS', 'PASSENGER', 'DESECRATE'],
    'Sympathy': ['RESONANCE: PASIVA', 'AMPLIFY', 'BOND', 'DIPLOMACY', 'PSYCHOMETRY', 'ALLIANCE'],
    'Justice': ['LAW'],
    'Faith': ['IMMACULATE DEFIANCE OF HEAVEN: PASIVA', 'NULL'],
    'Charity': ['ENTWINE'],
    'Fortitude': ['STRENGTH'],
    'Hope': ['VELL'],
    'Prudence': ['SHAKE'],
  };

  String? _blasfemiaSeleccionada;
  String? _habilidadSeleccionada;

  @override
  Widget build(BuildContext context) {
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
            'BLASPHEMIES',
            style: TextStyle(
              color: Color(0xFFFFD1F0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Selectores de Blasfemias
          Row(
            children: [
              Expanded(
                child: _buildBlasfemiaSelector(
                  label: 'BLASPHEMY 1:',
                  value: widget.blasfemias['blasfemia1'] ?? '',
                  onChanged: (value) => _actualizarBlasfemia('blasfemia1', value),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBlasfemiaSelector(
                  label: 'BLASPHEMY 2:',
                  value: widget.blasfemias['blasfemia2'] ?? '',
                  onChanged: (value) => _actualizarBlasfemia('blasfemia2', value),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Descripción de Blasfemia
          _buildDescripcionBlasfemia(),
          
          const SizedBox(height: 20),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          
          // Sistema de Habilidades
          _buildSistemaHabilidades(),
        ],
      ),
    );
  }

  Widget _buildBlasfemiaSelector({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800]!.withOpacity(0.95),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF9C27B0)),
          ),
          child: DropdownButtonFormField<String>(
            value: value.isEmpty ? null : value,
            onChanged: (newValue) => onChanged(newValue ?? ''),
            items: [
              const DropdownMenuItem(
                value: '',
                child: Text('Seleccionar', style: TextStyle(color: Colors.white54)),
              ),
              ..._blasfemiasDisponibles.map((blasfemia) {
                return DropdownMenuItem(
                  value: blasfemia,
                  child: Text(blasfemia, style: const TextStyle(color: Colors.white)),
                );
              }),
            ],
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            dropdownColor: Colors.grey[900],
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDescripcionBlasfemia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción:',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: widget.blasfemias['descripcion'] ?? ''),
          onChanged: (value) => _actualizarBlasfemia('descripcion', value),
          maxLines: 2,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800]!.withOpacity(0.95),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF9C27B0)),
            ),
            hintText: 'Descripción / notas de tu blasphemy',
            hintStyle: const TextStyle(color: Colors.white54),
          ),
        ),
      ],
    );
  }

  Widget _buildSistemaHabilidades() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sistema de Habilidades',
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
                  _buildHabilidadSelector(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _agregarHabilidad,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9C27B0),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Agregar habilidad'),
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
                    'Inventario de habilidades:',
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
                      itemCount: widget.habilidades.length,
                      itemBuilder: (context, index) {
                        return _buildHabilidadItem(widget.habilidades[index], index);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Puedes editar las habilidades directamente en el inventario.',
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

  Widget _buildHabilidadSelector() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _blasfemiaSeleccionada,
          onChanged: (value) {
            setState(() {
              _blasfemiaSeleccionada = value;
              _habilidadSeleccionada = null;
            });
          },
          decoration: InputDecoration(
            labelText: 'Seleccionar Blasphemy',
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.grey[800],
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF9C27B0)),
            ),
          ),
          items: _blasfemiasDisponibles.map((blasfemia) {
            return DropdownMenuItem(
              value: blasfemia,
              child: Text(blasfemia, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          dropdownColor: Colors.grey[900],
        ),
        
        const SizedBox(height: 12),
        
        DropdownButtonFormField<String>(
          value: _habilidadSeleccionada,
          onChanged: (value) {
            setState(() {
              _habilidadSeleccionada = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Seleccionar Habilidad',
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.grey[800],
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF9C27B0)),
            ),
          ),
          items: _obtenerHabilidadesDisponibles().map((habilidad) {
            return DropdownMenuItem(
              value: habilidad,
              child: Text(habilidad, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          dropdownColor: Colors.grey[900],
        ),
      ],
    );
  }

  List<String> _obtenerHabilidadesDisponibles() {
    if (_blasfemiaSeleccionada == null || 
        !_habilidadesPorBlasfemia.containsKey(_blasfemiaSeleccionada)) {
      return ['Primero selecciona una blasphemy'];
    }
    return _habilidadesPorBlasfemia[_blasfemiaSeleccionada!]!;
  }

  Widget _buildHabilidadItem(String habilidad, int index) {
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
              habilidad,
              style: const TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 16, color: Colors.red),
            onPressed: () => _eliminarHabilidad(index),
          ),
        ],
      ),
    );
  }

  void _actualizarBlasfemia(String clave, String valor) {
    final nuevasBlasfemias = Map<String, dynamic>.from(widget.blasfemias);
    nuevasBlasfemias[clave] = valor;
    widget.onBlasfemiaChanged(nuevasBlasfemias, widget.habilidades);
  }

  void _agregarHabilidad() {
    if (_blasfemiaSeleccionada == null || _habilidadSeleccionada == null) {
      return;
    }

    final nuevaHabilidad = '$_blasfemiaSeleccionada — $_habilidadSeleccionada';
    final nuevasHabilidades = List<String>.from(widget.habilidades);
    
    if (!nuevasHabilidades.contains(nuevaHabilidad)) {
      nuevasHabilidades.add(nuevaHabilidad);
      widget.onBlasfemiaChanged(widget.blasfemias, nuevasHabilidades);
      
      // Limpiar selecciones
      setState(() {
        _habilidadSeleccionada = null;
      });
    }
  }

  void _eliminarHabilidad(int index) {
    final nuevasHabilidades = List<String>.from(widget.habilidades);
    nuevasHabilidades.removeAt(index);
    widget.onBlasfemiaChanged(widget.blasfemias, nuevasHabilidades);
  }
}