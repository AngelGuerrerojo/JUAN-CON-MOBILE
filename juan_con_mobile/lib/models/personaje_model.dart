class Personaje {
  String nombre;
  int edad;
  String faccion;
  String descripcion;
  Map<String, int> atributos;
  Map<String, dynamic> blasfemias;
  String agenda;
  int kitPoints;
  int scrip;
  String inventario;
  List<bool> sinPuntos;
  List<dynamic> sinMarks;
  List<dynamic> habilidades;
  String? imagenPath;
  String estiloSeleccionado;

  Personaje({
    this.nombre = '',
    this.edad = 0,
    this.faccion = '',
    this.descripcion = '',
    Map<String, int>? atributos,
    this.blasfemias = const {},
    this.agenda = '',
    this.kitPoints = 0,
    this.scrip = 0,
    this.inventario = '',
    List<bool>? sinPuntos,
    this.sinMarks = const [],
    this.habilidades = const [],
    this.imagenPath,
    this.estiloSeleccionado = '',
  })  : atributos = atributos ?? {
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
        sinPuntos = sinPuntos ?? List.generate(10, (_) => false);

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'edad': edad,
      'faccion': faccion,
      'descripcion': descripcion,
      'atributos': atributos,
      'blasfemias': blasfemias,
      'agenda': agenda,
      'kitPoints': kitPoints,
      'scrip': scrip,
      'inventario': inventario,
      'sinPuntos': sinPuntos,
      'sinMarks': sinMarks,
      'habilidades': habilidades,
      'estiloSeleccionado': estiloSeleccionado,
    };
  }

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
      nombre: json['nombre'] ?? '',
      edad: json['edad'] ?? 0,
      faccion: json['faccion'] ?? '',
      descripcion: json['descripcion'] ?? '',
      atributos: Map<String, int>.from(json['atributos'] ?? {}),
      blasfemias: Map<String, dynamic>.from(json['blasfemias'] ?? {}),
      agenda: json['agenda'] ?? '',
      kitPoints: json['kitPoints'] ?? 0,
      scrip: json['scrip'] ?? 0,
      inventario: json['inventario'] ?? '',
      sinPuntos: List<bool>.from(json['sinPuntos'] ?? []),
      sinMarks: List<dynamic>.from(json['sinMarks'] ?? []),
      habilidades: List<dynamic>.from(json['habilidades'] ?? []),
      estiloSeleccionado: json['estiloSeleccionado'] ?? '',
    );
  }
}