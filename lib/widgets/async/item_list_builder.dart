import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ItemWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);

class ItemListBuilder<T> extends StatelessWidget {
  const ItemListBuilder({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.loadingBuilder,
    this.physics,
    this.shrinkWrap = true,
    this.gridDelegate,
  });

  /// The data that this builder is currently representing.
  final AsyncValue<List<T>> data;

  /// The builder that will be called for every item in [data].
  final ItemWidgetBuilder<T> itemBuilder;

  /// The builder that will be called when [data] is loading.
  final WidgetBuilder? loadingBuilder;

  /// The physics of the scrollable widget.
  final ScrollPhysics? physics;

  /// Whether the scrollable widget should shrink-wrap its contents.
  final bool shrinkWrap;

  /// The grid delegate to use for grid views.
  /// If null, a list view will be used instead.
  final SliverGridDelegate? gridDelegate;

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (value) {
        if (gridDelegate != null) {
          return GridView.builder(
            shrinkWrap: shrinkWrap,
            physics: physics,
            itemCount: value.length,
            gridDelegate: gridDelegate!,
            itemBuilder: (context, index) {
              final item = value[index];
              return itemBuilder(context, item, index);
            },
          );
        }

        return ListView.builder(
          physics: physics,
          shrinkWrap: shrinkWrap,
          itemCount: value.length,
          itemBuilder: (context, index) {
            return itemBuilder(context, value[index], index);
          },
        );
      },
      error: (e, st) {
        // log.e(st);
        return _ErrorBuilder(
          error: e,
          stackTrace: st,
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

/// These are copied from AsyncValueBuilder, but they might change in the future
/// to use shimmer or something else.

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
  });

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SelectableText(
        error.toString(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
