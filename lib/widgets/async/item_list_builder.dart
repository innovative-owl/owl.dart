import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owl/widgets/async/typedefs.dart';

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
    this.errorBuilder,
    this.physics,
    this.shrinkWrap = true,
    this.gridDelegate,
  });

  /// The data that this builder is currently representing.
  final AsyncValue<List<T>> data;

  /// The builder that will be called for every item in [data].
  final ItemWidgetBuilder<T> itemBuilder;

  /// The builder that will be called when [data] is loading.
  final OwlLoadingBuilder? loadingBuilder;

  /// The builder that will be called when [data] has an error.
  final OwlErrorBuilder? errorBuilder;

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
