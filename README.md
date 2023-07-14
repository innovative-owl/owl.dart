# owl.dart

An opinionated widgets & utilities library for flutter.

## Features

#### Logger

#### Preferences

### Animations

#### AnimatedNumber

Implicitly animations a change to `number`

The `number` is formatted using the `numberFormat`. An animation only
displays when the formatted number changes.

```dart
AnimatedNumber(
  number: 420
);
```

### Async

#### AsyncValueBuilder

Useful for rendering a Widget that depends on an `AsyncValue<T>`.
Handles default Error and Loading states with a `loadingBuilder` for custom loading widgets.

```dart
final asyncValue = ref.watch(someFutureOrStreamProvider);
return AsyncValueBuilder<T>(
  value: scheduleNotifier,
  builder: (T data) {
    return Widget();
  },
);
```

#### ItemListBuilder

Useful for rendering a `ListView.builder()` that depends on an `AsyncValue<List<T>>`.
Handles default Error and Loading states with a `loadingBuilder` for custom loading widgets.

```dart
final asyncValue = ref.watch(someFutureOrStreamProvider);
return ItemListBuilder<T>(
  data: asyncValue,
  itemBuilder: (BuildContext context, T item, int index) {
    return ListItem();
  },
);
```

### Responsive

#### ResponsiveCenter

Reusable widget for showing a child with a maximum content width constraint.
If available width is larger than the maximum width, the child will be
centered.
If available width is smaller than the maximum width, the child use all the
available width.

```dart
ResponsiveCenter(
  maxContentWidth: 512,
  child: Dialog();
);
```

#### ResponsiveTwoColumnLayout

Responsive layout that shows two child widgets side by side if there is
enough space, or vertically stacked if there is not enough space.

```dart
ResponsiveTwoColumnLayout(
  startContent: Container(),
  endContent: Container(),
);
```

### General

#### Clickable

A combination of `GestureDetector.onTap` and `Inkwell`.
Used for cross-platfom clickables

```dart

```

#### Unfocus

Implements the 'unfocus on background tap' behavior for its child.
This example uses `MaterialApp.builder` to implement the 'unfocus onbackground tap' behavior app-wide.

````dart
MaterialApp(
  home: Container(),
  builder: (_, child) => Unfocus(child: child),
);

#### ConditionalParentWidget

Conditionally wrap a subtree with a parent widget without breaking the code tree.

`condition`: the condition depending on which the subtree `child` is wrapped with the parent.
`child`: The subtree that should always be build.
`conditionalBuilder`: builds the parent with the subtree `child`.

```dart
return ConditionalParentWidget(
  condition: shouldIncludeParent,
  child: Widget1(
    child: Widget2(
      child: Widget3(),
    ),
  ),
  conditionalBuilder: (Widget child) => SomeParentWidget(child: child),
);
````
