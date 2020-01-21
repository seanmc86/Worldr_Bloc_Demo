import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldr_task/bloc/app/bloc.dart';
import 'package:worldr_task/bloc/person/bloc.dart';
import 'package:worldr_task/core/errors/global_messages.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/person/person.dart';

class PeopleScreen extends StatelessWidget {
  final MessageRepository messageRepository;
  final SportsType sportsType;

  PeopleScreen({Key key, @required this.messageRepository, this.sportsType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonBloc>(
        create: (blocContext) => PersonBloc(messageRepository)
          ..add(PersonEvent.getPersonsForType(sportsType: sportsType)),
        child: Scaffold(
            body: SingleChildScrollView(
          child: BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              state.when(
                  initial: (_) => null,
                  loadedMessages: (_) => null,
                  loaded: (data) => BlocProvider.of<PersonBloc>(context).add(
                      PersonEvent.getPersonsForType(
                          sportsType: data.sportsType)));
            },
            child: BlocBuilder<PersonBloc, PersonState>(
              builder: (context, state) {
                return state.when(
                    initial: (_) => _centredChild(Container()),
                    loading: (_) => _centredChild(CircularProgressIndicator()),
                    loaded: (data) {
                      if (data.persons.results.length == 0)
                        return _centredChild(
                            Text(GlobalMessages.noPeopleInCategory));
                      return Column(children: [
                        SizedBox(
                          height: 70,
                        ),
                        for (var person in data.persons.results)
                          _personCard(context, person)
                      ]);
                    },
                    error: (e) {
                      /// Error is already handled on Home Screen, adding another here may be overkill
                      // ErrorSnackBar.showScaffoldSnackBarPostFrame(
                      //     context, e.message);
                      return _centredChild(Container());
                    });
              },
            ),
          ),
        )));
  }

  Widget _centredChild(Widget child) {
    return Center(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        child,
      ],
    ));
  }

  Widget _personCard(BuildContext context, Person person) {
    return GestureDetector(
      onTap: () => BlocProvider.of<AppBloc>(context).add(AppEvent.goToMessages(
          pageNum: 2, filtedByGuid: person.guid, filterBySportsType: null)),
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, person.colorRed,
                                  person.colorGreen, person.colorBlue))),
                    ),
                    Text(
                      '${person.firstName} ${person.lastName}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ])))),
    );
  }
}
