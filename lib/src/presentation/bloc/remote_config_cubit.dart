import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

class RemoteConfigCubit extends Cubit<BaseState<Map>> {
  RemoteConfigCubit() : super(const BaseState());

  void startWork() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.activate();
    emit(BaseState(entity: remoteConfig.getAll()));
    print('startWork ${remoteConfig.getAll()}');

    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      print('startWork event $event}');

      emit(BaseState(entity: remoteConfig.getAll()));
    });
  }
}

enum RemoteKeys {
  criticalMinAndroidVersion,
  criticalMinIosVersion,
}
