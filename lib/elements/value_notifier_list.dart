import 'package:flutter/cupertino.dart';

class ValueNotifierList<T> extends ValueNotifier<List<T>> {
  ValueNotifierList(super.value);

  void add(T valueToAdd) {
    value = [...value, valueToAdd];
  }

  void remove(T valueToRemove) {
    value = value
        .where(
          (element) => element != valueToRemove,
        )
        .toList();
  }

  void updateAtIndex(int index, T newValue) {
    if (index >= 0 && index < value.length) {
      value[index] = newValue;
      notifyListeners(); // Notify listeners after updating the value
    } else {
      throw RangeError(
          'Index $index is out of bounds for List of length ${value.length}');
    }
  }
}
