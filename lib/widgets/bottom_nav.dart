import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:language_translator/pages/pdf_page.dart';
import 'package:language_translator/pages/home.dart';
import 'package:language_translator/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
   BottomNavigation({super.key});
  final List<Widget> _tabs = [
    const HomeScreen(),
    const PdfPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: _tabs[navProvider.selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blue,
              color: Colors.grey[600],
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.picture_as_pdf,
                  text: 'Documents',
                ),
              ],
              selectedIndex: navProvider.selectedIndex,
              onTabChange: (index) {
                navProvider.changeIndex(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}