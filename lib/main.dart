import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp20220914/controller/controller.dart';
import 'package:myapp20220914/controller/google_sign_in.dart';
import 'package:myapp20220914/controller/travelController.dart';
import 'package:myapp20220914/theme/theme.dart';
import 'package:myapp20220914/view/login.dart';
import 'package:myapp20220914/view/travel.dart';
import 'package:myapp20220914/view/travelFavorite.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GoogleSignController(),
          child: MainPage(),
        ),
        ChangeNotifierProvider(
          create: (_) => RouteController(),
          child: RouteBottomBar(),
        ),
        ChangeNotifierProvider(
          create: (_) => TravelController(),
          child: const Travel(),
        ),
      ],
      child: MainPage(),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //body: StreamBuilder<User?>(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(), // 通知用戶登錄狀態的更改
          builder: (context, snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("something went..."),
                );
              } else if (snapshot.hasData) {
                return const HomePage();
              } else {
                return const LoginPage();
              }
            } on FirebaseAuthException catch (e) {
              print(e);
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().materialTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => RouteBottomBar(),
        // '/travel': (context) => const Travel(),
        // '/travelfavorites': (context) => const TravelFavorite(),
        // '/googlemap': (context) => const MusicFavorite(),
      },
    );
  }
}

class RouteBottomBar extends StatelessWidget {
  RouteBottomBar({Key? key}) : super(key: key);
  final List<Widget> _children = [
    const Travel(),
    const Travel(),
    const TravelFavorite(),
    const TravelFavorite(),
  ];
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    print("${user.email}");
    return Consumer<RouteController>(
      builder: (context, routerIndex, child) {
        return SafeArea(
          child: Scaffold(
            drawer: Drawer(),
            body: IndexedStack(
              index: routerIndex.currentIndex,
              children: _children,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
              unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              currentIndex: routerIndex.currentIndex,
              onTap: (int currentIndex) =>
                  routerIndex.changeRouteIndex(currentIndex),
              items: const [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  activeIcon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: "traval",
                  icon: Icon(Icons.travel_explore_sharp),
                  activeIcon: Icon(Icons.travel_explore_sharp),
                ),
                BottomNavigationBarItem(
                  label: "Love",
                  icon: Icon(Icons.favorite_border),
                  activeIcon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  label: "Setting",
                  icon: Icon(
                    Icons.settings_outlined,
                  ),
                  activeIcon: Icon(Icons.settings),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
