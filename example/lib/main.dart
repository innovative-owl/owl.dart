import 'package:example/animations.dart';
import 'package:example/async.dart';
import 'package:example/responsive.dart';
import 'package:example/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final child = useState<Widget>(Container());
    return UncontrolledProviderScope(
      container: ProviderContainer(),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => child.value = const Widgets(),
                        child: const Text('Widgets'),
                      ),
                      ElevatedButton(
                        onPressed: () => child.value = const Responsive(),
                        child: const Text('Responsive'),
                      ),
                      ElevatedButton(
                        onPressed: () => child.value = const Async(),
                        child: const Text('Async'),
                      ),
                      ElevatedButton(
                        onPressed: () => child.value = const Animations(),
                        child: const Text('Animations'),
                      ),
                    ],
                  ),
                  child.value,
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class CardOrganize extends StatelessWidget {
  const CardOrganize(this.title, this.child, {Key? key}) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Theme.of(context).primaryColorLight.withOpacity(.75),
          shadowColor: Colors.transparent,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              child,
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
