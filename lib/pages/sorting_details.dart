import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/models.dart';
import '../widgets/array.dart';
import '../widgets/chart.dart';

class SortDetailsScreen extends StatefulWidget {
  const SortDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SortDetailsScreenState();
}

class SortDetailsScreenState extends State<SortDetailsScreen> {
  Array f = Array(numbers: []);
  Array f1 = Array(numbers: []);
  Array f2 = Array(numbers: []);
  Array f3 = Array(numbers: []);
  List<int> f1Key = [];
  List<int> f2Key = [];

  int m = 0;
  int initialN = 20;
  int n = 20;
  int currentDuration = 1000;

  int initialDuration = 10;

  final divisionDuration = 10;
  //late int currentDuration = 3000;

  String selectedAlgorithm = sortingAlgorithmsList[0].title;
  bool isSorting = false;
  // isSelectingDelay = false; // isCancelled = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    f.numbers = List<int>.generate(n, (i) => i + 1);
    shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('External Sort Algorithms'),
        elevation: 0,
        backgroundColor: Colors.teal,
        actions: [
          InkWell(
            onTap: () {
              if (!isSorting) {
                shuffle();
              }
            },
            child: Container(
              width: 100,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isSorting ? Colors.grey : Colors.green,
              ),
              child: Center(
                child: Text(
                  'Shuffle',
                  style: TextStyle(
                    fontSize: 14,
                    color: (isSorting ? Colors.black : Colors.white),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (!isSorting) {
                setState(() {
                  selectWhichSorting();
                  isSorting = true;
                });
              }
            },
            child: Container(
              width: 100,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(color: isSorting ? Colors.grey : Colors.green),
              child: Center(
                child: Text(
                  'Sort',
                  style: TextStyle(
                    fontSize: 14,
                    color: (isSorting ? Colors.black : Colors.white),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
                width: 400,
                child: SortingAlgorithmsList(
                  isDisabled: isSorting,
                  onTap: (selected) {
                    selectedAlgorithm = selected;
                  },
                ),
              ),
              ChartWidget(
                numbers: f.numbers,
                chartWidth: MediaQuery.of(context).size.width / (n * 2) > 50
                    ? 50
                    : MediaQuery.of(context).size.width / (n * 2),
                //activeElements: pointers,
                activeL: f.activeBgL,
                activeR: f.activeBgR,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 30,
                      thumbShape: SliderComponentShape.noOverlay,
                      overlayShape: SliderComponentShape.noOverlay,
                      valueIndicatorShape: SliderComponentShape.noOverlay,
                      trackShape: const RectangularSliderTrackShape(),
                      thumbColor: const Color(0xFFCDD1CC),
                      activeTrackColor: primary,
                      inactiveTrackColor: const Color(0x704CAF4F),
                      activeTickMarkColor: Colors.transparent,
                      inactiveTickMarkColor: Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.39,
                          child: Stack(
                            children: [
                              Slider(
                                value: initialDuration.toDouble(),
                                min: 0,
                                max: 100,
                                divisions: 50,
                                onChanged: (double value) {
                                  setState(
                                    () {
                                      initialDuration = value.round();
                                      currentDuration = (value * 50).round();
                                    },
                                  );
                                },
                              ),
                              Center(
                                child: Text(
                                    'Delay: ${currentDuration / 1000} second'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SizedBox(
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.39,
                          child: Stack(
                            children: [
                              Slider(
                                value: initialN.toDouble(),
                                min: 1,
                                max: 100,
                                //divisions: 50,
                                //label: (n).toString() + ' phan tu',
                                onChanged: isSorting
                                    ? null
                                    : (double value) {
                                        initialN = value.round();
                                        n = value.round();
                                        f.numbers.clear();
                                        f.numbers =
                                            List<int>.generate(n, (i) => i + 1);

                                        shuffle();
                                        setState(
                                          () {},
                                        );
                                      },
                              ),
                              Center(
                                child: Text('Element: ${n} '),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              m == 0
                  ? const SizedBox()
                  : Row(
                      children: [
                        const Text(
                          'M= ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          m.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
              const SizedBox(height: 16),
              const Text(
                'F0',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ArrWidget(
                numbers: f.numbers,
                activeBgL: f.activeBgL,
                activeBgR: f.activeBgR,
                activeBorder: f.activeBorder,
              ),
              const SizedBox(height: 20),
              f1.numbers.isNotEmpty
                  ? const Text(
                      'F1',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
              const SizedBox(height: 8),
              ArrWidget(
                numbers: f1.numbers,
                activeBgL: f1.activeBgL,
                activeBgR: f1.activeBgR,
                activeBorder: f1.activeBorder,
              ),
              const SizedBox(height: 16),
              f2.numbers.isNotEmpty
                  ? const Text(
                      'F2',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
              const SizedBox(height: 8),
              ArrWidget(
                numbers: f2.numbers,
                activeBgL: f2.activeBgL,
                activeBgR: f2.activeBgR,
                activeBorder: f2.activeBorder,
              ),
              const SizedBox(height: 16),
              f3.numbers.isNotEmpty
                  ? const Text(
                      'F0',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
              const SizedBox(height: 8),
              ArrWidget(
                numbers: f3.numbers,
                activeBgL: f3.activeBgL,
                activeBgR: f3.activeBgR,
                activeBorder: f3.activeBorder,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void selectWhichSorting() {
    switch (selectedAlgorithm) {
      case externalSort01:
        externalSort1();
        break;
      case externalSort02:
        externalSort2();
        break;
      default:
        break;
    }
  }

  void shuffle() {
    setState(() {
      f.numbers.shuffle();
    });
  }

  void finishedSorting() {
    setState(() {
      isSorting = false;
    });
  }

  void cancelledSorting() {
    setState(() {
      isSorting = false;
    });
  }

  void startSorting() {
    setState(() {
      isSorting = true;
      //isSelectingDelay = false;
    });
  }

  void externalSort1() async {
    startSorting();
    m = 1;

    while (m < n) {
      bool f1True = true;
      int j = 0;

      //-----------Chia-------------
      for (int i = 0; i < n; i++) {
        if (f.activeBgL == -1) {
          setState(() {
            f.activeBgL = i;
            f.activeBgR = i;
          });
        } else {
          setState(() {
            f.activeBgR = i;
          });
        }

        if (f1True) {
          setState(() {
            f1.numbers.add(f.numbers[i]);
            f1.activeBorder = f1.numbers.length - 1;
          });
        } else {
          setState(() {
            f2.numbers.add(f.numbers[i]);
            f2.activeBorder = f2.numbers.length - 1;
          });
        }

        await Future.delayed(Duration(milliseconds: currentDuration));
        j++;
        if (j == m) {
          setState(() {
            //activeBgF0.clear();
            f.activeBgL = -1;
            f.activeBgR = -1;
            f1.activeBorder = -1;
            f2.activeBorder = -1;
          });
          f1True = !f1True;
          j = 0;
        }
      }
      setState(() {
        f.activeBgL = -1;
        f.activeBgR = -1;
      });
      //if (!isSorting) break;
      //------------------Tron----------------
      int n1 = 0;
      int n2 = 0;
      int i = 0;

      while (f3.numbers.length < n) {
        if (!isSorting) break;
        if (n1 == 0 && n2 == 0) {
          setState(() {
            f1.activeBgL = i * m;
            f1.activeBgR = i * m + m - 1;
            f2.activeBgL = i * m;
            f2.activeBgR = i * m + m - 1;
          });
        }
        setState(() {
          f1.activeBorder = -1;
          f2.activeBorder = -1;
        });

        if (i * m + n1 == f1.numbers.length || n1 == m) {
          setState(() {
            f2.activeBorder = i * m + n2;
            f3.numbers.add(f2.numbers[i * m + n2]);
          });

          n2++;
        } else if (i * m + n2 == f2.numbers.length || n2 == m) {
          setState(() {
            f3.numbers.add(f1.numbers[i * m + n1]);
            f1.activeBorder = i * m + n1;
          });

          n1++;
        } else if (f1.numbers[i * m + n1] < f2.numbers[i * m + n2]) {
          setState(() {
            f3.numbers.add(f1.numbers[i * m + n1]);
            f1.activeBorder = i * m + n1;
          });
          n1++;
        } else {
          setState(() {
            f3.numbers.add(f2.numbers[i * m + n2]);
            f2.activeBorder = i * m + n2;
          });
          n2++;
        }
        if (n1 == m && n2 == m) {
          n1 = 0;
          n2 = 0;
          i++;
        }

        await Future.delayed(Duration(milliseconds: currentDuration));
      }

      await Future.delayed(Duration(milliseconds: currentDuration));
      setState(() {
        f.numbers = List.from(f3.numbers);
        f3.numbers.clear();
        f1.numbers.clear();
        f2.numbers.clear();
        f1.activeBorder = -1;
        f2.activeBorder = -1;
        f1.activeBgL = -1;
        f1.activeBgR = -1;
        f2.activeBgL = -1;
        f2.activeBgR = -1;
      });
      if (!isSorting) break;
      m *= 2;
    }
    finishedSorting();
    m = 0;
  }

  //-----------------------Tron tu nhien------------------------
  void externalSort2() async {
    startSorting();
    while (f1.numbers.length < f.numbers.length) {
      bool f1True = true;

      //-----------Chia-------------
      for (int i = 0; i < n; i++) {
        if (f.activeBgL == -1) {
          setState(() {
            f.activeBgL = i;
            f.activeBgR = i;
          });
        } else {
          setState(() {
            f.activeBgR = i;
          });
        }

        if (f1True) {
          setState(() {
            f1.numbers.add(f.numbers[i]);
            f1.activeBorder = f1.numbers.length - 1;
          });
        } else {
          setState(() {
            f2.numbers.add(f.numbers[i]);
            f2.activeBorder = f2.numbers.length - 1;
          });
        }
        if (f1.numbers.length == f.numbers.length) {
          setState(() {
            f.activeBgL = -1;
            f.activeBgR = -1;
          });
          break;
        }

        await Future.delayed(Duration(milliseconds: currentDuration));

        if (f.numbers.length > i + 1) {
          if (f.numbers[i] > f.numbers[i + 1]) {
            setState(() {
              f.activeBgL = -1;
              f.activeBgR = -1;
              f1.activeBorder = -1;
              f2.activeBorder = -1;
            });
            if (f1True) {
              f1Key.add(f1.numbers.length - 1);
            } else {
              f2Key.add(f2.numbers.length - 1);
            }
            f1True = !f1True;
          }
        } else {
          if (f1True) {
            f1Key.add(f1.numbers.length - 1);
          } else {
            f2Key.add(f2.numbers.length - 1);
          }
        }
      }
      if (f2.numbers.isEmpty) {
        setState(() {
          f1.numbers.clear();
        });
        break;
      }

      setState(() {
        f.activeBgL = -1;
        f.activeBgR = -1;
      });
      //------------------Tron----------------
      int n1 = 0;
      int n2 = 0;
      int iKey = 0;

      while (f3.numbers.length < n) {
        if (iKey < f1Key.length) {
          if (iKey == 0 ? true : (n1 - 1 == f1Key[iKey - 1])) {
            setState(() {
              f1.activeBgL = iKey == 0 ? 0 : f1Key[iKey - 1] + 1;
              f1.activeBgR = f1Key[iKey];
              if (iKey < f2Key.length) {
                f2.activeBgL = iKey == 0 ? 0 : f2Key[iKey - 1] + 1;
                f2.activeBgR = f2Key[iKey];
              }
            });
          }
        }

        setState(() {
          f1.activeBorder = -1;
          f2.activeBorder = -1;
        });

        if (n1 == f1.numbers.length || n1 > f1Key[iKey]) {
          setState(() {
            f2.activeBorder = n2;
            f3.numbers.add(f2.numbers[n2]);
          });
          n2++;
        } else if (n2 == f2.numbers.length || iKey > f2Key.length
            ? true
            : n2 > f2Key[iKey]) {
          setState(() {
            f3.numbers.add(f1.numbers[n1]);
            f1.activeBorder = n1;
          });
          n1++;
        } else if (f1.numbers[n1] < f2.numbers[n2]) {
          setState(() {
            f3.numbers.add(f1.numbers[n1]);
            f1.activeBorder = n1;
          });
          n1++;
        } else {
          setState(() {
            f3.numbers.add(f2.numbers[n2]);
            f2.activeBorder = n2;
          });
          n2++;
        }

        if (n1 > f1Key[iKey] &&
            (iKey < f2Key.length ? n2 > f2Key[iKey] : true)) {
          iKey++;
        }

        await Future.delayed(Duration(milliseconds: currentDuration));
      }

      await Future.delayed(Duration(milliseconds: currentDuration));

      setState(() {
        f.numbers = List.from(f3.numbers);
        f3.numbers.clear();
        f1.numbers.clear();
        f1Key.clear();
        f2.numbers.clear();
        f2Key.clear();
        f1.activeBorder = -1;
        f2.activeBorder = -1;
        f.activeBgL = -1;
        f.activeBgR = -1;
        f1.activeBgL = -1;
        f1.activeBgR = -1;
        f2.activeBgL = -1;
        f2.activeBgR = -1;
      });
      // m *= 2;
    }
    finishedSorting();
  }

  //Insertion Sort

}
