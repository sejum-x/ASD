import 'package:flutter/material.dart';
import 'dart:math';

class Element {
  int val;
  int priority;

  Element(this.val, this.priority);
}

class PriorityQueuePage extends StatefulWidget {
  const PriorityQueuePage({Key? key}) : super(key: key);

  @override
  State<PriorityQueuePage> createState() => _PriorityQueuePage();
}

class _PriorityQueuePage extends State<PriorityQueuePage> {
  PriorityQueue priorityQueue = PriorityQueue();
  PriorityQueue randPriorityQueue = PriorityQueue();
  String result = '';
  TextEditingController valController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController randPQsize = TextEditingController();
  TextEditingController randPQmaxPrio = TextEditingController();
  TextEditingController randPQmaxVal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212930),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //output
                Text(
                  "Elements in Priority Queue:",
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  height: 230,
                  width: 170,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: priorityQueue.elements
                        .map((element) => Text(
                        'Value: ${element.val}, Priority: ${element.priority}',
                        style: TextStyle(color: Colors.white)))
                        .toList(),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),

          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                  child: TextField(
                    controller: valController,
                    decoration: InputDecoration(
                      labelText: 'Value',
                      labelStyle: TextStyle(color: Colors.white), // Змінюємо колір тексту мітки на білий
                      hintStyle: TextStyle(color: Colors.white), // Змінюємо колір підказки на білий
                    ),
                    style: TextStyle(color: Colors.white), // Змінюємо колір тексту введення на білий
                  )

              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: priorityController,
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                    style: TextStyle(color: Colors.white),

                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              // enqueue
              ElevatedButton(
                onPressed: () {
                  int val = int.parse(valController.text);
                  int priority = int.parse(priorityController.text);
                  Element newElement = Element(val, priority);
                  priorityQueue.enqueue(newElement);
                  setState(() {
                    valController.clear();
                    priorityController.clear();
                  });
                },
                child: Text('Enqueue'),
              ),

              // dequeue
              SizedBox(width: 16), //
              ElevatedButton(
                onPressed: () {
                  Element dequeuedElement = priorityQueue.dequeue();
                  setState(() {
                    result = 'Dequeued: Value: ${dequeuedElement.val}, Priority: ${dequeuedElement.priority}';
                  });
                },
                child: Text('Dequeue'),
              ),

              // isempty bt
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  bool isEmpty = priorityQueue.isEmpty();
                  setState(() {
                    result = 'Is Empty: $isEmpty';
                  });
                },
                child: Text('Is Empty'),
              ),

              //get info bt
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  int queueSize = priorityQueue.size();
                  Element minElement = priorityQueue.findMin();
                  Element maxElement = priorityQueue.findMax();
                  Element thirdFromFront = priorityQueue.getThirdFromFront();
                  Element secondFromEnd = priorityQueue.getSecondFromEnd();
                  Element elementBeforeMin = priorityQueue.getElementBeforeMin();
                  Element elementAfterMax = priorityQueue.getElementAfterMax();
                  setState(() {
                    result = 'Queue Size: $queueSize \nMin: ${minElement.val}\nMax: ${maxElement.val} \nBefore Min: ${elementBeforeMin.val} \nAfters Max: ${elementAfterMax.val} \n3rd from front: ${thirdFromFront.val} \n2nd from end: ${secondFromEnd.val}';
                  });
                },
                child: Text('Queue Info'),
              ),

              //clear bt
              SizedBox(width: 16),
              ElevatedButton(
                  onPressed: () {
                    priorityQueue.clear();

                    setState(() {
                      result = 'Queue cleared';
                    });
                  },
                  child: Text('Clear')),
            ],
          ),

          // get data for rand
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: randPQsize,
                  decoration: InputDecoration(labelText: 'Size',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),

                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: randPQmaxPrio,
                  decoration: InputDecoration(labelText: 'Max priority',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),

                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: randPQmaxVal,
                  decoration: InputDecoration(labelText: 'Max value',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),

                ),
              ),
              SizedBox(width: 20),
            ],
          ),

          // rand + merge bt
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  randPriorityQueue.generateRandomQueue( int.parse(randPQsize.text), int.parse(randPQmaxPrio.text), int.parse(randPQmaxVal.text));
                  setState(() {
                    result = 'Random queue generated';
                  });
                },
                child: Text('Generate rand'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  priorityQueue.merge(randPriorityQueue);
                  setState(() {
                    result = 'Merged';
                  });
                },
                child: Text('Merge'),
              ),
            ],
          ),

          //search position
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(labelText: 'Search Value',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),

                ),
              ),
              ElevatedButton(
                onPressed: () {
                  int searchValue = int.parse(searchController.text);
                  int position = priorityQueue.findPosition(searchValue);
                  setState(() {
                    result = 'Position of $searchValue: $position';
                  });
                },
                child: Text('Search Position'),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),

          // output
          Text(
            result,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
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
    int count = 0;
    for (var element in elements) {
      count++;
    }
    return count;
  }

  Element findMin() {
    if (isEmpty()) {
      throw Exception('Queue is empty');
    }
    Element minElement = elements[0];
    for (var element in elements) {
      if (element.val < minElement.val) {
        minElement = element;
      }
    }
    return minElement;
  }

  Element findMax() {
    if (isEmpty()) {
      throw Exception('Queue is empty');
    }
    Element maxElement = elements[0];
    for (var element in elements) {
      if (element.val > maxElement.val) {
        maxElement = element;
      }
    }
    return maxElement;
  }


  Element getThirdFromFront() {
    if (elements.length >= 3) {
      return elements[2];
    }
    throw Exception('Not enough elements in the queue');
  }

  Element getSecondFromEnd() {
    if (elements.length >= 2) {
      return elements[elements.length - 2];
    }
    throw Exception('Not enough elements in the queue');
  }

  Element getElementBeforeMin() {
    if (isEmpty()) {
      throw Exception('Queue is empty');
    }
    int minVal = findMin().val;
    int index = elements.indexWhere((element) => element.val == minVal);
    if (index > 0) {
      return elements[index - 1];
    }
    throw Exception('No element before the minimum element');
  }

  Element getElementAfterMax() {
    if (isEmpty()) {
      throw Exception('Queue is empty');
    }
    int maxVal = findMax().val;
    int index = elements.indexWhere((element) => element.val == maxVal);
    if (index < elements.length - 1) {
      return elements[index + 1];
    }
    throw Exception('No element after the maximum element');
  }

  int findPosition(int searchValue) {
    for (int i = 0; i < elements.length; i++) {
      if (elements[i].val == searchValue) {
        return i;
      }
    }
    return -1;
  }

  List<Element> getElementsByPriority(int targetPriority) {
    return elements.where((element) => element.priority == targetPriority).toList();
  }

    void merge(PriorityQueue otherQueue) {
      List<Element> mergedElements = [];

      int i = 0;
      int j = 0;

      while (i < elements.length && j < otherQueue.elements.length) {
        if (elements[i].priority < otherQueue.elements[j].priority) {
          mergedElements.add(elements[i]);
          i++;
        } else {
          mergedElements.add(otherQueue.elements[j]);
          j++;
        }
      }

      while (i < elements.length) {
        mergedElements.add(elements[i]);
        i++;
      }

      while (j < otherQueue.elements.length) {
        mergedElements.add(otherQueue.elements[j]);
        j++;
      }

      elements = mergedElements;
    }


  void generateRandomQueue(int size, int maxPriority, int maxValue) {
    elements.clear();

    final random = Random();

    for (int i = 0; i < size; i++) {
      int val = random.nextInt(maxValue + 1);
      int priority = random.nextInt(maxPriority + 1);

      Element element = Element(val, priority);

      enqueue(element);
    }
  }
  void clear() {
    elements.clear();
  }
}
