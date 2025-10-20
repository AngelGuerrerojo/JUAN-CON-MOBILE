import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juancon_app/main.dart';
import 'package:juancon_app/screens/main_menu.dart';
import 'package:juancon_app/widgets/blasfemias_section.dart';
import 'package:juancon_app/widgets/equipo_section.dart';

void main() {
  group('JUAN-CON Widget Tests', () {
    testWidgets('Main app loads correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp()); // QUITAR const

      // Verify that the main menu is loaded
      expect(find.byType(MainMenuScreen), findsOneWidget);
    });

    testWidgets('Main menu displays correct elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MainMenuScreen())); // QUITAR const

      // Verify main title
      expect(find.text('Menú JUAN-CON'), findsOneWidget);
      
      // Verify menu options
      expect(find.text('Personaje'), findsOneWidget);
      expect(find.text('Kits de Expansión'), findsOneWidget);
      expect(find.text('Categorías'), findsOneWidget);
    });

    testWidgets('BlasfemiasSection renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlasfemiasSection(
            blasfemias: {},
            habilidades: [],
            onBlasfemiaChanged: (blasfemias, habilidades) {},
          ),
        ),
      ));

      // Verify section title
      expect(find.text('BLASPHEMIES'), findsOneWidget);
      
      // Verify blasphemy selectors
      expect(find.text('BLASPHEMY 1:'), findsOneWidget);
      expect(find.text('BLASPHEMY 2:'), findsOneWidget);
    });

    testWidgets('EquipoSection renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: EquipoSection(
            kitPoints: 0,
            scrip: 0,
            inventario: '',
            onEquipoChanged: (kitPoints, scrip, inventario) {},
          ),
        ),
      ));

      // Verify section title
      expect(find.text('EQUIPO'), findsOneWidget);
      
      // Verify resource fields
      expect(find.text('KIT POINTS'), findsOneWidget);
      expect(find.text('SCRIP'), findsOneWidget);
      expect(find.text('Inventario:'), findsOneWidget);
    });

    testWidgets('EquipoSection updates values correctly', (WidgetTester tester) async {
      int testKitPoints = 0;
      int testScrip = 0;
      String testInventario = '';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: EquipoSection(
            kitPoints: testKitPoints,
            scrip: testScrip,
            inventario: testInventario,
            onEquipoChanged: (kitPoints, scrip, inventario) {
              testKitPoints = kitPoints;
              testScrip = scrip;
              testInventario = inventario;
            },
          ),
        ),
      ));

      // Enter kit points
      await tester.enterText(find.byType(TextField).at(0), '5');
      expect(testKitPoints, 5);

      // Enter scrip
      await tester.enterText(find.byType(TextField).at(1), '50');
      expect(testScrip, 50);

      // Enter inventory
      await tester.enterText(find.byType(TextField).at(2), 'Espada, Escudo');
      expect(testInventario, 'Espada, Escudo');
    });
  });
}