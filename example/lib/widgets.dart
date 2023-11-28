import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:owl/owl.dart';

class Widgets extends HookWidget {
  const Widgets({super.key});

  @override
  Widget build(BuildContext context) {
    final condition = useState(false);
    final clickable = useState(150.0);

    return Column(
      children: [
        // * SimpleAutoSaveTextField

        CardOrganize(
          'SimpleAutoSaveTextField',
          SizedBox(
            width: 300,
            child: SimpleAutoSaveTextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: useTextEditingController(),
              onSave: (v) => debugPrint('onSave: $v'),
            ),
          ),
        ),

        // * ConditionalParentWidget
        CardOrganize(
          'ConditionalParentWidget',
          ConditionalParentWidget(
            condition: condition.value,
            conditionalBuilder: (child) {
              return Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('Conditional Wrapper'),
                      child,
                    ],
                  ),
                ),
              );
            },
            child: ElevatedButton(
              onPressed: () => condition.value = !condition.value,
              child: Text(condition.value.toString()),
            ),
          ),
        ),

        // * Clickable

        CardOrganize(
          'Clickable',
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: clickable.value,
              height: clickable.value,
              child: Clickable(
                onTap: () =>
                    clickable.value = clickable.value == 150.0 ? 100.0 : 150.0,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
