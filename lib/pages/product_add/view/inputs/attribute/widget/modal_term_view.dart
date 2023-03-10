import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';
import 'package:flutter_store_manager/constants/languages.dart';
import 'package:flutter_store_manager/settings/settings.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:products_repository/products_repository.dart';
import 'package:ui/widgets/modal_option/button_footer.dart';
import 'package:ui/widgets/modal_option/list_option_multi.dart';
import 'package:ui/widgets/modal_option/modal_option_container.dart';

import '../cubit/term_cubit.dart';

class ModalTermView extends StatelessWidget {
  final int idAttribute;
  final List<OptionTerm> selectTerm;
  final ValueChanged<List<OptionTerm>?> changeTerm;

  const ModalTermView({
    Key? key,
    required this.idAttribute,
    required this.selectTerm,
    required this.changeTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Setting>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) {
            return TermCubit(
              idAttribute: idAttribute,
              lang: supportedLocales[state.locate]?['languageCode'] ?? '',
              productsRepository: ProductsRepository(context.read<HttpClient>()),
              token: context.read<AuthenticationBloc>().state.token,
            );
          },
          child: _ViewTerm(selectTerm: selectTerm, changeTerm: changeTerm),
        );
      },
    );
  }
}

class _ViewTerm extends StatefulWidget {
  final List<OptionTerm> selectTerm;
  final ValueChanged<List<OptionTerm>?> changeTerm;

  const _ViewTerm({
    Key? key,
    required this.selectTerm,
    required this.changeTerm,
  }) : super(key: key);

  @override
  _ViewTermState createState() => _ViewTermState();
}

class _ViewTermState extends State<_ViewTerm> with LoadingMixin {
  late TermCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TermCubit>();
    cubit.getTermAttribute();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermCubit, TermState>(
      builder: (context, state) {
        return state.actionState is! LoadingState && state.optionTerms.isEmpty
            ? NotificationEmptyView(
                icon: CommunityMaterialIcons.star_circle,
                title: AppLocalizations.of(context)!.translate('common:text_no_data'),
              )
            : _ViewListTerm(
                cubit: cubit,
                selected: widget.selectTerm,
                onApply: (List<OptionTerm>? value) => widget.changeTerm(value),
              );
      },
    );
  }
}

class _ViewListTerm extends StatefulWidget {
  final TermCubit cubit;
  final List<OptionTerm> selected;
  final Function(List<OptionTerm>?) onApply;

  const _ViewListTerm({
    Key? key,
    required this.cubit,
    required this.selected,
    required this.onApply,
  }) : super(key: key);

  @override
  State<_ViewListTerm> createState() => _ViewListTermState();
}

class _ViewListTermState extends State<_ViewListTerm> {
  late List<OptionTerm> _value;

  @override
  void initState() {
    _value = widget.selected;
    super.initState();
  }

  Future _loadMore() async {
    await widget.cubit.loadMore();
  }

  Future _refresh() async {
    await widget.cubit.refresh();
  }

  void changeValue(OptionTerm value) {
    setState(() {
      int visit = _value.indexWhere((element) => element.id == value.id);
      bool isSelect = visit > -1;
      if (isSelect) {
        _value.removeAt(visit);
      } else {
        _value.add(value);
      }
    });
  }

  Widget _body(TermState state, BuildContext context) {
    List<OptionTerm> emptyReview = List.generate(10, (index) => OptionTerm(id: 0, name: '')).toList();
    List<OptionTerm> data = state.actionState is LoadingState ? emptyReview : state.optionTerms;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(25, 19, 25, 25),
      itemCount: data.length,
      itemBuilder: (context, index) {
        OptionTerm item = data[index];

        if (item.id == 0) {
          return const ItemOptionLoading();
        }
        Option option = Option(
          key: '${item.id}',
          name: item.name ?? '',
        );

        return ItemOption(
          option: option,
          onClick: (_) => changeValue(item),
          selectOptions: _value
              .map((element) => Option(
                    key: '${element.id}',
                    name: element.name ?? '',
                  ))
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    final canLoadMore = widget.cubit.canLoadMore;

    return ModalOptionContainer(
      footer: ButtonFooter(
        text: translate('common:text_apply'),
        onPressedText: () => widget.onApply(_value),
        textSecondary: translate('common:text_select_all'),
        onPressedTextSecondary: () => widget.onApply(widget.cubit.state.optionTerms),
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
      ),
      isExpand: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: BaseSmartFresher(
          onRefresh: _refresh,
          onLoadMore: canLoadMore ? _loadMore : null,
          child: _body(widget.cubit.state, context),
        ),
      ),
    );
  }
}
