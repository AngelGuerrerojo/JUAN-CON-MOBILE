import 'package:flutter/material.dart';

class AgendaSection extends StatefulWidget {
  final String agenda;
  final Function(String) onAgendaChanged;

  const AgendaSection({
    super.key,
    required this.agenda,
    required this.onAgendaChanged,
  });

  @override
  State<AgendaSection> createState() => _AgendaSectionState();
}

class _AgendaSectionState extends State<AgendaSection> {
  final Map<String, Map<String, dynamic>> _agendas = {
    'beast': {
      'name': 'BEAST',
      'items': ['* Provocar una pelea', '* Contenerse'],
      'subitems': [
        '► ¡Insectos!: Tienes +1D al infligir daño o violencia contra oponentes humanos.',
        '► Me llevas conmigo: Recupera 1d3 Psyche Burst cuando recibes una lesión...',
        // ... resto de subitems
      ],
    },
    'doomed': {
      'name': 'DOOMED',
      'items': ['* Demostrar tu humanidad', '* Demostrar tu distancia de la humanidad'],
      'subitems': [
        'Solo puedes elegir esta agenda si tienes una sin mark...',
        // ... resto de subitems
      ],
    },
    // ... añade más agendas
  };

  bool _showDetails = false;

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
            'AGENDA',
            style: TextStyle(
              color: Color(0xFFFFD1F0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Selector de Agenda
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selecciona tu Agenda:',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800]!.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF9C27B0)),
                ),
                child: DropdownButtonFormField<String>(
                  value: widget.agenda.isEmpty ? null : widget.agenda,
                  onChanged: (newValue) {
                    widget.onAgendaChanged(newValue ?? '');
                    setState(() {
                      _showDetails = newValue != null && newValue.isNotEmpty;
                    });
                  },
                  items: [
                    const DropdownMenuItem(
                      value: '',
                      child: Text('Elige una agenda', style: TextStyle(color: Colors.white54)),
                    ),
                    ..._agendas.keys.map((key) {
                      return DropdownMenuItem(
                        value: key,
                        child: Text(_agendas[key]!['name'], style: const TextStyle(color: Colors.white)),
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
          ),
          
          // Detalles de la Agenda
          if (_showDetails && widget.agenda.isNotEmpty && _agendas.containsKey(widget.agenda)) 
            _buildAgendaDetails(_agendas[widget.agenda]!),
        ],
      ),
    );
  }

  Widget _buildAgendaDetails(Map<String, dynamic> agenda) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF500078).withOpacity(0.12),
            const Color(0xFF28003C).withOpacity(0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            agenda['name'],
            style: const TextStyle(
              color: Color(0xFFEC407A),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Items principales
          ...(agenda['items'] as List).map<Widget>((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                item.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          }),
          
          const SizedBox(height: 12),
          
          // Subitems
          ...(agenda['subitems'] as List).map<Widget>((subitem) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                subitem.toString(),
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            );
          }),
        ],
      ),
    );
  }
}