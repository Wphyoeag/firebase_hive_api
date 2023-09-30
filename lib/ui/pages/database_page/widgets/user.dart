
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/database_providers.dart';

class UserUi extends ConsumerWidget {
  const UserUi({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final List list = List.generate(11, (index) => index);
    var width = MediaQuery.sizeOf(context).width;
   final id= ref.watch(selectedUserIdProvider);
    // print(ref.watch(selectedUserIdProvider));
    // ref.watch(userIdGetProvider);
    return 
    Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
        decoration:
            BoxDecoration(border: Border.all(width: 1.5, color: Colors.green)),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (_, index) {
              
              return InkWell(
                onTap: () async {
                  ref.read(selectedUserIdProvider.notifier).state = index;
                  print('idddd index ${ref.read(selectedUserIdProvider.notifier).state}');
                  ref.read(userIdGetProvider.notifier).getData();
                  // print(ref.read(selectedUserIdProvider.notifier).state);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color:
                        id == index
                            ? Colors.cyan[300]
                            : Colors.deepOrange[200],
                  ),
                  width: width * 0.33,
                  child: Center(
                      child: Text(
                    list[index].toString(),
                    style: const TextStyle(fontSize: 20),
                  )),
                ),
              );
            }),
      ),
    );
  }
}
