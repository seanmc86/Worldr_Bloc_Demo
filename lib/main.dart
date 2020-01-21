import 'package:device_simulator/device_simulator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worldr_task/bloc/app/bloc.dart';
import 'package:worldr_task/core/errors/global_messages.dart';
import 'package:worldr_task/data/provider/local_data_source.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/message.dart';
import 'package:worldr_task/entity/person/person.dart';
import 'package:worldr_task/screens/app_scaffold.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final docDirectory = await getApplicationDocumentsDirectory();
  Hive.init(docDirectory.path);

  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(SportsTypeAdapter());

  BlocSupervisor.delegate = SimpleBlocDelegate();

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: GlobalMessages.appTitle,
        themeMode: ThemeMode.system,
        theme: ThemeData(

            /// Required in order to have safe usage of the [CustomAnimatedButton]
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              elevation: 4,
              backgroundColor: Colors.green,
              splashColor: Colors.white30,
              highlightElevation: 2,
              shape: StadiumBorder(),
            ),
            textTheme: TextTheme(button: TextStyle(color: Colors.white)),
            primarySwatch: Colors.blue,
            dividerColor: Colors.transparent),
        home: DeviceSimulator(
            enable: false,
            child: BlocProvider<AppBloc>(
              create: (context) => AppBloc()
                ..add(AppEvent.getPage(
                    pageNum: 0, sportsType: SportsType.Basketball)),
              child: AppScaffold(
                  messageRepository: MessageRepositoryImpl(
                      localDataSource: LocalDataSourceImpl())),
            )));
  }
}

/// Can be used for global event/error/analytics handling
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
