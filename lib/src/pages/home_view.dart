import 'package:app/src/utils/constants.dart';
import 'package:app/src/widgets/bottom_navigation_bar.dart';
import 'package:app/src/widgets/top_bar.dart';
import 'package:app/src/widgets/weather_preview.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = "/home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < responsiveSizeThreshold) {
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            bottomNavigationBar: BottomNavBar(
              selectedIndex: 0,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            body: Column(
              children: [
                TopBar(
                  constraints: constraints,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: WeatherPreview(
                    constraints: constraints,
                  ),
                )
              ],
            ));
      } else {
        return const Text("Desktop View");
      }
    });
  }
}
