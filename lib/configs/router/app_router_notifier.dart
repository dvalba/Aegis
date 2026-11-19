


import 'package:aegis/presentation/provider/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final goRouterNotifierProvider = Provider((ref){

  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
  
  
  });




class GoRouterNotifier extends ChangeNotifier{

  final AuthNotifier _authNotifier;
  AuthStatus _status = AuthStatus.checking;

  GoRouterNotifier(this._authNotifier){
    _authNotifier.addListener((state){
      authStatus = state.status;
    });
  }

  AuthStatus get status => _status;

  set authStatus(AuthStatus value){
    _status = value;
    notifyListeners();
  }

}