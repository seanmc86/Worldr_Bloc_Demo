import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:worldr_task/bloc/app/bloc.dart';
import 'package:worldr_task/core/errors/global_messages.dart';
import 'package:worldr_task/core/widgets/custom_header_bar.dart';
import 'package:worldr_task/core/widgets/custom_tab_bar.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/person/person.dart';
import 'package:worldr_task/screens/home/home_screen.dart';
import 'package:worldr_task/screens/messages/message_screen.dart';
import 'package:worldr_task/screens/people/people_screen.dart';

class AppScaffold extends StatefulWidget {
  final MessageRepository messageRepository;

  const AppScaffold({Key key, @required this.messageRepository})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold>
    with TickerProviderStateMixin {
  HomeScreen _homeScreen;
  PeopleScreen _peopleScreen;
  MessageScreen _messageScreen;

  TabController _tabController;
  Animation<Offset> _headerAnimationVertical;
  Animation<Offset> _headerAnimationHorizontal;
  AnimationController _headerAnimationControllerVertical;
  AnimationController _headerAnimationControllerHorizontal;

  AnimationController _homeButtonControllerBasketball;
  AnimationController _homeButtonControllerHockey;
  AnimationController _homeButtonControllerMessages;

  @override
  void initState() {
    super.initState();
    _setupControllers();
    _setupChildScreens();
  }

  _setupControllers() {
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);

    /// Controls the vertical header (tab bar) which moves up and down
    _headerAnimationControllerVertical =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _headerAnimationVertical =
        Tween<Offset>(begin: Offset(0, -160), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: _headerAnimationControllerVertical,
      curve: Interval(.4, 1.0, curve: Curves.easeOutBack),
    ));

    /// Controls the horizontal header (messages bar) which moves left and right
    _headerAnimationControllerHorizontal =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    /// An initial value of 1200 covers most device widths
    _headerAnimationHorizontal =
        Tween<Offset>(begin: Offset(1200, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: _headerAnimationControllerHorizontal,
      curve: Interval(.4, 1.0, curve: Curves.easeOutBack),
    ));

    /// Animation controllers for the home screen buttons
    /// Another way of doing this would be to setup one controller
    /// and then give it three children with a List/Map of values
    /// to be delegated to each one
    _homeButtonControllerBasketball = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _homeButtonControllerHockey = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _homeButtonControllerMessages = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  _setupChildScreens() {
    _homeScreen = HomeScreen(
      messageRepository: widget.messageRepository,
      buttonControllerBasketball: _homeButtonControllerBasketball,
      buttonControllerHockey: _homeButtonControllerHockey,
      buttonControllerMessages: _homeButtonControllerMessages,
    );
    _peopleScreen = PeopleScreen(messageRepository: widget.messageRepository);
    _messageScreen = MessageScreen(messageRepository: widget.messageRepository);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return state.when(
          initial: (_) => _initialState(),
          loadedMessages: (data) => _loadedState(
              data.pageNum, data.filtedByGuid, data.filterBySportsType),
          loaded: (data) => _loadedState(data.pageNum, null, data.sportsType));
    }));
  }

  Widget _initialState() {
    return Scaffold(
        bottomNavigationBar: _buildBottomNavigationBar(0), body: _homeScreen);
  }

  Widget _loadedState(int pageNum, String guid, SportsType sportsType) {
    return Scaffold(
        bottomNavigationBar: _buildBottomNavigationBar(pageNum),
        body: _bodyContent(pageNum, guid, sportsType));
  }

  Widget _bodyContent(int pageNum, String guid, SportsType sportsType) {
    switch (pageNum) {
      case 1:
        return _peopleContent(sportsType);
        break;
      case 2:
        return _messageContent(guid, sportsType);
        break;
      default:
        return _homeContent(sportsType);
        break;
    }
  }

  Widget _peopleContent(SportsType sportsType) {
    _peopleScreen = PeopleScreen(
        sportsType: sportsType, messageRepository: widget.messageRepository);
    if (_headerAnimationControllerHorizontal.value == 1.0) {
      _headerAnimationControllerHorizontal.reverse();
    }
    _headerAnimationControllerVertical.forward();
    return Stack(children: <Widget>[
      _peopleScreen,
      _buildHeaderBarHorizontal(sportsType),
      _buildHeaderBarVertical(sportsType)
    ]);
  }

  Widget _messageContent(String guid, SportsType sportsType) {
    _messageScreen = MessageScreen(
        filterByGuid: guid,
        filterBySportsType: sportsType,
        messageRepository: widget.messageRepository);
    if (_headerAnimationControllerHorizontal.value == 0.0) {
      _headerAnimationControllerVertical.reverse();
    }
    _headerAnimationControllerHorizontal.forward();
    return Stack(children: <Widget>[
      _messageScreen,
      _buildHeaderBarVertical(sportsType),
      _buildHeaderBarHorizontal(sportsType),
    ]);
  }

  Widget _homeContent(SportsType sportsType) {
    if (_headerAnimationControllerVertical.value == 1.0) {
      _headerAnimationControllerVertical.reverse();
    }
    if (_headerAnimationControllerHorizontal.value == 1.0) {
      _headerAnimationControllerHorizontal.reverse();
    }
    return Stack(children: <Widget>[
      _homeScreen,
      _buildHeaderBarHorizontal(sportsType),
      _buildHeaderBarVertical(sportsType)
    ]);
  }

  Widget _buildHeaderBarVertical(SportsType sportsType) {
    return CustomHeaderBar(
      animation: _headerAnimationVertical,
      padding: EdgeInsets.all(0),
      titleBar: Container(
          color: Colors.green,
          height: 80,
          child: CustomTabBar(
              tabController: _tabController, sportsType: sportsType)),
    );
  }

  Widget _buildHeaderBarHorizontal(SportsType sportsType) {
    return CustomHeaderBar(
      animation: _headerAnimationHorizontal,
      padding: EdgeInsets.all(0),
      titleBar: Container(
          color: Colors.blueAccent.withOpacity(0.8),
          height: 80,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () =>
                      BlocProvider.of<AppBloc>(context).add(AppEvent.goBack()),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  GlobalMessages.messagesScreenTitle,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildBottomNavigationBar(int index) {
    return BottomNavigationBar(
      items: [
        _generateNavBarItem(
            context, GlobalMessages.homeScreenTitle, Icons.home),
        _generateNavBarItem(
            context, GlobalMessages.peopleScreenTitle, Icons.fitness_center),
        _generateNavBarItem(
            context, GlobalMessages.messagesScreenTitle, Icons.message)
      ],
      backgroundColor: Colors.black,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.white,
      currentIndex: index,
      onTap: (index) => BlocProvider.of<AppBloc>(context).add(AppEvent.getPage(
          pageNum: index,
          sportsType: index == 1 ? SportsType.Basketball : null)),
    );
  }

  BottomNavigationBarItem _generateNavBarItem(
      BuildContext context, String titleString, IconData iconData) {
    return BottomNavigationBarItem(
        title: Text(titleString),
        icon: Container(
          height: 36,
          child: Icon(iconData, size: 24.0),
        ));
  }
}
