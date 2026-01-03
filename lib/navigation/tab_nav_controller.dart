import 'package:flutter/widgets.dart';

/// Allows any screen inside the app shell to switch the selected bottom-nav tab.
class TabNavController extends InheritedNotifier<ValueNotifier<int>> {
  const TabNavController({
    super.key,
    required ValueNotifier<int> notifier,
    required Widget child,
  }) : super(notifier: notifier, child: child);

  static ValueNotifier<int> of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<TabNavController>();
    assert(widget != null, 'TabNavController not found in widget tree');
    return widget!.notifier!;
  }
}


