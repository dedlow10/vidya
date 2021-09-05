import 'package:flutter/material.dart';
import './theme.dart';
import './screens/home_screen.dart';
import './screens/upload_screen.dart';
import './screens/profile_screen.dart';
import './screens/game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  int index = 1;

  getNavBar() {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int index) {
        setState(() {
          this.index = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: AppBarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videogame_asset, color: TextIconColor),
          label: 'Games',
          backgroundColor: AppBarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add, color: TextIconColor),
          label: 'Share',
          backgroundColor: AppBarColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: TextIconColor),
          label: 'Profile',
          backgroundColor: AppBarColor,
        ),
      ],
    );
  }

  getBody() {
    switch (index) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return GameScreen();
        break;
      case 2:
        return UploadScreen();
        break;
      case 3:
        return ProfileScreen();
        break;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidya',
      home: Scaffold(
          backgroundColor: AppBackgroundColor,
          bottomNavigationBar: getNavBar(),
          body: getBody()),
    );
  }
}
