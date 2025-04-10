import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding_plus/onboarding_plus.dart';

void main() {
  group('AnimatedOnboarding Tests', () {
    late Widget testWidget;
    late List<OnboardingPage> testPages;
    late OnboardingConfig testConfig;

    setUp(() {
      // Define test pages with different animations
      testPages = [
        OnboardingPage(
          imageBuilder: (context) => const Icon(Icons.star, size: 100),
          title: 'Page 1',
          description: 'Test page 1',
          animationType: OnboardingAnimationType.fade,
        ),
        OnboardingPage(
          imageBuilder: (context) => Image.network('https://via.placeholder.com/150'),
          title: 'Page 2',
          description: 'Test page 2',
          animationType: OnboardingAnimationType.slide,
        ),
        OnboardingPage(
          imageBuilder: (context) => const FlutterLogo(size: 100),
          title: 'Page 3',
          description: 'Test page 3',
          animationType: OnboardingAnimationType.customCombine,
        ),
      ];

      // Define test configuration
      testConfig = OnboardingConfig(
        pages: testPages,
        showSkipButton: true,
        showDoneButton: true,
        showProgressIndicator: true,
      );

      // Create the test widget
      testWidget = MaterialApp(
        home: AnimatedOnboarding(
          config: testConfig,
          onCompleted: () {},
        ),
      );
    });

    testWidgets('Renders without errors', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle(); // Wait for animations
      expect(find.byType(AnimatedOnboarding), findsOneWidget);
    });

    testWidgets('Displays all pages with correct animations', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      // Verify first page (Fade animation)
      expect(find.text('Page 1'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);

      // Swipe to the next page
      await tester.dragFrom(const Offset(400, 300), const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Verify second page (Slide animation)
      expect(find.text('Page 2'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget); // Network image

      // Swipe to the third page
      await tester.dragFrom(const Offset(400, 300), const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Verify third page (CustomCombine animation)
      expect(find.text('Page 3'), findsOneWidget);
      expect(find.byType(FlutterLogo), findsOneWidget);
    });

    testWidgets('Triggers onCompleted when done is pressed', (WidgetTester tester) async {
      bool completed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedOnboarding(
            config: testConfig,
            onCompleted: () => completed = true,
          ),
        ),
      );

      // Swipe to the last page
      await tester.dragFrom(const Offset(400, 300), const Offset(-500, 0));
      await tester.dragFrom(const Offset(400, 300), const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Tap the "Done" button
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      expect(completed, true);
    });

    testWidgets('Skips onboarding when skip button is pressed', (WidgetTester tester) async {
      bool completed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedOnboarding(
            config: testConfig.copyWith(showSkipButton: true),
            onCompleted: () => completed = true,
          ),
        ),
      );

      // Tap the "Skip" button
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(completed, true);
    });

    testWidgets('Shows progress indicator', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      // Verify progress indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

// Helper extension to simplify configuration updates
extension OnboardingConfigX on OnboardingConfig {
  OnboardingConfig copyWith({
    List<OnboardingPage>? pages,
    Duration? animationDuration,
    bool? showSkipButton,
    bool? showDoneButton,
    bool? showProgressIndicator,
  }) {
    return OnboardingConfig(
      pages: pages ?? this.pages,
      animationDuration: animationDuration ?? this.animationDuration,
      showSkipButton: showSkipButton ?? this.showSkipButton,
      showDoneButton: showDoneButton ?? this.showDoneButton,
      showProgressIndicator: showProgressIndicator ?? this.showProgressIndicator,
    );
  }
}