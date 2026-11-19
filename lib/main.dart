import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configs/constants/environment.dart';
import 'configs/router/app_routers.dart';
import 'configs/themes/app_themes.dart';

Future<void> main() async {
   await Environment.initEnv();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      theme: AppThemes().theme(),
      debugShowCheckedModeBanner: false,
      title: 'Aegis',
    );
  }
}
