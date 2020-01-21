import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Counts extends Equatable {
  final int unreadBasketball;
  final int unreadHockey;

  const Counts({@required this.unreadBasketball, @required this.unreadHockey});

  @override
  List get props => [unreadBasketball, unreadHockey];
}
