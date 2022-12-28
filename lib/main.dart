import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:musicstation/Favourites/favourite_page.dart';
import 'package:musicstation/Favourites/favourite_screen.dart';
import 'package:musicstation/Favourites/reset.dart';
import 'package:musicstation/Home/home_screen.dart';
import 'package:musicstation/repo/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Very Important to do (Reason below)
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBS7tcAXlyO0OsWwQE4VnTwKdw4Isk9XXw",
    projectId: "newworld-4b7b8",
    messagingSenderId: "630203122972",
    appId: "1:630203122972:web:f6edabf286deb9326ea6d9",
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RepositoryProvider(create: (context) => Repo(), child: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  List<Widget> pages = [Home(), FavPage(), Reset()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
            onTabChange: (value) {
              setState(() {
                index = value;
                print(index);
              });
            },
            tabBackgroundColor: const Color.fromARGB(255, 107, 187, 226),
            padding:
                const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 10),
            backgroundColor: Colors.white,
            gap: 1,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: ' Home',
              ),
              GButton(
                icon: Icons.favorite,
                text: ' Likes',
              ),
              GButton(
                icon: Icons.restart_alt_rounded,
                text: ' Reset',
              ),
            ]),
      ),
    );
  }
}
