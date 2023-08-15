import 'package:flutter/material.dart';

typedef OwlLoadingBuilder = Widget Function(BuildContext context);

typedef OwlErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
  StackTrace stackTrace,
);
