import 'package:flutter/material.dart';

/// Responsive layout that shows two child widgets side by side if there is
/// enough space, or vertically stacked if there is not enough space.
class ResponsiveTwoColumnLayout extends StatelessWidget {
  const ResponsiveTwoColumnLayout({
    super.key,
    required this.startContent,
    required this.endContent,
    this.startFlex = 1,
    this.endFlex = 1,
    this.expandRow = false,
    this.breakpoint = 800.0,
    this.verticalSpacing = 0.0,
    this.horizontalSpacing = 0.0,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.columnCrossAxisAlignment = CrossAxisAlignment.stretch,
  });
  final Widget startContent;
  final Widget endContent;
  final int startFlex;
  final int endFlex;
  final bool expandRow;
  final double breakpoint;
  final double? verticalSpacing;
  final double? horizontalSpacing;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final CrossAxisAlignment columnCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint) {
          return Row(
            mainAxisAlignment: rowMainAxisAlignment,
            crossAxisAlignment: rowCrossAxisAlignment,
            children: [
              if (expandRow)
                Expanded(flex: startFlex, child: startContent)
              else
                Flexible(flex: startFlex, child: startContent),
              if (horizontalSpacing != null) SizedBox(width: horizontalSpacing),
              if (expandRow) Expanded(flex: endFlex, child: endContent) else Flexible(flex: endFlex, child: endContent),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: columnMainAxisAlignment,
            crossAxisAlignment: columnCrossAxisAlignment,
            children: [
              startContent,
              if (verticalSpacing != null)
                SizedBox(
                  height: verticalSpacing,
                ),
              endContent,
            ],
          );
        }
      },
    );
  }
}
