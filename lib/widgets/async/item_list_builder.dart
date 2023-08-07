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
  ///
  /// Defaults to null, if set to a grid delegate - the item builder turns into a grid.
  ///
    this.gridDelegate,
  });

  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;
  final WidgetBuilder? loadingBuilder;

  final ScrollPhysics? physics;

  final bool shrinkWrap;
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
            gridDelegate: gridDelegate,
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
      child: Text(
        error.toString(),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
