import 'package:flutter/material.dart';

class BM extends StatefulWidget {
  const BM({Key? key}) : super(key: key);

  @override
  State<BM> createState() => _BMState();
}

class _BMState extends State<BM> {
  final TextEditingController _patternController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final BoyerMoore _bm = BoyerMoore();
  List<int> _indices = [];

  void _searchPattern() {
    String pattern = _patternController.text;
    String text = _textController.text;

    setState(() {
      _indices = _bm.searchPattern(pattern, text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boyer-Moore Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _patternController,
              decoration: InputDecoration(
                labelText: 'Pattern',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _searchPattern,
              child: Text('Search'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: _indices.isEmpty
                  ? Center(
                child: Text(
                  'No matches found',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
                  : ListView.builder(
                itemCount: _indices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Index: ${_indices[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoyerMoore {
  List<int> searchPattern(String pattern, String text) {
    List<int> indices = [];

    int patternLength = pattern.length;
    int textLength = text.length;

    Map<String, int> lastOccurrence = {};
    for (int i = 0; i < patternLength; i++) {
      lastOccurrence[pattern[i]] = i;
    }

    int i = patternLength - 1;
    int j = patternLength - 1;

    while (i < textLength) {
      int k = i;
      j = patternLength - 1;

      while (j >= 0 && (text[k] == pattern[j] || pattern[j] == '?')) {
        k--;
        j--;
      }

      if (j < 0) {
        indices.add(k + 1);
        i += patternLength;
      } else {
        int lastOccur = lastOccurrence[text[i]] ?? -1;
        int shift = j - lastOccur;
        if (pattern[j] == '?' || text[k] == '?') {
          shift = 1; // Якщо '?' в шаблоні або тексті, робимо зсув на одиницю
        }
        i += shift > 0 ? shift : 1;
      }
    }

    return indices;
  }
}


