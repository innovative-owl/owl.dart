import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owl/owl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async.g.dart';

@riverpod
Stream<String> stringStream(StringStreamRef ref) {
  return Stream.periodic(const Duration(seconds: 1), (i) => '$i');
}

@riverpod
Stream<List<String>> listStringStream(ListStringStreamRef ref) {
  return Stream.periodic(const Duration(seconds: 1),
      (i) => List.generate(i + 1, (index) => '$index'));
}

class Async extends HookConsumerWidget {
  const Async({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stringStream = ref.watch(stringStreamProvider);
    final listStringStream = ref.watch(listStringStreamProvider);

    return Column(
      children: [
        // * AsyncValueBuilder

        CardOrganize(
          'AsyncValueBuilder',
          AsyncValueBuilder<String>(
            value: stringStream,
            builder: (value) => Text(value),
          ),
        ),

        // * ItemListBuilder

        CardOrganize(
          'ItemListBuilder',
          ItemListBuilder<String>(
            data: listStringStream,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, value, index) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(value)],
            ),
          ),
        ),
      ],
    );
  }
}
