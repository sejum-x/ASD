import 'dart:math';
import 'dart:core';

class Element {
  int val;
  int priority;

  Element(this.val, this.priority);
}

class PriorityQueue {
  List<Element> _elements = [];

  void enqueue(Element element) {
    _elements.add(element);
    _elements.sort((a, b) => a.priority - b.priority);
  }

  Element dequeue() {
    if (isEmpty) {
      throw StateError('Queue is empty');
    }
    return _elements.removeAt(0);
  }

  bool get isEmpty => _elements.isEmpty;
  int get length => _elements.length;
  Element get minElement {
    if (isEmpty) {
      throw StateError('Queue is empty');
    }
    return _elements.first;
  }
  Element get maxElement {
    if (isEmpty) {
      throw StateError('Queue is empty');
    }
    return _elements.last;
  }
  Element get thirdElementFromStart {
    if (length < 3) {
      throw StateError('There are fewer than 3 elements in the queue');
    }
    return _elements[2];
  }
  Element get secondElementFromEnd {
    if (length < 2) {
      throw StateError('There are fewer than 2 elements in the queue');
    }
    return _elements[length - 2];
  }
  Element get elementBeforeMin {
    if (isEmpty) {
      throw StateError('Queue is empty');
    }
    final minIndex = _elements.indexOf(minElement);
    if (minIndex == 0) {
      throw StateError('Min element is the first element in the queue');
    }
    return _elements[minIndex - 1];
  }
  Element get elementAfterMax {
    if (isEmpty) {
      throw StateError('Queue is empty');
    }
    final maxIndex = _elements.indexOf(maxElement);
    if (maxIndex == length - 1) {
      throw StateError('Max element is the last element in the queue');
    }
    return _elements[maxIndex + 1];
  }

  int findPositionByValue(int value) {
    for (int i = 0; i < length; i++) {
      if (_elements[i].val == value) {
        return i;
      }
    }
    return -1; // Значення не знайдено у черзі
  }

  void mergeWith(PriorityQueue otherQueue) {
    _elements.addAll(otherQueue._elements);
    _elements.sort((a, b) => a.priority - b.priority);
  }
}