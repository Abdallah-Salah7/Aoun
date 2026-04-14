import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/routes_manager/route_generator.dart';
import 'core/theme/base_theme.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'feature/presentation/state_management/cubit/campaign_cubit.dart';
import 'feature/presentation/state_management/cubit/case_cubit.dart';
import 'feature/presentation/state_management/provider/my_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CaseCubit()),
          BlocProvider(create: (_) => CampaignCubit()),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final BaseTheme lightTheme = LightTheme();
    final BaseTheme darkTheme = DarkTheme();
    var provider = Provider.of<MyProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => MaterialApp(
            theme: lightTheme.themeData,
            darkTheme: darkTheme.themeData,
            themeMode: provider.themeMode,
            debugShowCheckedModeBanner: false,
            home: child,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.homeCharity,
          ),
    );
  }
}
