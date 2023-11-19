import 'package:go_router/go_router.dart';
import 'package:simplenewsapp/presentations/browser/view/browser_view.dart';
import 'package:simplenewsapp/presentations/dashboard/view/dashboard_view.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return const DashboardView();
    },
  ),
  GoRoute(
    path: '/browse',
    builder: (context, state) {
      return BrowserView(
        uri: state.uri.queryParameters['uri'] ?? '',
      );
    },
  ),
]);
