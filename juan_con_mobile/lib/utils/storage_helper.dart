class Personaje {
  // Información básica
  final String nombre;
  final int edad;
  final String faccion;
  final String descripcion;
  
  // Atributos
  final Map<String, int> atributos;
  
  // Blasphemies
  final String blasfemia1;
  final String blasfemia2;
  final String descripcionBlasfemia;
  
  // Agenda
  final String agenda;
  
  // Equipo
  final int kitPoints;
  final int scrip;
  final String inventario;
  
  // SIN
  final List<int> sinPuntos;
  final List<String> sinMarks;
  final List<String> habilidades;
  
  // Estilo seleccionado
  final String? estiloSeleccionado;

  Personaje({
    this.nombre = '',
    this.edad = 0,
    this.faccion = '',
    this.descripcion = '',
    this.atributos = const {},
    this.blasfemia1 = '',
    this.blasfemia2 = '',
    this.descripcionBlasfemia = '',
    this.agenda = '',
    this.kitPoints = 0,
    this.scrip = 0,
    this.inventario = '',
    this.sinPuntos = const [],
    this.sinMarks = const [],
    this.habilidades = const [],
    this.estiloSeleccionado,
  });

  // Constructor para personaje nuevo
  factory Personaje.nuevo() {
    return Personaje(
      atributos: {
        'Force': 0,
        'Conditioning': 0,
        'Coordination': 0,
        'Covert': 0,
        'Interfacing': 0,
        'Investigation': 0,
        'Surveillance': 0,
        'Negotiation': 0,
        'Authority': 0,
        'Connection': 0,
      },
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'basic': {
        'nombre': nombre,
        'edad': edad,
        'faccion': faccion,
        'descripcion': descripcion,
      },
      'atributos': atributos,
      'blasfemias': {
        'blasfemia1': blasfemia1,
        'blasfemia2': blasfemia2,
        'descripcionBlasfemia': descripcionBlasfemia,
      },
      'agenda': agenda,
      'equipo': {
        'kitPoints': kitPoints,
        'scrip': scrip,
        'inventario': inventario,
      },
      'sin': {
        'puntos': sinPuntos,
        'marks': sinMarks,
        'habilidades': habilidades,
      },
      'estiloSeleccionado': estiloSeleccionado,
      'metadata': {
        'savedAt': DateTime.now().toIso8601String(),
        'version': 'JUAN-CON 2.0',
      },
    };
  }

  // Crear desde JSON
  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
      nombre: json['basic']?['nombre'] ?? '',
      edad: json['basic']?['edad'] ?? 0,
      faccion: json['basic']?['faccion'] ?? '',
      descripcion: json['basic']?['descripcion'] ?? '',
      atributos: Map<String, int>.from(json['atributos'] ?? {}),
      blasfemia1: json['blasfemias']?['blasfemia1'] ?? '',
      blasfemia2: json['blasfemias']?['blasfemia2'] ?? '',
      descripcionBlasfemia: json['blasfemias']?['descripcionBlasfemia'] ?? '',
      agenda: json['agenda'] ?? '',
      kitPoints: json['equipo']?['kitPoints'] ?? 0,
      scrip: json['equipo']?['scrip'] ?? 0,
      inventario: json['equipo']?['inventario'] ?? '',
      sinPuntos: List<int>.from(json['sin']?['puntos'] ?? []),
      sinMarks: List<String>.from(json['sin']?['marks'] ?? []),
      habilidades: List<String>.from(json['sin']?['habilidades'] ?? []),
      estiloSeleccionado: json['estiloSeleccionado'],
    );
  }

  // Copiar con cambios
  Personaje copyWith({
    String? nombre,
    int? edad,
    String? faccion,
    String? descripcion,
    Map<String, int>? atributos,
    String? blasfemia1,
    String? blasfemia2,
    String? descripcionBlasfemia,
    String? agenda,
    int? kitPoints,
    int? scrip,
    String? inventario,
    List<int>? sinPuntos,
    List<String>? sinMarks,
    List<String>? habilidades,
    String? estiloSeleccionado,
  }) {
    return Personaje(
      nombre: nombre ?? this.nombre,
      edad: edad ?? this.edad,
      faccion: faccion ?? this.faccion,
      descripcion: descripcion ?? this.descripcion,
      atributos: atributos ?? this.atributos,
      blasfemia1: blasfemia1 ?? this.blasfemia1,
      blasfemia2: blasfemia2 ?? this.blasfemia2,
      descripcionBlasfemia: descripcionBlasfemia ?? this.descripcionBlasfemia,
      agenda: agenda ?? this.agenda,
      kitPoints: kitPoints ?? this.kitPoints,
      scrip: scrip ?? this.scrip,
      inventario: inventario ?? this.inventario,
      sinPuntos: sinPuntos ?? this.sinPuntos,
      sinMarks: sinMarks ?? this.sinMarks,
      habilidades: habilidades ?? this.habilidades,
      estiloSeleccionado: estiloSeleccionado ?? this.estiloSeleccionado,
    );
  }
}