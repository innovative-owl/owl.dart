import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:owl/hooks/use_debounce.dart';

class SimpleAutoSaveTextField extends HookWidget {
  const SimpleAutoSaveTextField({
    super.key,
    required this.controller,
    required this.onSave,
    this.duration = const Duration(seconds: 1),
    this.onFocusChanged,
    this.style,
    this.decoration,
    this.focusNode,
    this.maxLines,
    this.maxLength,
  });

  final TextEditingController controller;
  final void Function(String) onSave;
  final Duration duration;
  final void Function(bool)? onFocusChanged;
  final TextStyle? style;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final mFocusNode = focusNode ?? useFocusNode();
    useListenableSelector(
      mFocusNode,
      () => onFocusChanged?.call(mFocusNode.hasFocus),
    );

    useDebounce(
      () => onSave(controller.text),
      duration,
      [controller.text],
    );
    useListenable(controller);

    return TextField(
      focusNode: mFocusNode,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      style: style,
      decoration: decoration,
    );
  }
}
