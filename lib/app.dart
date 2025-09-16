import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'featuers/auth/domain/auth_reposetory.dart';
import 'featuers/auth/presentation/blocs/auth/bloc/auth_bloc.dart';
import 'featuers/home/presentation/blocs/cubit/tasks_cubit.dart';
import 'featuers/splash/presentation/screens/splash_screen.dart';
import 'l10n/cubit/localiz_cubit.dart';
import 'l10n/l10n.dart';
import 'featuers/auth/presentation/blocs/login_button/bloc/login_button_bloc.dart';
import 'utils/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Localization
        BlocProvider(create: (context) => LocalizCubit()),
        // Authentication
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository())..add(AppStarted()),
        ),
        // Login Button State
        BlocProvider(create: (context) => LoginButtonBloc()),
        //tasks
        BlocProvider(create: (context) => TasksCubit()..loadTasks()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocBuilder<LocalizCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.system,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                locale: locale, // default language
                supportedLocales: L10n.all, // supported languages
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
