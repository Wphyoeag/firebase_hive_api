import 'package:firebase_auth_log_in/ui/pages/database_page/database_page.dart';
import 'package:firebase_auth_log_in/ui/pages/products_pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/bottom_nav_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavPage extends ConsumerWidget {
  final List<Widget> _widgetOptions = [
    const HomePage(),
    const DatabasePage()
  ];
   BottomNavPage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    var navIndex = ref.watch(bottomNavIndexProvider);
    return BottomNavView(
      title: 'Guess',
      appBarBackgroundColor: Colors.indigoAccent,
      bodyBackgroundColor: Colors.white,
      bodyWidget: _widgetOptions.elementAt(navIndex),
      navIndex: navIndex,
      items:  [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: AppLocalizations.of(context).product,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.settings,
                ),
                label: AppLocalizations.of(context).storage,
              ),
            ],
    );
  }
}

class BottomNavView extends ConsumerWidget {
  final String title;
  final Color appBarBackgroundColor;
  final Color bodyBackgroundColor;
  final Widget bodyWidget;
  final int navIndex;
  final List<BottomNavigationBarItem> items;

  const BottomNavView(
      {super.key,
      required this.title,
      required this.appBarBackgroundColor,
      required this.bodyBackgroundColor,
      required this.bodyWidget,
      required this.navIndex,
      required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    // var bloc = ref.watch(bottomNavProvider);

    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.amber,
            selectedItemColor: Colors.indigoAccent,
            selectedFontSize: 13,
            items: items,
            currentIndex: navIndex,
            onTap: (index) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
            },
          ),
        ),
      ),
    );
  }
}
