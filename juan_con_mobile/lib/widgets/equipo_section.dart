import 'package:flutter/material.dart';

class EquipoSection extends StatefulWidget {
  final int kitPoints;
  final int scrip;
  final String inventario;
  final Function(int, int, String) onEquipoChanged;

  const EquipoSection({
    super.key,
    required this.kitPoints,
    required this.scrip,
    required this.inventario,
    required this.onEquipoChanged,
  });

  @override
  State<EquipoSection> createState() => _EquipoSectionState();
}

class _EquipoSectionState extends State<EquipoSection> {
  late TextEditingController _kitPointsController;
  late TextEditingController _scripController;
  late TextEditingController _inventarioController;

  @override
  void initState() {
    super.initState();
    _kitPointsController = TextEditingController(text: widget.kitPoints.toString());
    _scripController = TextEditingController(text: widget.scrip.toString());
    _inventarioController = TextEditingController(text: widget.inventario);
  }

  @override
  void didUpdateWidget(EquipoSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.kitPoints != oldWidget.kitPoints) {
      _kitPointsController.text = widget.kitPoints.toString();
    }
    if (widget.scrip != oldWidget.scrip) {
      _scripController.text = widget.scrip.toString();
    }
    if (widget.inventario != oldWidget.inventario) {
      _inventarioController.text = widget.inventario;
    }
  }

  @override
  void dispose() {
    _kitPointsController.dispose();
    _scripController.dispose();
    _inventarioController.dispose();
    super.dispose();
  }

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
            'EQUIPO',
            style: TextStyle(
              color: Color(0xFFFFD1F0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Recursos (Kit Points y Scrip)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 207, 78, 233),
                  Color.fromARGB(255, 112, 2, 139),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF9C27B0).withOpacity(0.12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildRecursoField(
                    label: 'KIT POINTS',
                    controller: _kitPointsController,
                    max: 9,
                    onChanged: (value) => widget.onEquipoChanged(value, widget.scrip, widget.inventario),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildRecursoField(
                    label: 'SCRIP',
                    controller: _scripController,
                    max: 100,
                    onChanged: (value) => widget.onEquipoChanged(widget.kitPoints, value, widget.inventario),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Inventario
          _buildInventarioField(),
        ],
      ),
    );
  }

  Widget _buildRecursoField({
    required String label,
    required TextEditingController controller,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
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
        TextField(
          controller: controller,
          onChanged: (text) {
            final newValue = int.tryParse(text) ?? 0;
            if (newValue <= max) {
              onChanged(newValue);
            } else {
              // Si excede el máximo, mantener el valor anterior
              controller.text = widget.kitPoints.toString();
            }
          },
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800]!.withOpacity(0.95),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF9C27B0)),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Máximo: $max',
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildInventarioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inventario:',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _inventarioController,
          onChanged: (value) => widget.onEquipoChanged(widget.kitPoints, widget.scrip, value),
          maxLines: 4,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800]!.withOpacity(0.95),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF9C27B0)),
            ),
            hintText: 'Lista de armas, objetos, equipo...',
            hintStyle: const TextStyle(color: Colors.white54),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}