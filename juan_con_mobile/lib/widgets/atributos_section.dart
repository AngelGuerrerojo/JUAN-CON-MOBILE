import 'package:flutter/material.dart';

class AtributosSection extends StatelessWidget {
  final Map<String, int> atributos;
  final Function(String, int) onAtributoChanged;

  const AtributosSection({
    super.key,
    required this.atributos,
    required this.onAtributoChanged,
  });

  @override
  Widget build(BuildContext context) {
    final atributosList = [
      {'key': 'Force', 'label': 'FORCE'},
      {'key': 'Conditioning', 'label': 'CONDITIONING'},
      {'key': 'Coordination', 'label': 'COORDINATION'},
      {'key': 'Covert', 'label': 'COVERT'},
      {'key': 'Interfacing', 'label': 'INTERFACING'},
      {'key': 'Investigation', 'label': 'INVESTIGATION'},
      {'key': 'Surveillance', 'label': 'SURVEILLANCE'},
      {'key': 'Negotiation', 'label': 'NEGOTIATION'},
      {'key': 'Authority', 'label': 'AUTHORITY'},
      {'key': 'Connection', 'label': 'CONNECTION'},
    ];

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
            'Atributos',
            style: TextStyle(
              color: Color(0xFFFFD1F0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: atributosList.map((atributo) {
              return _buildAtributoCard(
                label: atributo['label']!,
                value: atributos[atributo['key']] ?? 0,
                onChanged: (value) => onAtributoChanged(atributo['key']!, value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAtributoCard({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF9C27B0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.95),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFEC407A)),
            ),
            child: TextField(
              controller: TextEditingController(text: value.toString()),
              onChanged: (text) => onChanged(int.tryParse(text) ?? 0),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}