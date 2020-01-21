// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class PersonEvent extends Equatable {
  const PersonEvent(this._type);

  factory PersonEvent.getPersons() = GetPersons;

  factory PersonEvent.getPersonsForType({@required SportsType sportsType}) =
      GetPersonsForType;

  final _PersonEvent _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(GetPersons) getPersons,
      @required FutureOr<R> Function(GetPersonsForType) getPersonsForType}) {
    assert(() {
      if (getPersons == null || getPersonsForType == null)
        throw 'check for all possible cases';
      return true;
    }());
    switch (this._type) {
      case _PersonEvent.GetPersons:
        return getPersons(this as GetPersons);
      case _PersonEvent.GetPersonsForType:
        return getPersonsForType(this as GetPersonsForType);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(GetPersons) getPersons,
      FutureOr<R> Function(GetPersonsForType) getPersonsForType,
      @required FutureOr<R> Function(PersonEvent) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _PersonEvent.GetPersons:
        if (getPersons == null) break;
        return getPersons(this as GetPersons);
      case _PersonEvent.GetPersonsForType:
        if (getPersonsForType == null) break;
        return getPersonsForType(this as GetPersonsForType);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(GetPersons) getPersons,
      FutureOr<void> Function(GetPersonsForType) getPersonsForType}) {
    assert(() {
      if (getPersons == null && getPersonsForType == null)
        throw 'provide at least one branch';
      return true;
    }());
    switch (this._type) {
      case _PersonEvent.GetPersons:
        if (getPersons == null) break;
        return getPersons(this as GetPersons);
      case _PersonEvent.GetPersonsForType:
        if (getPersonsForType == null) break;
        return getPersonsForType(this as GetPersonsForType);
    }
  }

  @override
  List get props => const [];
}

@immutable
class GetPersons extends PersonEvent {
  const GetPersons._() : super(_PersonEvent.GetPersons);

  factory GetPersons() {
    _instance ??= GetPersons._();
    return _instance;
  }

  static GetPersons _instance;
}

@immutable
class GetPersonsForType extends PersonEvent {
  const GetPersonsForType({@required this.sportsType})
      : super(_PersonEvent.GetPersonsForType);

  final SportsType sportsType;

  @override
  String toString() => 'GetPersonsForType(sportsType:${this.sportsType})';
  @override
  List get props => [sportsType];
}
