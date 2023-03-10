part of 'term_cubit.dart';

class TermState {
  final List<OptionTerm> optionTerms;
  final BaseState actionState;
  final int page;

  const TermState({
    this.optionTerms = const [],
    this.actionState = const InitState(),
    this.page = 0,
  });

  List<Object?> get props => [
        optionTerms,
        page,
        actionState,
      ];

  TermState copyWith({
    List<OptionTerm>? optionTerms,
    BaseState? actionState,
    String? titleOption,
    int? page,
  }) {
    return TermState(
      optionTerms: optionTerms ?? this.optionTerms,
      actionState: actionState ?? this.actionState,
      page: page ?? this.page,
    );
  }
}
