void main() {
  List<List<int>> nestedList = [
    [1, 2],
    [3, 4],
    [5, 6],
  ];

  Map<int, List<int>> mapList = {};

  for (int i = 0; i < nestedList.length; i++) {
    mapList[i] = nestedList[i];
  }

  print("Nested List: $nestedList");
  print("Map dari Nested List: $mapList");
}
