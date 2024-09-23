part of 'card_cubit.dart';


sealed class CardState {}

final class CardInitial extends CardState {}

final class CardLoadedData extends CardState {}
final class CardLoadedEmptyData extends CardState {}
