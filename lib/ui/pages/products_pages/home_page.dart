import 'package:firebase_auth_log_in/providers/database_providers.dart';
import 'package:firebase_auth_log_in/providers/google_sign_in_provider.dart';
import 'package:firebase_auth_log_in/ui/pages/language/chg_language.dart';
import 'package:firebase_auth_log_in/ui/pages/products_pages/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/post_model.dart';
import '../../../providers/product_provider.dart';
import '../firebase_pages/main_page.dart';
import 'detail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends ConsumerWidget {
  final PostModel? postModel;
  const HomePage({super.key, this.postModel});
  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(productProvider);
    //toggle internet to checkout status
    ref.listen(networkStateProvider, (previous, next) {
      if (next == NetworkStatus.on) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("online")));
        // do something here
        //
      } else if (next == NetworkStatus.off) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("offline")));
        // do something
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appbartitle),
          backgroundColor: const Color.fromARGB(255, 3, 85, 5),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage()));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: ref.read(productProvider.notifier).productsModel == null
            ? const Center(
                child: CupertinoActivityIndicator(
                  radius: 30,
                  color: Color.fromARGB(255, 3, 85, 5),
                ),
              )
            : ListView.builder(
                itemCount: data.products?.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) =>
                              DetailPage(productt: data.products![index])));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Card(
                        elevation: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              data.products![index].thumbnail,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                data.products![index].title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  Text(
                                    '${data.products![index].price}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Text(
                                    ' USD',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(data.products![index].description)),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
        drawer: Drawer(
            child: ListView(children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            currentAccountPicture: CircleAvatar(
                radius: (52),
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      "https://i.pinimg.com/originals/10/94/0e/10940ea495f50c9dce7ffb56e7f2b9ec.jpg"),
                )),
            otherAccountsPictures: [
              CircleAvatar(
                  radius: (52),
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        'https://i.pinimg.com/originals/6b/c7/c9/6bc7c9e4d840160d68754f8115c38129.jpg'),
                  )),
              CircleAvatar(
                  radius: (52),
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        "https://i.pinimg.com/originals/e2/2b/ed/e22bed3bdba0f328efdb3521e07bf823.jpg"),
                  )),
            ],
            accountName: const Text('Wpa'),
            accountEmail: const Text(
              'wpa@gmail.com',
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Text(
                        AppLocalizations.of(context)!.sureLogOut,
                        style: const TextStyle(fontSize: 18),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () async {
                              // FirebaseAuth.instance.signOut();
                              await ref
                                  .read(googleSignInProviderProvider.notifier)
                                  .signOutWithGoogle();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => const MainPage()));
                            },
                            child: Text(AppLocalizations.of(context)!.ok)),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.cancel))
                      ],
                    );
                  });
            },
            title: Text(
              AppLocalizations.of(context)!.logout,
              style: const TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.logout),
          ),
          const SizedBox(
            height: 8,
          ),
          const ChgLanguage()
        ])));
  }
}
