import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owl/owl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'animations.g.dart';

@riverpod
Stream<int> numberStream(NumberStreamRef ref) {
  return Stream.periodic(const Duration(seconds: 1), (i) => i);
}

class Animations extends HookConsumerWidget {
  const Animations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberStream = ref.watch(numberStreamProvider);
    return Column(
      children: [
        // * AnimatiedNumber

        AsyncValueBuilder(
          value: numberStream,
          builder: (value) {
            return CardOrganize(
              'Animated Number',
              Column(
                children: [
                  AnimatedNumber(
                    number: value,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.green),
                  ),
                  Text(
                    '$value\n(without)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
