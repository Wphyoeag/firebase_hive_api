import 'package:firebase_auth_log_in/ui/pages/database_page/widgets/data.dart';
import 'package:firebase_auth_log_in/ui/pages/database_page/widgets/dialog_widget.dart';
import 'package:firebase_auth_log_in/ui/pages/database_page/widgets/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DatabasePage extends StatelessWidget {
  const DatabasePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ref.watch(userIdGetProvider);
    // print(ref.watch(userIdGetProvider));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: FlutterLogo(size: 0),
        ),
        title:  Text(AppLocalizations.of(context).storage),
      ),
      
      backgroundColor:  const Color.fromARGB(255, 3, 85, 5),
      body:  const Column(
        children: [
          UserUi(),
          // addUser.isEmpty?
          SizedBox(
            height: 10,
          ),
          DataUi(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return const DialogWidget();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
