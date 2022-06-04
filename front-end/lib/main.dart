import 'package:crime_reporter/bloc_observer.dart';
import 'package:crime_reporter/presentation/common/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'application/Auth/Bloc/auth_bloc.dart';
import 'application/police/bloc/policebloc_bloc.dart';
import 'application/user/bloc/userbloc_bloc.dart';

void main() {
  BlocOverrides.runZoned(() => runApp(Myapp()),
      blocObserver: CrimeReportBlocObserver());
}

RouteGenerator routeGenerator = RouteGenerator();
final _router = routeGenerator.routes;

class Myapp extends StatelessWidget {
  Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<PoliceblocBloc>(
          create: (BuildContext context) => PoliceblocBloc(),
        ),
        BlocProvider<UserblocBloc>(
          create: (BuildContext context) => UserblocBloc(),
        ),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate),
    );
  }
}
