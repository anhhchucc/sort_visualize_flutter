import 'package:external_sort_visualize/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/sorting_details.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'External Algorithms',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: primary,
        primaryColorDark: primaryDark,
        canvasColor: Colors.transparent,
      ),
      home: const SortDetailsScreen(),
    );
  }
}
