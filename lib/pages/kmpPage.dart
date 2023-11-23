import 'package:flutter/material.dart';

class KMP extends StatefulWidget {
  const KMP({Key? key}) : super(key: key);

  @override
  State<KMP> createState() => _KMPState();
}

class _KMPState extends State<KMP> {
  final TextEditingController _patternController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final KnuthMorrisPratt _kmp = KnuthMorrisPratt();
  List<int> _indices = [];

  void _searchPattern() {
    String pattern = _patternController.text;
    String text = _textController.text;

    setState(() {
      _indices = _kmp.searchPattern(pattern, text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc6c3c1),
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

class KnuthMorrisPratt {
  List<int> searchPattern(String pattern, String text) {
    List<int> indices = [];

    int patternLength = pattern.length;
    int textLength = text.length;

    List<int> prefixTable = computePrefixTable(pattern);

    int i = 0; // індекс для тексту
    int j = 0; // індекс для шаблону

    while (i < textLength) {
      if (pattern[j] == text[i] || pattern[j] == '?') {
        i++;
        j++;
      }

      if (j == patternLength) {
        indices.add(i - j);
        j = prefixTable[j - 1];
      } else if (i < textLength && (pattern[j] != text[i] && pattern[j] != '?')) {
        if (j != 0) {
          j = prefixTable[j - 1];
        } else {
          i++;
        }
      }
    }

    return indices;
  }

  List<int> computePrefixTable(String pattern) {
    int length = pattern.length;
    List<int> prefixTable = List<int>.filled(length, 0);

    int j = 0;
    int i = 1;

    while (i < length) {
      if (pattern[i] == pattern[j] || pattern[i] == '?') {
        j++;
        prefixTable[i] = j;
        i++;
      } else {
        if (j != 0) {
          j = prefixTable[j - 1];
        } else {
          prefixTable[i] = j;
          i++;
        }
      }
    }

    return prefixTable;
  }
}
