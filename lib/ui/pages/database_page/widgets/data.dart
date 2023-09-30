import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/database_providers.dart';

class DataUi extends ConsumerWidget {
  const DataUi({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userListData = ref.watch(userIdGetProvider);
    final connection = ref.watch(networkStateProvider);
    return userListData.isEmpty
        ? connection == NetworkStatus.on
            ? const Expanded(
                flex: 8,
                child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 30,
                    color: Colors.white,
                  ),
                ),
              )
            : const Expanded(
                flex: 8,
                child: Center(
                  child: Text(
                    'NO DATA!    Download data first',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
        : Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: userListData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: index == 0
                          ? const Border(
                              top: BorderSide(width: 1),
                              left: BorderSide(width: 1),
                              right: BorderSide(width: 1),
                              bottom: BorderSide(width: 0.5))
                          : index == userListData.length - 1
                              ? const Border(
                                  top: BorderSide(width: 0.5),
                                  left: BorderSide(width: 1),
                                  right: BorderSide(width: 1),
                                  bottom: BorderSide(width: 1))
                              : Border.all(width: 0.5)),
                  child: ListTile(
                    title: Text(
                      userListData[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.limeAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    subtitle: Text(
                      userListData[index].body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    // trailing: IconButton(onPressed: (){
                    //   ref.read(userIdGetProvider.notifier).deleteUser(index);
                    // }, icon: const Icon(Icons.delete,color: Colors.red,)),
                  ),
                );
              },
            ));
  }
}
