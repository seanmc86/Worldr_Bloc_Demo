import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldr_task/bloc/message/bloc.dart';
import 'package:worldr_task/bloc/person/bloc.dart';
import 'package:worldr_task/core/errors/global_messages.dart';
import 'package:worldr_task/core/widgets/custom_expansion_tile.dart';
import 'package:worldr_task/entity/message.dart';
import 'package:worldr_task/entity/person/person.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Align(
            alignment: Alignment.center,
            child: CustomExpansionTile(
                onExpansionChanged: (isExpanded) {
                  if (isExpanded)
                    BlocProvider.of<MessageBloc>(context)
                        .add(MessageEvent.messageOpened(message: message));
                },
                title: Column(
                  children: <Widget>[
                    BlocBuilder<PersonBloc, PersonState>(
                        builder: (context, state) {
                      return state.when(
                          initial: (_) => _colourContainer(
                              GlobalMessages.dummyPerson, false),
                          loading: (_) => _colourContainer(
                              GlobalMessages.dummyPerson, false),
                          loaded: (data) {
                            final person = data.persons.results.firstWhere(
                                (p) => p.guid == message.personGuid,
                                orElse: () => GlobalMessages.dummyPerson);
                            return _colourContainer(person, message.isRead);
                          },
                          error: (e) => _colourContainer(
                              GlobalMessages.dummyPerson, false));
                    })
                  ],
                ),
                childContent: '${message.content}'),
          ),
        ));
  }

  /// Default values are provided from dummyPerson in the scenario of
  /// failing to read the associated [Person]
  Widget _colourContainer(Person person, bool isRead) {
    return Row(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, person.colorRed,
                        person.colorGreen, person.colorBlue)))),
        Expanded(
            child: Text(
          '${person.firstName} ${person.lastName}',
          maxLines: 2,
          style: TextStyle(fontSize: 18),
        )),
        if (isRead)
          Icon(
            Icons.check,
            color: Colors.green,
          )
      ],
    );
  }
}
