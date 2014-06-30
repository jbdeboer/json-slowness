// Import BenchmarkBase class.
import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:streamy/streamy.dart';

import 'dart:js' as js;
import 'dart:convert' as convert;

String json;

var totalLen;
var count;

// Create a new benchmark by extending BenchmarkBase
class TemplateBenchmark extends BenchmarkBase {
  const TemplateBenchmark() : super("Template");

  static void main() {
    new TemplateBenchmark().report();
  }

  
  // The benchmark code.
  void yrun() {
    totalLen += js.context['JSON']['parse'].apply([json])["list"].length;
    count++;
  }

   void run() {
    totalLen += jsonParse(json)["list"].length;
    count++;
  }

  void zrun() {
    totalLen += convert.JSON.decode(json)["list"].length;
    count++;
  }

  // Not measured setup code executed prior to the benchmark runs.
  void setup() {
     totalLen = 0;
     count = 0;
    // Create a large JSON.
    var parts = ['{"list": ['];
    for (var i = 0; i < 100000; i++) {
      parts.add('  {"a": "b"},');
    }
    parts.add('  {"a": "last"} ] }');
    json = parts.join('\n');
    print("json length: ${json.length}");
  }

  // Not measures teardown code executed after the benchark runs.
  void teardown() {
    print("total Len: $totalLen, ran $count times");

  }
}

main() {
  // Run TemplateBenchmark
  TemplateBenchmark.main();
}