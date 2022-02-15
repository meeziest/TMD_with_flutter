import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies_flutter/bloc/popular_movies_bloc/popular_movies_cubit.dart';
import 'package:popular_movies_flutter/bloc/sort_options_bloc/sort_options_cubit.dart';
import 'package:popular_movies_flutter/localization/localiztion_service.dart';
import 'package:popular_movies_flutter/repositories/movie_repository.dart';
import 'view/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  final SortOptionsCubit sortOptionsCubit;
  final MovieRepository movieRepository;

  const MyApp({Key? key,
    required this.sortOptionsCubit,
    required this.movieRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => movieRepository,
      child: MaterialApp(
        title: 'Flutter Movie App',
        localeResolutionCallback: LocalizationService.localeResolutionCallBack,
        supportedLocales: LocalizationService.supportedLocales,
        localizationsDelegates: LocalizationService.localizationsDelegate,
        theme: ThemeData.dark(),
        initialRoute: HomeScreen.id,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SortOptionsCubit>(
              create: (newContext) => sortOptionsCubit,
            ),
            BlocProvider<PopularMovieCubit>(
                create: (newContext) =>
                PopularMovieCubit(
                    sortOptionsCubit: sortOptionsCubit,
                    repository: movieRepository,
                    locale: LocalizationService.currentLocale
                )
                  ..fetchList(LocalizationService.currentLocale)
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
