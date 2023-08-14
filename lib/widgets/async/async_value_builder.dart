import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncValueBuilder<T> extends ConsumerWidget {
  const AsyncValueBuilder({
    Key? key,
    required this.value,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) builder;
  final WidgetBuilder? loadingBuilder;
  final WidgetBuilder? errorBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: (data) => builder(data),
      error: (error, stackTrace) {
        return _ErrorBuilder(
          error: error,
          stackTrace: stackTrace,
          builder: errorBuilder,
        );
      },
      loading: () {
        return _LoadingBuilder(
          builder: loadingBuilder,
        );
      },
    );
  }
}

class AsyncValueBuilderWithCrossfade<T> extends ConsumerWidget {
  const AsyncValueBuilderWithCrossfade({
    Key? key,
    required this.value,
    required this.data,
    this.duration = const Duration(milliseconds: 200),
    this.loadingBuilder,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Duration duration;
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (value.hasError) {
      return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: value.isLoading
          ? _LoadingBuilder(builder: loadingBuilder)
          : data(value.requireValue),
    );
  }
}

class _LoadingBuilder extends StatelessWidget {
  const _LoadingBuilder({
    this.builder,
  });

  final WidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    if (builder == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return builder!(context);
  }
}

class _ErrorBuilder extends StatelessWidget {
  const _ErrorBuilder({
    required this.error,
    required this.stackTrace,
    this.builder,
  });

  final Object error;
  final StackTrace stackTrace;
  final WidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    if (builder == null) {
      return Center(
        child: SelectableText(
          error.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return builder!(context);
  }
}
