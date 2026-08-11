import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hyperlocal_shared/services/deep_link_resolver.dart';

import '../../app_config.dart'; // kDeepLinkScheme = 'hcust'

class CustomerDeepLinkHandler {
  final AppLinks _appLinks = AppLinks();
  final GoRouter _router;
  late final DeepLinkResolver _resolver;

  CustomerDeepLinkHandler({required GoRouter router}) : _router = router {
    _resolver = DeepLinkResolver(
      expectedScheme: kDeepLinkScheme, // dari app_config.dart, bukan hardcode
      resolvers: {
        'home': (host, segments) => const DeepLinkResult('/home'),
        'order': (host, segments) {
          if (segments.isEmpty) return const DeepLinkResult('/home');
          final orderId = segments[0];
          if (segments.length >= 2 && segments[1] == 'accepted') {
            return DeepLinkResult('/tracking/$orderId');
          }
          if (segments.length >= 2 && segments[1] == 'rate') {
            return DeepLinkResult('/order/$orderId/rate');
          }
          return DeepLinkResult('/tracking/$orderId');
        },
        'chat': (host, segments) {
          if (segments.isEmpty) return const DeepLinkResult('/home');
          return DeepLinkResult('/chat/${segments[0]}');
        },
      },
    );
  }

  void init() {
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) handleUri(uri);
    });
    _appLinks.uriLinkStream.listen(handleUri);
  }

  /// Public — dipanggil dari app_links, FcmHandler, dan re-login flow.
  void handleUri(Uri uri) {
    final result = _resolver.resolve(uri);
    if (!result.recognized) {
      debugPrint('[DeepLink] Customer: tidak dikenali → $uri');
    } else {
      debugPrint('[DeepLink] Customer: $uri → ${result.route}');
    }
    _router.go(result.route);
  }
}
