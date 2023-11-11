import 'package:flutter/material.dart';

class Node {
  int value;
  Node? left;
  Node? right;
  Node? parent;

  Node(this.value, {this.left, this.right, this.parent});
}

class BinarySearchTree {
  Node? root;

  BinarySearchTree() {
    root = null;
  }

  void insert(int value) {
    root = _insertRec(root, null, value);                                                                                                   // Передаємо null як батьківський вузол при вставці кореня
  }

  Node _insertRec(Node? root, Node? parent, int value) {
    if (root == null) {
      return Node(value, parent: parent);
    }

    if (value < root.value) {
      root.left = _insertRec(root.left, root, value);
    } else if (value > root.value) {
      root.right = _insertRec(root.right, root, value);
    }

    return root;
  }

  void preorderTraversal(List<int> result) {
    _preorderTraversalRec(root, result);
  }

  void _preorderTraversalRec(Node? root, List<int> result) {
    if (root != null) {
      result.add(root.value);
      _preorderTraversalRec(root.left, result);
      _preorderTraversalRec(root.right, result);
    }
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
      return 0;
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

  Node? getParent(int value) {
    return _getParentRec(root, null, value);
  }

  Node? _getParentRec(Node? root, Node? parent, int value) {
    if (root == null) {
      return null;
    }

    if (root.value == value) {
      return parent;
    }

    if (value < root.value) {
      return _getParentRec(root.left, root, value);
    } else {
      return _getParentRec(root.right, root, value);
    }
  }

  List<int> getChildren(int value) {
    List<int> children = [];
    Node? node = _findNode(root, value);

    if (node != null) {
      if (node.left != null) {
        children.add(node.left!.value);
      }

      if (node.right != null) {
        children.add(node.right!.value);
      }
    }

    return children;
  }

  Node? _findNode(Node? root, int value) {
    if (root == null) {
      return null;
    }

    if (root.value == value) {
      return root;
    }

    if (value < root.value) {
      return _findNode(root.left, value);
    } else {
      return _findNode(root.right, value);
    }
  }
}

class BinarySearchTreePage extends StatefulWidget {
  const BinarySearchTreePage({Key? key}) : super(key: key);

  @override
  State<BinarySearchTreePage> createState() => _BinarySearchTreePageState();
}

class _BinarySearchTreePageState extends State<BinarySearchTreePage> {
  BinarySearchTree binarySearchTree = BinarySearchTree();
  List<int> traversalResult = [];
  List<int> traversalResult2 = [];
  List<int> preorderTravelResult = [];

  TextEditingController valueController = TextEditingController();
  TextEditingController isContainsValue = TextEditingController();

  void insertValue() {
    int value = int.tryParse(valueController.text) ?? 0;
    binarySearchTree.insert(value);
    valueController.clear();
    setState(() {
      traversalResult.clear();
      traversalResult2.clear();
      //binarySearchTree.inorderTraversal(traversalResult);
      binarySearchTree.postorderTraversal(traversalResult2);
      binarySearchTree.preorderTraversal(preorderTravelResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212930),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            "Binary Search Tree Values:",
            style: TextStyle(color: Colors.white),
          ),


        Container(
          height: 200,
          width: 100,
        child: SingleChildScrollView(
              child: Column(
              children: [
                /*...preorderTravelResult.map((value) => Text('$value', style: TextStyle(color: Colors.white)),
               ),*/
              ...traversalResult2.map((value) => Text('$value', style: TextStyle(color: Colors.white)),
               ),
             ],
            ),
         ),
        ),



          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: valueController,
                  decoration: InputDecoration(
                    labelText: 'Value',
                    labelStyle: TextStyle(color: Colors.white), // Змінюємо колір тексту мітки на білий
                    hintStyle: TextStyle(color: Colors.white), // Змінюємо колір підказки на білий
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: insertValue,
                child: Text('Insert Value'),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: isContainsValue,
                  decoration: InputDecoration(
                    labelText: 'Value',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  int value = int.tryParse(isContainsValue.text) ?? 0;
                  bool isConsist = binarySearchTree.contains(value);
                  Node? parent = binarySearchTree.getParent(value);
                  List<int> children = binarySearchTree.getChildren(value);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Element Check'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Element $value is ${isConsist ? 'present' : 'not present'} in the tree', style: TextStyle(color: Colors.black)),
                            if (parent != null) Text('Parent: ${parent.value}', style: TextStyle(color: Colors.black)),
                            if (children.isNotEmpty) Text('Children: ${children.join(", ")}', style: TextStyle(color: Colors.black)),
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
                },
                child: Text('Element info'),
              ),
            ],
          ),



          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              int height = binarySearchTree.findHeight();
              setState(() {
                //traversalResult.clear();
                //traversalResult2.clear();
                preorderTravelResult.clear();
                //binarySearchTree.inorderTraversal(traversalResult);
                //binarySearchTree.postorderTraversal(traversalResult2);
                binarySearchTree.preorderTraversal(preorderTravelResult);
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
                          //Text('Values: ${traversalResult.join(", ")}', style: TextStyle(color: Colors.black)),
                         //Text('Values: ${traversalResult2.join(", ")}', style: TextStyle(color: Colors.black)),
                          Text('Values: ${preorderTravelResult.join(", ")}', style: TextStyle(color: Colors.black)),
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

              binarySearchTree.printTree();
              binarySearchTree.printTreeFormatted();
            },
            child: Text('Tree Info'),
          ),
          Container(
            height: 340,
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
            '$prefix${isLeft ? '├─────[' : '└─────['}',
            style: TextStyle(color: Colors.white, fontSize: 20 ),
          ),
          Text(
            '${node.value}',
            style: TextStyle(color: Colors.white, fontSize: 20),
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
