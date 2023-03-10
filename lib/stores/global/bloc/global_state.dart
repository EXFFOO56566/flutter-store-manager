part of 'global_bloc.dart';

class GlobalState extends Equatable {
  const GlobalState({
    this.stores = const {},
  });

  final Map<String, Equatable> stores;

  GlobalState copyWith({
    required String key,
    required Equatable store,
  }) {
    Map<String, Equatable> stores = Map<String, Equatable>.of(this.stores);
    stores[key] = store;
    return GlobalState(
      stores: stores,
    );
  }

  @override
  List<Object> get props => [stores];
}
