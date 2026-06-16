import 'package:flutter_test/flutter_test.dart';
import 'package:learnhero_flutter/main.dart';

void main() {
  testWidgets('mostra a tela inicial do LearnHero', (tester) async {
    await tester.pumpWidget(const LearnHeroApp());

    expect(find.text('LearnHero'), findsOneWidget);
    expect(find.text('Começar sua jornada'), findsOneWidget);
  });
}
