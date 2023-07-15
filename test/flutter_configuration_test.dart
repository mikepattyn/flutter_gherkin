import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_gherkin/src/flutter/hooks/app_runner_hook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mocks/step_definition_mock.dart';

void main() {
  group("config", () {
    group("prepare", () {
      test("flutter app runner hook added", () {
        final config = FlutterTestConfiguration();
        expect(config.hooks, isNull);
        config.prepare();
        expect(config.hooks, isNotNull);
        expect(config.hooks?.length, 1);
        expect(config.hooks?.elementAt(0), (x) => x is FlutterAppRunnerHook);
      });

      test("common step definition added", () {
        final config = FlutterTestConfiguration();
        expect(config.stepDefinitions, isNull);

        config.prepare();
        expect(config.stepDefinitions, isNotNull);
        expect(config.stepDefinitions?.length, 5);
        expect(config.stepDefinitions?.elementAt(0), (x) => x is ThenExpectElementToHaveValue);
        expect(config.stepDefinitions?.elementAt(1), (x) => x is WhenTapWidget);
        expect(config.stepDefinitions?.elementAt(2), (x) => x is GivenOpenDrawer);
        expect(config.stepDefinitions?.elementAt(3), (x) => x is WhenPauseStep);
        expect(config.stepDefinitions?.elementAt(4), (x) => x is WhenFillFieldStep);
      });

      test("common step definition added to existing steps", () {
        final config = FlutterTestConfiguration()..stepDefinitions = [MockStepDefinition()];
        expect(config.stepDefinitions?.length, 1);

        config.prepare();
        expect(config.stepDefinitions, isNotNull);
        expect(config.stepDefinitions?.length, 6);
        expect(config.stepDefinitions?.elementAt(0), (x) => x is MockStepDefinition);
        expect(config.stepDefinitions?.elementAt(1), (x) => x is ThenExpectElementToHaveValue);
      });
    });
  });
}
