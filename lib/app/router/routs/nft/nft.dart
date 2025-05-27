import 'package:app/app/router/app_route.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:go_router/go_router.dart';

StatefulShellBranch get nftBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.nft.name,
        path: AppRoute.nft.path,
        builder: (context, state) => const NftPageWidget(),
        routes: [addNftRoute],
      ),
    ],
  );
}

GoRoute get addNftRoute {
  return GoRoute(
    path: AppRoute.addNft.path,
    name: AppRoute.addNft.name,
    builder: (_, __) => const AddNftWidget(),
  );
}
