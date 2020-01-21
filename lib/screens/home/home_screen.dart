import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:worldr_task/bloc/app/bloc.dart';
import 'package:worldr_task/bloc/home/bloc.dart';
import 'package:worldr_task/core/errors/error_snackbar.dart';
import 'package:worldr_task/core/images/custom_images.dart';
import 'package:worldr_task/core/widgets/custom_animated_button.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/person/person.dart';

enum ButtonType { Basketball, Hockey, Messages }

class HomeScreen extends StatelessWidget {
  final MessageRepository messageRepository;
  final AnimationController buttonControllerBasketball;
  final AnimationController buttonControllerHockey;
  final AnimationController buttonControllerMessages;

  HomeScreen(
      {Key key,
      @required this.messageRepository,
      @required this.buttonControllerBasketball,
      @required this.buttonControllerHockey,
      @required this.buttonControllerMessages})
      : super(key: key);

  /// TODO: Simulating some additional processing time which we could substitute
  /// out once remote API calls come into play
  /// Currently these individual controllers are just for extra show
  _onButtonTapped(BuildContext context, ButtonType buttonType) {
    /// Initiate animation, wait until done, reverse animation, and then navigate
    switch (buttonType) {
      case ButtonType.Basketball:
        buttonControllerBasketball.forward();
        Future.delayed(const Duration(milliseconds: 800), () {
          buttonControllerBasketball.reverse().then(
              (_) => Future.delayed(const Duration(milliseconds: 400), () {
                    BlocProvider.of<AppBloc>(context).add(AppEvent.getPage(
                        pageNum: 1, sportsType: SportsType.Basketball));
                  }));
        });
        break;
      case ButtonType.Hockey:
        buttonControllerHockey.forward();
        Future.delayed(const Duration(milliseconds: 800), () {
          buttonControllerHockey.reverse().then(
              (_) => Future.delayed(const Duration(milliseconds: 400), () {
                    BlocProvider.of<AppBloc>(context).add(AppEvent.getPage(
                        pageNum: 1, sportsType: SportsType.Hockey));
                  }));
        });
        break;
      default:
        buttonControllerMessages.forward();
        Future.delayed(const Duration(milliseconds: 800), () {
          buttonControllerMessages.reverse().then(
              (_) => Future.delayed(const Duration(milliseconds: 400), () {
                    BlocProvider.of<AppBloc>(context)
                        .add(AppEvent.getPage(pageNum: 2, sportsType: null));
                  }));
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          HomeBloc(messageRepository)..add(HomeEvent.createNewMessage()),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return state.when(
            initial: (_) => _mainContent(context, 0, 0),
            loaded: (data) => _mainContent(context,
                data.counts.unreadBasketball, data.counts.unreadHockey),
            error: (e) {
              /// In case we receive a storage/Hive error, show an error SnackBar post-build
              ErrorSnackBar.showScaffoldSnackBarPostFrame(context, e.message);
              return _mainContent(context, 0, 0);
            });
      }),
    ));
  }

  Widget _mainContent(
      BuildContext context, int basketballUnreadCount, int hockeyUnreadCount) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: CustomAnimatedButton(
                              controller: buttonControllerBasketball,
                              onPressed: () => _onButtonTapped(
                                  context, ButtonType.Basketball),
                              loadingColor: Colors.green,
                              child: _categoryRowItem(
                                  context,
                                  CustomImages.basketballIcon,
                                  Text(
                                    '${basketballUnreadCount < 10 ? basketballUnreadCount : '9+'}',
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width > 700 ? 24 : 18),
                                  )))),
                      CustomAnimatedButton(
                          controller: buttonControllerHockey,
                          onPressed: () =>
                              _onButtonTapped(context, ButtonType.Hockey),
                          loadingColor: Colors.green,
                          child: _categoryRowItem(
                              context,
                              CustomImages.hockeyIcon,
                              Text(
                                '${hockeyUnreadCount < 10 ? hockeyUnreadCount : '9+'}',
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width > 700 ? 24 : 18),
                              ))),
                    ]),
                CustomAnimatedButton(
                    controller: buttonControllerMessages,
                    onPressed: () => _onButtonTapped(context, null),
                    loadingColor: Colors.blue,
                    color: Colors.blueAccent,
                    child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blueAccent),
                        child: Icon(
                          Icons.message,
                          size: 80,
                          color: Colors.white,
                        ))),
              ]),
        ),
      ),
    );
  }

  Widget _categoryRowItem(
      BuildContext context, String iconString, Widget child) {
    final width = MediaQuery.of(context).size.width;
    final containerSize = width / 3;

    return Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        child: Stack(
          children: <Widget>[
            Center(
                child: SvgPicture.asset(
              iconString,
              width: 80,
              height: 80,
              color: Colors.white,
            )),
            Positioned(
                right: 0,
                top: 0,
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).errorColor),
                    width: 40,
                    height: 40,
                    child: Center(child: child)))
          ],
        ));
  }
}
