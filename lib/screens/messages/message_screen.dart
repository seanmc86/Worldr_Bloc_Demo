import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:worldr_task/bloc/message/bloc.dart';
import 'package:worldr_task/bloc/person/bloc.dart';
import 'package:worldr_task/core/errors/error_snackbar.dart';
import 'package:worldr_task/core/errors/global_messages.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/person/person.dart';
import 'package:worldr_task/screens/messages/message_card.dart';

class MessageScreen extends StatelessWidget {
  final String filterByGuid;
  final SportsType filterBySportsType;
  final MessageRepository messageRepository;

  const MessageScreen(
      {Key key,
      this.filterByGuid,
      this.filterBySportsType,
      @required this.messageRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<PersonBloc>(
              create: (context) =>
                  PersonBloc(messageRepository)..add(PersonEvent.getPersons()),
            ),
            BlocProvider<MessageBloc>(
                create: (context) => MessageBloc(messageRepository)
                  ..add(MessageEvent.getMessages(
                      guid: filterByGuid, sportsType: filterBySportsType)))
          ],
          child: SingleChildScrollView(child:
              BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
            return state.when(
                initial: (_) => _centredChild(Container()),
                loading: (_) => _centredChild(CircularProgressIndicator()),
                loaded: (data) {
                  /// This will still yield data under the scenario of
                  /// [Persons] being erroneous and [Messages] working
                  if (data.messages.results.length == 0)
                    return _centredChild(
                        Text(GlobalMessages.noMessagesFromPerson));
                  return Column(children: [
                    SizedBox(
                      height: 70,
                    ),
                    for (var message in data.messages.results)
                      MessageCard(message: message)
                  ]);
                },
                error: (e) {
                  /// In case we receive a storage/Hive error, show an error SnackBar post-build
                  /// This will only trigger if [Persons] AND [Messages] are erroneous
                  ErrorSnackBar.showScaffoldSnackBarPostFrame(
                      context, e.message);
                  return _centredChild(Container());
                });
          })),
        ),
      ),
    );
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
}
