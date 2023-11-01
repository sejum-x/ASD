import 'package:flutter/material.dart';

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
  String result = '';
  TextEditingController valController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController searchController = TextEditingController();

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
                Text(
                  "Elements in Priority Queue:",
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  height: 200,
                  width: 170,// Set a fixed height for the container
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(), // Allow scrolling
                    children: priorityQueue.elements
                        .map((element) => Text(
                        'Value: ${element.val}, Priority: ${element.priority}',
                        style: TextStyle(color: Colors.white)))
                        .toList(),
                  ),
                ),

                SizedBox(height: 20),
                // Додатковий контент, який буде прокручуватися разом із списком
              ],
            ),
          ),



          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: valController,
                  decoration: InputDecoration(labelText: 'Value'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: priorityController,
                  decoration: InputDecoration(labelText: 'Priority'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Використовуємо SizedBox для додавання простору між кнопками
            children: [
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
              SizedBox(width: 16), // Додано простір шириною 16 між кнопками
              ElevatedButton(
                onPressed: () {
                  Element dequeuedElement = priorityQueue.dequeue();
                  setState(() {
                    result = 'Dequeued: Value: ${dequeuedElement.val}, Priority: ${dequeuedElement.priority}';
                  });
                },
                child: Text('Dequeue'),
              ),
              SizedBox(width: 16), // Додано простір шириною 16 між кнопками
              ElevatedButton(
                onPressed: () {
                  bool isEmpty = priorityQueue.isEmpty();
                  setState(() {
                    result = 'Is Empty: $isEmpty';
                  });
                },
                child: Text('Is Empty'),
              ),
              SizedBox(width: 16), // Додано простір шириною 16 між кнопками
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
                    result = 'Queue Size: $queueSize \nMin: ${minElement.val}\nMax: ${maxElement.val} \nbefore Min: ${elementBeforeMin.val} \nafters Max: ${elementAfterMax.val} \n3rd from front: ${thirdFromFront.val} \n2nd from end: ${secondFromEnd.val}';
                  });
                },
                child: Text('Queue Info'),
              ),
            ],
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(labelText: 'Search Value'),
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
            ],
          ),
          SizedBox(height: 20),
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

  // int size() {
  //   return elements.length;
  // }

  int size() {
    int count = 0;
    for (var element in elements) {
      count++;
    }
    return count;
  }


  // Element findMin() {
  //   if (isEmpty()) {
  //     throw Exception('Queue is empty');
  //   }
  //   return elements.first;
  // }

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



  /*Element findMax() {
    if (isEmpty()) {
      throw Exception('Queue is empty');
    }
    return elements.last;
  }*/

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
    return -1; // Element not found
  }

  List<Element> getElementsByPriority(int targetPriority) {
    return elements.where((element) => element.priority == targetPriority).toList();
  }
}
