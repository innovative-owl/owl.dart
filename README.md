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

#### ResponsiveTwoColumnLayout

### General

#### Clickable

#### Unfocus

#### ConditionalParentWidget
