import 'package:firebase_auth_log_in/providers/localization_notifier_provider.dart';
import 'package:firebase_auth_log_in/services/hive_services.dart';
import 'package:firebase_auth_log_in/ui/pages/firebase_pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveServices.initHive();
  runApp(const ProviderScope(child: MyApp()));
}
final messengerKey = GlobalKey<ScaffoldMessengerState>();
class MyApp extends ConsumerWidget {
   const MyApp({super.key});
  

  @override
  Widget build(BuildContext context,ref) {
    final locale = ref.watch(localizationChangeNotifierProvider);
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale.currnet,
      home: const MainPage(),
    );
  }
}