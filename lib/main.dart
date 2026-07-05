import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'core/routes_manager/route_generator.dart';
import 'core/theme/base_theme.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'feature/data/data_sources/admin_service.dart';
import 'feature/data/data_sources/ai_description_api_service.dart';
import 'feature/data/data_sources/camp_api_service.dart';
import 'feature/data/data_sources/case_api_service.dart';
import 'feature/data/data_sources/charity_dashboard_service.dart';
import 'feature/data/data_sources/donor_case_api_service.dart';
import 'feature/data/data_sources/recommend_api_service.dart';
import 'feature/data/repositories_imp/admin_repository_impl.dart';
import 'feature/data/repositories_imp/ai_description_repository.dart';
import 'feature/data/repositories_imp/camp_repository.dart';
import 'feature/data/repositories_imp/case_repository.dart';
import 'feature/data/repositories_imp/donor_case_repository.dart';
import 'feature/domain/repositories/admin_repository.dart';
import 'feature/domain/repositories/recommend_repository.dart';
import 'feature/presentation/state_management/cubit/accept_charities_cubit.dart';
import 'feature/presentation/state_management/cubit/admin_cubit.dart';
import 'feature/presentation/state_management/cubit/ai_description_cubit.dart';
import 'feature/presentation/state_management/cubit/camp_cubit.dart';
import 'feature/presentation/state_management/cubit/case_cubit.dart';
import 'feature/presentation/state_management/cubit/dashboard_cubit.dart';
import 'feature/presentation/state_management/cubit/donor_case_cubit.dart';
import 'feature/presentation/state_management/cubit/get_dashboard_stats_usecase.dart';
import 'feature/presentation/state_management/cubit/pending_charity_cubit.dart';
import 'feature/presentation/state_management/cubit/recommend_cubit.dart';
import 'feature/presentation/state_management/cubit/rejected_charities_cubit.dart';
import 'feature/presentation/state_management/cubit/top_charities_cubit.dart';
import 'feature/presentation/state_management/provider/my_provider.dart';
final getIt = GetIt.instance;
void main() async{
   WidgetsFlutterBinding.ensureInitialized();

  await ApiServices.loadSavedToken();
  getIt.registerLazySingleton(() => CampApiService());
  getIt.registerLazySingleton(() => CampaignRepository(getIt<CampApiService>()));
   getIt.registerLazySingleton(() => Dio());
   getIt.registerLazySingleton(
         () => RecommendApiService(getIt<Dio>()),
   );

   getIt.registerLazySingleton(
         () => RecommendRepository(
       getIt<RecommendApiService>(),
     ),
   );
   getIt.registerLazySingleton(
         () => AdminRemoteDataSource(getIt<Dio>()),
   );

   getIt.registerLazySingleton<AdminRepository>(
         () => AdminRepositoryImpl(
       getIt<AdminRemoteDataSource>(),
     ),
   );
   getIt.registerLazySingleton(
         () => AiDescriptionApiService(getIt<Dio>()),
   );

   getIt.registerLazySingleton(
         () => AiDescriptionRepository(
       getIt<AiDescriptionApiService>(),
     ),
   );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CaseCubit(
              CaseRepository(CaseApiService()),
            )..fetchCases(),
          ),

          BlocProvider(
            create: (_) => CampaignCubit(
              getIt<CampaignRepository>(),
            )..fetchCampaigns(1),
          ),

          BlocProvider(
            create: (_) => DashboardCubit(
              GetDashboardStatsUseCase(
                CharityDashboardService(Dio()),
              ),
            )..getDashboardStats(),
          ),

          BlocProvider(
            create: (_) => AdminStatsCubit(
              getIt<AdminRepository>(),
            )..getStats(),
          ),

          BlocProvider(
            create: (_) => TopCharitiesCubit(
              getIt<AdminRepository>(),
            )..getTopCharities(),
          ),

          BlocProvider(
            create: (_) => PendingCharitiesCubit(
              getIt<AdminRepository>(),
            )..getPendingCharities(),
          ),

          BlocProvider(
            create: (_) => AcceptCharitiesCubit(
              getIt<AdminRepository>(),
            )..getAcceptCharities(),
          ),

          BlocProvider(
            create: (_) => RejectedCharitiesCubit(
              getIt<AdminRepository>(),
            )..getRejectedCharities(),
          ),

          BlocProvider(
            create: (_) => DonorCaseCubit(
              DonorCaseRepository(
                DonorCaseApiService(),
              ),
            )..getCases(
  categoryName: "الصحة",
  )
          ),

          BlocProvider(
            create: (_) {
              final cubit = RecommendCubit(
                getIt<RecommendRepository>(),
              );

              ApiServices.getDonorToken().then((token) {
                if (token != null) {
                  cubit.fetchRecommendCases(token);
                }
              });

              return cubit;
            },
          ),

          BlocProvider(
            create: (_) => AiDescriptionCubit(
              getIt<AiDescriptionRepository>(),
            ),
          ),
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
    var provider = context.watch<MyProvider>();
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
        initialRoute: Routes.homePage,
      ),
    );
  }
}
