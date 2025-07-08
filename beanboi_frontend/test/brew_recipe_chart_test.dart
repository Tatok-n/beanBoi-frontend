import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beanboi_frontend/widgets/brewRecipeDisplay/brewRecipeChart.dart';

void main() {
  group('BrewRecipeChart Widget Tests', () {
    testWidgets('BrewRecipeChart widget renders correctly', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BrewRecipeChart(
              ratio: 1.5,
              temperature: 92.0,
              duration: 30.0,
              numStages: 3,
              isEspresso: false,
            ),
          ),
        ),
      );

      // Wait for the widget to settle
      await tester.pumpAndSettle();

      // Verify that the chart selector is present
      expect(find.text('Brewing Profile'), findsOneWidget);
      expect(find.text('Parameters'), findsOneWidget);
      expect(find.text('Stages'), findsOneWidget);
    });

    testWidgets('Chart selector changes chart type', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BrewRecipeChart(
              ratio: 1.5,
              temperature: 92.0,
              duration: 30.0,
              numStages: 3,
              isEspresso: false,
            ),
          ),
        ),
      );

      // Wait for the widget to settle
      await tester.pumpAndSettle();

      // Initially, Brewing Profile should be selected
      expect(find.text('Brewing Profile'), findsOneWidget);

      // Tap on Parameters button
      await tester.tap(find.text('Parameters'));
      await tester.pumpAndSettle();

      // The widget should rebuild with the new chart type
      // We can't easily test the actual chart rendering without more complex setup
      // But we can verify the widget doesn't crash
      expect(find.text('Parameters'), findsOneWidget);
    });

    testWidgets('Chart widget handles different brewing methods', (WidgetTester tester) async {
      // Test with Espresso
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BrewRecipeChart(
              ratio: 2.0,
              temperature: 93.0,
              duration: 25.0,
              numStages: 1,
              isEspresso: true,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Brewing Profile'), findsOneWidget);

      // Test with V60
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BrewRecipeChart(
              ratio: 1.6,
              temperature: 90.0,
              duration: 45.0,
              numStages: 4,
              isEspresso: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Brewing Profile'), findsOneWidget);
    });

    testWidgets('Chart widget handles extreme values', (WidgetTester tester) async {
      // Test with minimum values
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BrewRecipeChart(
              ratio: 0.5,
              temperature: 60.0,
              duration: 5.0,
              numStages: 1,
              isEspresso: true,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Brewing Profile'), findsOneWidget);

      // Test with maximum values
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BrewRecipeChart(
              ratio: 20.0,
              temperature: 100.0,
              duration: 240.0,
              numStages: 10,
              isEspresso: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Brewing Profile'), findsOneWidget);
    });
  });
}