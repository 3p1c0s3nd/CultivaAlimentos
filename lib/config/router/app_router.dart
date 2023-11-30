import 'package:app_cocechar/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:app_cocechar/config/info/info_json.dart';

final appRouter = GoRouter(
    //initialLocation: '/',

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),

      //Hacemos las rutas para detail_json
      for (var i = 0; i < InfoJson().info.length; i++)
        GoRoute(
            path: "/${InfoJson().info[i]['section']}",
            builder: (context, state) => DetailScreen(
                  tipo: InfoJson().info[i]['tipo'],
                )),

      //Hacemos un for recorriendo el array de info_json
      for (var i = 0; i < InfoJson().info.length; i++)
        GoRoute(
            path: "/${InfoJson().info[i]['route']}",
            builder: (context, state) => PrincipalScreen(
                  title: InfoJson().info[i]['title'],
                  img: InfoJson().info[i]['image'],
                  descripcion: InfoJson().info[i]['description'],
                  section: InfoJson().info[i]['section'],
                )),
    ]);
