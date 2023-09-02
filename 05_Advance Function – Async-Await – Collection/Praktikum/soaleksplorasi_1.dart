import 'dart:io';

void main() {
  stdout.write("Masukkan kata-kata: ");
  String input = stdin.readLineSync()!;
  List<String> inputList = input.split(',').map((item) => item.trim()).toList();

  List<String> uniqueList = removeDuplicates(inputList);

  String output = uniqueList.join(', ');

  print("Output Data: $output");
}

List<String> removeDuplicates(List<String> data) {
  Set<String> uniqueSet = Set<String>();
  List<String> uniqueList = [];

  for (String item in data) {
    if (!uniqueSet.contains(item)) {
      uniqueSet.add(item);
      uniqueList.add(item);
    }
  }

  return uniqueList;
}
