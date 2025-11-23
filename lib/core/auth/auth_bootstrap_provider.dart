import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_api.dart';
import 'auth_state.dart';
import 'auth_storage.dart';
import '../api/api_client.dart';

final authBootstrapProvider = FutureProvider<void>((ref) async {
  final token = await AuthStorage.readToken();
  if (token == null) {
    ref.read(authStateProvider.notifier).setUnauthenticated();
    return;
  }
  try {
    await AuthApi.me(token);
    ApiClient.setAuthToken(token);
    ref.read(authStateProvider.notifier).setAuthenticated(token);
  } catch (_) {
    await AuthStorage.clearToken();
    ref.read(authStateProvider.notifier).setUnauthenticated();
  }
});
