import 'package:flutter/material.dart';

import 'models/models.dart';

const Color primary = Colors.green;
const Color primaryDark = Color(0x704CAF4F);

const String externalSort01 = 'Trộn Run';
const String sort01Description = '...';
const String externalSort02 = 'Trộn tự nhiên';
const String sort02Description = '...';
// const String externalSort03 = 'Trộn đa lối cân bằng';
// const String sort03Description = '...';

//Algorithms
final List<SortingAlgorithm> sortingAlgorithmsList = [
  SortingAlgorithm(title: externalSort01, description: sort01Description),
  SortingAlgorithm(title: externalSort02, description: sort02Description),
  // SortingAlgorithm(title: externalSort03, description: sort01Description),
];
