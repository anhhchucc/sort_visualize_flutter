class SortingAlgorithm {
  String title;
  String description;
  SortingAlgorithm({
    required this.title,
    this.description = '',
  });
}

class Array {
  List<int> numbers;
  int activeBorder;
  //int activeBorderR;
  int activeBgL;
  int activeBgR;
  Array({
    required this.numbers,
    this.activeBgL = -1,
    this.activeBgR = -1,
    this.activeBorder = -1,
    //this.activeBorderR = -1,
  });
}
