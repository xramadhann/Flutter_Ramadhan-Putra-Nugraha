import 'dart:io';

void main() {
  stdout.write("Masukkan list data: ");
  String input = stdin.readLineSync()!;
  List<String> inputData = input.split(',');

  Map<String, int> frequencyMap = calculateFrequency(inputData);

  String frekuensiOutput = frequencyMap.entries.map((entry) {
    return "${entry.key}: ${entry.value}";
  }).join(', ');

  print("Output: $frekuensiOutput");
}

Map<String, int> calculateFrequency(List<String> data) {
  Map<String, int> frekuensiMap = {};

  for (String item in data) {
    if (frekuensiMap.containsKey(item)) {
      frekuensiMap[item] = frekuensiMap[item]! + 1;
    } else {
      frekuensiMap[item] = 1;
    }
  }

  return frekuensiMap;
}
