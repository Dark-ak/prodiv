import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:prodive/db/model.dart';
import 'package:prodive/widgets/Graph.dart';
import 'package:prodive/widgets/Setting.dart';
import "package:provider/provider.dart";
import "./widgets/Body.dart" as content;
import "./db/db.dart";

void main() {
  runApp(const MainApp());
}

class AppData extends ChangeNotifier {
  int timer = 25;
  int sBreak = 5;
  int lBreak = 15;
  int sesCount = 0;

  bool started = false;
  bool vib = false;
  bool rest = false;

  void handleTimer(int duration) {
    timer = duration;
    notifyListeners();
  }

  void setStarted(bool val) {
    started = val;
    notifyListeners();
  }

  void handleSbreak(int duration) {
    sBreak = duration;
    notifyListeners();
  }

  void increSes() {
    if (sesCount == 4) {
      rest = !rest;
      sesCount = 0;
    } else {
      sesCount += 1;
    }
    print(sesCount);
    notifyListeners();
  }

  void restStat() {
    rest = !rest;
    notifyListeners();
  }

  void handleLbreak(int duration) {
    lBreak = duration;
    notifyListeners();
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int current = 0;
  final controller = PageController();
  late DbService _dbFunc;

  @override
  void initState() {
    super.initState();
    _dbFunc = DbService();
    _dbFunc.initilaize().whenComplete(() => print("Created db"));
  }

  void printData() async {
    // await _dbFunc.deleteAll();
    List<DataModel> dataList = await _dbFunc.get();
    print(dataList);
    for (var data in dataList) {
      print('Date: ${data.date}, hours: ${data.hours}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // printData();
    return ChangeNotifierProvider(
        create: (context) => AppData(),
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: ColorScheme(
                    brightness: Brightness.dark,
                    primary: const Color.fromRGBO(30, 34, 64, 1),
                    onSecondary: Colors.purple,
                    surface: Colors.white,
                    onError: Colors.red,
                    error: Colors.redAccent,
                    onSurface: Colors.transparent,
                    onPrimary: const Color.fromRGBO(23, 27, 50, 1),
                    background: const Color.fromRGBO(30, 34, 64, 1),
                    secondary: context.watch<AppData>().rest
                        ? Colors.green
                        : const Color.fromARGB(255, 255, 91, 91),
                    onBackground: Colors.deepPurpleAccent),
                textTheme: TextTheme(
                    bodyMedium: GoogleFonts.montserrat(
                        textStyle: const TextStyle(fontSize: 18)))),
            home: Scaffold(
                body: SafeArea(
                    child: Container(
                  // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: PageView(
                    physics: context.watch<AppData>().started
                        ? const NeverScrollableScrollPhysics()
                        : const ScrollPhysics(),
                    scrollBehavior: const MaterialScrollBehavior(),
                    controller: controller,
                    children: const <Widget>[
                      content.Body(),
                      Graph(),
                      Settings()
                    ],
                    onPageChanged: (value) {
                      setState(() {
                        current = value;
                      });
                    },
                  ),
                )),
                bottomNavigationBar: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: DotNavigationBar(
                    unselectedItemColor: Provider.of<AppData>(context).started
                        ? Color(0xFF867E7E)
                        : Color(0xFFFFFFFF),
                    enableFloatingNavBar: true,
                    backgroundColor: const Color.fromRGBO(70, 76, 119, 1),
                    marginR:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                    paddingR:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    currentIndex: current,
                    onTap: (p) {
                      if (!Provider.of<AppData>(context, listen: false)
                          .started) {
                        setState(() {
                          current = p;
                          controller.animateToPage(p,
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.easeInOut);
                        });
                      }
                    },
                    // dotIndicatorColor: Colors.black,
                    items: [
                      /// Home
                      DotNavigationBarItem(
                        icon: const Icon(Icons.timer),
                        selectedColor: Color(0xFFF87070),
                      ),

                      DotNavigationBarItem(
                        icon: const Icon(Icons.bar_chart),
                        selectedColor: const Color(0xFFF87070),
                      ),

                      /// Likes
                      DotNavigationBarItem(
                          icon: const Icon(Icons.settings),
                          selectedColor: const Color(0xFFF87070)),
                    ],
                  ),
                )),
          );
        });
  }
}
