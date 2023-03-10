part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class GlobalStoreChanged extends GlobalEvent {
  const GlobalStoreChanged(this.key, this.store);

  final String key;
  final Equatable store;

  @override
  List<Object> get props => [store];
}
