import 'package:flutter/material.dart';

class Node {
  int value;
  Node? left;
  Node? right;

  Node(this.value, {this.left, this.right});
}

class BinarySearchTree {
  Node? root;

  BinarySearchTree() {
    root = null; // Initialize root to null in the constructor
  }

  void insert(int value) {
    root = _insertRec(root, value);
  }

  Node _insertRec(Node? root, int value) {
    if (root == null) {
      return Node(value);
    }

    if (value < root.value) {
      root.left = _insertRec(root.left, value);
    } else if (value > root.value) {
      root.right = _insertRec(root.right, value);
    }

    return root;
  }

  void inorderTraversal(List<int> result) {
    _inorderTraversalRec(root, result);
  }

  void _inorderTraversalRec(Node? root, List<int> result) {
    if (root != null) {
      _inorderTraversalRec(root.left, result);
      result.add(root.value);
      _inorderTraversalRec(root.right, result);
    }
  }

  void postorderTraversal(List<int> result) {
    _postorderTraversalRec(root, result);
  }

  void _postorderTraversalRec(Node? root, List<int> result) {
    if (root != null) {
      _postorderTraversalRec(root.left, result);
      _postorderTraversalRec(root.right, result);
      result.add(root.value);
    }
  }

  bool contains(int value) {
    return _containsRec(root, value);
  }

  bool _containsRec(Node? root, int value) {
    if (root == null) {
      return false;
    }

    if (root.value == value) {
      return true;
    }

    if (value < root.value) {
      return _containsRec(root.left, value);
    } else {
      return _containsRec(root.right, value);
    }
  }

  int findHeight() {
    return _findHeightRec(root);
  }

  int _findHeightRec(Node? root) {
    if (root == null) {
      return -1;
    }

    int leftHeight = _findHeightRec(root.left);
    int rightHeight = _findHeightRec(root.right);

    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
  }

  void printTree() {
    printNode(root, '', true);
  }

  void printNode(Node? node, String prefix, bool isLeft) {
    if (node != null) {
      print('$prefix${isLeft ? '├─' : '└─'}┐${node.value}');
      if (node.left != null || node.right != null) {
        if (node.left != null && node.right != null) {
          printNode(node.left, '$prefix${isLeft ? '│ ' : '  '}', true);
          printNode(node.right, '$prefix${isLeft ? '│ ' : '  '}', false);
        } else if (node.left != null) {
          printNode(node.left, '$prefix${isLeft ? '│ ' : '  '}', true);
        } else {
          printNode(node.right, '$prefix${isLeft ? '│ ' : '  '}', false);
        }
      }
    }
  }

  /*void printTreeFormatted() {
    String formattedTree = _printTreeFormattedRec(root, 0);
    print(formattedTree);
  }

  String _printTreeFormattedRec(Node? root, int indent) {
    if (root == null) {
      return '';
    }

    String result = '';
    result += _printTreeFormattedRec(root.right, indent + 4);

    result += ' ' * indent + root.value.toString() + '\n';

    result += _printTreeFormattedRec(root.left, indent + 4);

    return result;
  }*/

  void printTreeFormatted() {
    String formattedTree = _printTreeFormattedRec(root, 0);
    print(formattedTree);
  }

  String _printTreeFormattedRec(Node? root, int indent) {
    if (root == null) {
      return '';
    }

    String result = '';
    result += _printTreeFormattedRec(root.right, indent + 4);

    for (int i = 0; i < indent; i++) {
      result += ' ';
    }

    result += root.value.toString() + '\n';

    result += _printTreeFormattedRec(root.left, indent + 4);

    return result;
  }


}

class BinarySearchTreePage extends StatefulWidget {
  const BinarySearchTreePage({Key? key}) : super(key: key);

  @override
  State<BinarySearchTreePage> createState() => _BinarySearchTreePageState();
}

// Ваш BinarySearchTreePage

class _BinarySearchTreePageState extends State<BinarySearchTreePage> {
  BinarySearchTree binarySearchTree = BinarySearchTree();
  List<int> traversalResult = [];
  List<int> traversalResult2 = [];

  TextEditingController valueController = TextEditingController();

  void insertValue() {
    int value = int.tryParse(valueController.text) ?? 0;
    binarySearchTree.insert(value);
    valueController.clear();
    setState(() {
      traversalResult.clear();
      traversalResult2.clear();
      binarySearchTree.inorderTraversal(traversalResult);
      binarySearchTree.postorderTraversal(traversalResult2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212930),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff012430),
            child: Text(
              "Binary Search Tree",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Binary Search Tree Values:",
            style: TextStyle(color: Colors.white),
          ),
          Column(
            children: [
              ...traversalResult.map((value) => Text('$value', style: TextStyle(color: Colors.white)),
              ),/*
              ...traversalResult2.map((value) => Text('$value', style: TextStyle(color: Colors.white)),
              ),*/
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: valueController,
                  decoration: InputDecoration(labelText: 'Value'),
                ),
              ),
              ElevatedButton(
                onPressed: insertValue,
                child: Text('Insert Value'),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              int height = binarySearchTree.findHeight();
              setState(() {
                traversalResult.clear();
                traversalResult2.clear();
                binarySearchTree.inorderTraversal(traversalResult);
                binarySearchTree.postorderTraversal(traversalResult2);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Binary Search Tree Info'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Height: $height', style: TextStyle(color: Colors.black)),
                          Text('Values: ${traversalResult.join(", ")}', style: TextStyle(color: Colors.black)),
                          Text('Values: ${traversalResult2.join(", ")}', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              });

              // Додайте виклик printTree() для виводу дерева
              binarySearchTree.printTree();
              binarySearchTree.printTreeFormatted();
            },
            child: Text('Tree Info'),
          ),
          Container(
            height: 200, // Set a fixed height for the container
            child: SingleChildScrollView(
              child: buildTreeWidget(binarySearchTree.root, '', true),
            ),
          ),

        ],
      ),
    );
  }
}


Widget buildTreeWidget(Node? node, String prefix, bool isLeft) {
  if (node == null) {
    return SizedBox.shrink();
  }

  return Column(
    children: [
      Row(
        children: [
          Text(
            '$prefix${isLeft ? '├─----' : '└─----'}',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '${node.value}',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      SizedBox(height: 8), // Adjust the spacing as needed

      // Recursively build the left and right subtrees
      buildTreeWidget(node.left, '$prefix${isLeft ? '│        ' : '          '}', true),
      buildTreeWidget(node.right, '$prefix${isLeft ? '│        ' : '          '}', false),
    ],
  );
}
