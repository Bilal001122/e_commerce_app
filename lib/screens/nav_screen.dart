import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/log_out.dart';
import 'package:e_commerce_app/screens/saved_screen.dart';
import 'package:e_commerce_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

class NavScreen extends StatefulWidget {
  final List<Widget> screens = [
    HomeScreen(
      key: PageStorageKey('home'),
    ),
    SearchScreen(
      key: PageStorageKey('search'),
    ),
    SavedScreen(
      key: PageStorageKey('saved'),
    ),
    LogOut(
      key: PageStorageKey('logout'),
    ),
  ];

  final Map<String, IconData> icons = {
    'Home': Icons.home,
    'Search': Icons.search,
    'Saved': Icons.bookmark_outlined,
    'Log Out': Icons.logout_outlined,
  };

  NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;
  late PageController tabsPageController;

  @override
  void initState() {
    tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // this is a custom BottomNavBar
    return Scaffold(
      body: PageView(
        controller: tabsPageController,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        children: widget.screens,
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: Color(0xFFFF1E00),
        unSelectedColor: Colors.black87,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedIconSize: 25,
        unselectedIconSize: 25,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            tabsPageController.jumpToPage(currentIndex);
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 2,
        indicatorType: IndicatorType.Top,
        customBottomBarItems: widget.icons
            .map(
              (title, icon) => MapEntry(
                title,
                CustomBottomBarItems(
                  label: title,
                  icon: icon,
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
    //body: widget.screens[currentIndex],
  }
}

// this the nav bar that come with flutter

// return Scaffold(
//   bottomNavigationBar: BottomNavigationBar(
//     currentIndex: currentIndex,
//     backgroundColor: Colors.white,
//     selectedItemColor: Colors.deepOrange,
//     unselectedFontSize: 12,
//     unselectedItemColor: Colors.black,
//     selectedFontSize: 12,
//     type: BottomNavigationBarType.fixed,
//     onTap: (value) {
//       setState(() {
//         currentIndex = value;
//       });
//     },
//     items: widget.icons
//         .map(
//           (title, icon) => MapEntry(
//             title,
//             BottomNavigationBarItem(
//               tooltip: title,
//               icon: Icon(
//                 icon,
//                 size: 30,
//               ),
//               label: title,
//             ),
//           ),
//         )
//         .values
//         .toList(),
//   ),
//   body: widget.screens[currentIndex],
// );
