import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_model.dart';
import '../services/database_api_services.dart';
import '../services/hive_services.dart';

final userBoolProvider = StateProvider((ref) => false);
final scrollControlllerProvider = StateProvider((ref) => ScrollController());
final titleProvider = StateProvider((ref) => TextEditingController());
final bodyProvider = StateProvider((ref) => TextEditingController());
final apiServiceProvider = Provider((ref) => ApiService());
final selectedUserIdProvider = StateProvider<int>((ref) => 0);
final userIdGetProvider =
    StateNotifierProvider<UserStateNotify, List<UserModel>>((ref) {
  return UserStateNotify(ref);
});

class UserStateNotify extends StateNotifier<List<UserModel>> {
  final Ref ref;
  UserStateNotify(this.ref) : super([]) {
    getData();
  }
  List<UserModel> list = [];
  void getData() async {
    //just wait a millisec to check network status
    //may be there is another way to check
    await Future.delayed(const Duration(milliseconds: 100));
    //block 100 milliseconds

    print('state ${ref.read(networkStateProvider)}');
    
    final id = ref.read(selectedUserIdProvider);
    print('idddd $id');
    if (id == 0) {
      if (ref.read(networkStateProvider) == NetworkStatus.on) {
        print(
            'Connectivity ${ref.read(networkStateProvider) == NetworkStatus.on}');
        HiveServices.deleteAllData('mainBox');
        try {
          list = await ApiService.getAllData();

          HiveServices.storeDataList('mainBox', list);
          //  final data= await HiveServices.getUserBox('mainBox');
          state = list;
        } on DioException {}
      } else {
        print('state  Offline');
        final s = await HiveServices.getUserBox('mainBox');
        state = s;
      }
      // print(mounted);
      if (!mounted) return;
    } else if (id >= 1 && id <= 10) {
      
      final boxName = 'box$id';
      if (ref.read(networkStateProvider) == NetworkStatus.on) {
        list = await ApiService.getUserIdData(id);
        HiveServices.storeDataList(boxName, list);
      } else {}
      state = await HiveServices.getUserBox(boxName);
    }
  }

  Future<void> addUser(UserModel userToAdd) async {
    if (ref.read(networkStateProvider) == NetworkStatus.on) {
      await HiveServices.addData('mainBox', userToAdd);
      ref.read(selectedUserIdProvider.notifier).state = 0;
      state = await HiveServices.getUserBox('mainBox');
    } else {}
  }

  void postData({String? title, String? body}) async {
    if (ref.watch(networkStateProvider) == NetworkStatus.on) {
      final data = await ApiService.postData(title!, body!);
      addUser(data);
    } else {
      return;
    }
  }

  Future<void> deleteUser(int rvIndex) async {
    // final id=ref.watch(selectedUserIdProvider);
    if (ref.read(networkStateProvider) == NetworkStatus.on) {
      HiveServices.deleteData('mainBox', rvIndex);
    } else {
      return;
    }
    state = await HiveServices.getUserBox('mainBox');
  }
}

enum NetworkStatus { on, off, unknown }

final networkStateProvider =
    StateNotifierProvider<NetwokStateNotifier, NetworkStatus>(
        (ref) => NetwokStateNotifier(ref));

class NetwokStateNotifier extends StateNotifier<NetworkStatus> {
  Ref ref;
  NetwokStateNotifier(this.ref) : super(NetworkStatus.unknown) {
    Connectivity().onConnectivityChanged.listen((event) {
      NetworkStatus newState = switch (event) {
        ConnectivityResult.mobile ||
        ConnectivityResult.wifi ||
        ConnectivityResult.vpn ||
        ConnectivityResult.ethernet =>
          NetworkStatus.on,
        ConnectivityResult.none => NetworkStatus.off,
        _ => NetworkStatus.unknown,
      };
      if (newState != state) {
        state = newState;
      }
    });
  }
}
