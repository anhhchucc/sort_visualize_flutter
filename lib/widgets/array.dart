import 'package:flutter/material.dart';

import '../constants.dart';

class ArrWidget extends StatelessWidget {
  const ArrWidget({
    Key? key,
    required this.numbers,
    required this.activeBorder,
    required this.activeBgL,
    required this.activeBgR,
  }) : super(key: key);
  final List<int> numbers;
  final int activeBorder, activeBgL, activeBgR;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: size.width ~/ 70,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1,
        mainAxisExtent: 30,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: numbers.length,
      itemBuilder: (context, index) => Container(
        //width: 30,
        decoration: BoxDecoration(
          color: (index >= activeBgL && index <= activeBgR)
              ? const Color(0xFF2EEA8F)
              : Colors.white,
          border: Border.all(
            width: 2,
            color: (index == activeBorder) ? Colors.red : Color(0xFF16AAFF),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            numbers[index].toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class SortingAlgorithmsList extends StatefulWidget {
  final bool isDisabled;
  final Function(String) onTap;

  const SortingAlgorithmsList({
    Key? key,
    this.isDisabled = false,
    required this.onTap,
  }) : super(key: key);
  @override
  _SortingAlgorithmsListState createState() => _SortingAlgorithmsListState();
}

class _SortingAlgorithmsListState extends State<SortingAlgorithmsList> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: sortingAlgorithmsList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if (!widget.isDisabled) {
              setState(() {
                selected = index;
              });
              widget.onTap(sortingAlgorithmsList[selected].title);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: (selected == index) ? primary : Colors.grey,
              //borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text(
                sortingAlgorithmsList[index].title,
                style: TextStyle(
                  fontSize: 14,
                  color: selected == index ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
