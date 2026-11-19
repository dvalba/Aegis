import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/provider/auth/auth_provider.dart';
import '../dynamic_elements/component_map.dart';
import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.watch(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: goRouterNotifier,
    routes: [
      ...componentsMap.entries.map((entry) => GoRoute(
            path: entry.value['route'],
            name: entry.key,
            builder: entry.value['widget'],
          )),
      ...authMap.entries.map((entry) => GoRoute(
            path: entry.value['route'],
            name: entry.key,
            builder: entry.value['widget'],
          )),
    ],
    redirect: (context, state) {
      // Obtener ruta actual y destino
      final targetLocation = state.uri.path; // Ruta destino

      // Lógica de autenticación
      final authStatus = goRouterNotifier.status;

      if (targetLocation == '/loader') {
        if (authStatus == AuthStatus.checking) return null;
        if (authStatus == AuthStatus.authenticated) return '/home';

        if (authStatus == AuthStatus.unauthenticated) return '/login';
      }

      if (authStatus == AuthStatus.unauthenticated) {
        return _handleUnauthenticated(targetLocation);
      }

      if (authStatus == AuthStatus.authenticated) {
        return _handleAuthenticated(targetLocation);
      }

      return null;
    },
  );
});

String? _handleUnauthenticated(String targetLocation) {
  const allowedRoutes = {'/', '/login', '/signup'};
  return allowedRoutes.contains(targetLocation) ? null : '/login';
}

String? _handleAuthenticated(String targetLocation) {
  const blockedRoutes = {'/', '/login', '/signup', '/loader'};
  return blockedRoutes.contains(targetLocation) ? '/home' : null;
}
