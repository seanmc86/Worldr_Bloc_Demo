import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldr_task/bloc/app/bloc.dart';
import 'package:worldr_task/core/errors/global_messages.dart';
import 'package:worldr_task/entity/person/person.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final SportsType sportsType;

  const CustomTabBar(
      {Key key, @required this.tabController, @required this.sportsType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _tabs;
    switch (sportsType) {
      case SportsType.Basketball:
        _tabs = [
          _activeTab(GlobalMessages.sportsTitleBasketball),
          _inactiveTab(GlobalMessages.sportsTitleHockey)
        ];
        break;
      case SportsType.Hockey:
        _tabs = [
          _inactiveTab(GlobalMessages.sportsTitleBasketball),
          _activeTab(GlobalMessages.sportsTitleHockey)
        ];
        break;
      default:
        _tabs = [
          _activeTab(GlobalMessages.sportsTitleBasketball),
          _inactiveTab(GlobalMessages.sportsTitleHockey)
        ];
        break;
    }
    return TabBar(
        labelPadding: EdgeInsets.all(0),
        controller: tabController,
        onTap: (index) => BlocProvider.of<AppBloc>(context).add(
            AppEvent.getPage(
                pageNum: 1,
                sportsType:
                    index == 0 ? SportsType.Basketball : SportsType.Hockey)),
        tabs: _tabs);
  }

  Widget _activeTab(String title) {
    return Container(
        height: 80,
        color: Colors.white,
        child: Tab(
            child: Center(
                child: Text(title,
                    style: TextStyle(fontSize: 24, color: Colors.green)
                        .copyWith(decoration: TextDecoration.underline)))));
  }

  Widget _inactiveTab(String title) {
    return Container(
        color: Colors.green,
        child: Tab(
            child: Center(
                child: Text(title,
                    style: TextStyle(fontSize: 24, color: Colors.white)))));
  }
}
