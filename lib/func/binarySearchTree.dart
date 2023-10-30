import 'dart:math';
import 'dart:core';

class Node {
  int value;
  Node? left;
  Node? right;

  Node(this.value, { this.left, this.right});
}

class BinarySearchTree {
  late Node root;

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

  void inorderTraversal() {
    _inorderTraversalRec(root);
  }

  void _inorderTraversalRec(Node? root) {
    if (root != null) {
      _inorderTraversalRec(root.left);
      print(root.value);
      _inorderTraversalRec(root.right);
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
}