import 'package:event/controllers/service_repository.dart';
import 'package:event/theme/custom_theme.dart';
import 'package:event/views/bloc/calendar_bloc.dart';
import 'package:event/views/event_details.dart';
import 'package:event/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomThemeProvider>(builder: (context, provider, _) {
      return RepositoryProvider(
        create: (context) => ServiceRepository(),
        child: BlocProvider(
          create: (context) => CalendarBloc(context.read<ServiceRepository>()),
          child: MaterialApp(
            title: 'Calendar event',
            theme: CustomTheme.birthdayLightTheme,
            debugShowCheckedModeBanner: false,
            darkTheme: CustomTheme.birthdayDarkTheme,
            themeMode: provider.currentThemeMode,
            initialRoute: '/',
            onGenerateRoute: (settings) {
              late WidgetBuilder builder;
              switch (settings.name) {
                case '/':
                  builder = (context) => const Home();
                  break;
                case '/event':
                  builder = (context) => EventDetails(
                        event: (settings.arguments as Map)["event"],
                      );
                  break;
              }
              return MaterialPageRoute(builder: builder);
            },
          ),
        ),
      );
    });
  }
}
