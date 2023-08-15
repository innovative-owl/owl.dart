import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owl/widgets/async/typedefs.dart';

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
  final OwlLoadingBuilder? loadingBuilder;
  final OwlErrorBuilder? errorBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: (data) => builder(data),
      error: (e, st) {
        if (errorBuilder != null) {
          return errorBuilder!(
            context,
            e,
            st,
          );
        }
        return Center(
          child: SelectableText(
            e.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
      loading: () {
        return loadingBuilder?.call(context) ??
            const Center(child: CircularProgressIndicator());
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
    this.errorBuilder,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Duration duration;
  final OwlLoadingBuilder? loadingBuilder;
  final OwlErrorBuilder? errorBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (value.hasError) {
      if (errorBuilder != null) {
        return errorBuilder!(
          context,
          value.error!,
          value.stackTrace!,
        );
      }
      return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: value.isLoading
          ? loadingBuilder?.call(context) ??
              const Center(child: CircularProgressIndicator())
          : data(value.requireValue),
    );
  }
}
