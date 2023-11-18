import 'package:flutter/material.dart';
import 'home.dart';
import 'settings.dart';

void main() {
  runApp( const MainApp() );
}

// widget = classes 
// Two kinds of widgets: 
// 1. state full widget
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  // override default states
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  PageController pageController = PageController();

  bool lightOrDark = true;

  // arrays are zero index: home is 0, settings is 1
  int currentIndex = 0;
  // index refers to the item you click on (keep track of index)
  void changeIndex(index){
    setState(() {
          currentIndex = index;
        });
  }

  // override default build 
  @override
  Widget build(BuildContext context){
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      // if true, select light. If false, select dark
      theme: lightOrDark ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Center( child: Text("Home Skillet Central") ),
        ),

        body: PageView(
          // swipe left to right 
          controller: pageController,
          onPageChanged: (index) => changeIndex(index),
          children: [
            Home(),
            Settings(),
            Image(
              image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/1/13/Official_USF_Bulls_Athletic_Logo.png"),
            )
          ]
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.color_lens,
            size: 32,
          ),
          // when the color palette is clicked, switch the theme
          onPressed: () => {
            setState(() {
              lightOrDark = !lightOrDark;
            })
          }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            )
          ],
          // make it that the icon labels aren't visible
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 32,
          // the highlight color will appear when you click
          // on the different icons in the bottom navigation
          currentIndex: currentIndex,
          onTap: (index) {
            changeIndex(index);
            pageController.jumpToPage(index);
          },
        )
      )
      );
  }

}