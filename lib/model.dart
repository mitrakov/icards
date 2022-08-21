// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:math';

import 'package:scoped_model/scoped_model.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

class MyModel extends Model {
  final List<Tuple2<String, String>> _data = List.empty(growable: true);
  List<Tuple2<String, String>> get data => _data;

  void load() async {
    final response = await http.get(Uri.parse("http://mitrakoff.com:2000/spanish.txt"));      // TODO
    if (response.statusCode == 200) {
      final body = response.body;
      final lines = body.split("\n");
      for (final line in lines) {
        final tokens = line.split("|");
        if (tokens.length > 2) {
          final token1 = tokens[1].trim();
          final token2 = tokens[2].trim();
          if (token1.isNotEmpty && token2.isNotEmpty) {
            if (!token1.contains("---") && !token2.contains("---")) {
              if (token2 != "RUS") {                                            // TODO
                _data.add(Tuple2(token1, token2));
              }
            }
          }
        }
      }
      _data.shuffle(Random(DateTime.now().millisecondsSinceEpoch));
      notifyListeners();
    } else throw Exception("Cannot load file spanish.txt");
  }
}
