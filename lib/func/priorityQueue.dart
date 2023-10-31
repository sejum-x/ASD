import 'dart:math';
import 'dart:core';

class Element {
  int val;
  int priority;

  Element(this.val, this.priority);
}

class PriorityQueue {
  List<Element> elements = [];

  void enqueue(Element element) {
    elements.add(element);
    elements.sort((a, b) => a.priority.compareTo(b.priority));
  }

  Element dequeue() {
    if (isEmpty()) {
      throw Exception('Queue is empty');
    }
    return elements.removeAt(0);
  }

  bool isEmpty() {
    return elements.isEmpty;
  }

  int size() {
    return elements.length;
  }
}
