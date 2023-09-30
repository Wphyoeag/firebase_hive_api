
import 'package:firebase_auth_log_in/ui/pages/bot_nav_page/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/logIn_bool_provider.dart';
import 'main_page.dart';
class VerifiedEmailPage extends ConsumerWidget {
  const VerifiedEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVerified = ref.watch(emailVerifiedProvider);
    return isVerified
        ?  BottomNavPage()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title: const Text('Verify Email'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Verification email has been sent',
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton.icon(
                      onPressed: ref
                          .read(emailVerifiedProvider.notifier)
                          .sendVerification,
                      icon: const Icon(Icons.email),
                      label: const Text('Resend')),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                      onTap: () async {
                        await ref.read(emailVerifiedProvider.notifier).cancell();
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (_) {
                          return const MainPage();
                        }));
                      },
                      child: const Text('Cancel'))
                ],
              ),
            ),
          );
  }
}