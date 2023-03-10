import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';
import 'package:ui/widgets/modal_option/button_footer.dart';
import 'package:ui/widgets/modal_option/list_option_multi.dart';
import 'package:ui/widgets/modal_option/modal_option_container.dart';

import '../cubit/attribute_cubit.dart';

class AttributePage extends StatelessWidget {
  final VoidCallback onAddCustom;
  final List<Option> selected;
  final ValueChanged<List<Option>?> onAddTerm;

  const AttributePage({
    Key? key,
    required this.onAddCustom,
    required this.onAddTerm,
    this.selected = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AttributeCubit(
          productsRepository: ProductsRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
        );
      },
      child: _AttributeScreen(
        onAddCustom: onAddCustom,
        selected: selected,
        onAddTerm: onAddTerm,
      ),
    );
  }
}

class _AttributeScreen extends StatefulWidget {
  final VoidCallback onAddCustom;
  final ValueChanged<List<Option>?> onAddTerm;
  final List<Option> selected;

  const _AttributeScreen({
    Key? key,
    required this.onAddCustom,
    required this.onAddTerm,
    this.selected = const [],
  }) : super(key: key);

  @override
  _AttributeScreenState createState() => _AttributeScreenState();
}

class _AttributeScreenState extends State<_AttributeScreen> with AppbarMixin, LoadingMixin {
  late AttributeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AttributeCubit>();
    cubit.getAttributes();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<AttributeCubit, AttributeState>(
      builder: (context, state) {
        return state.actionState is! LoadingState && state.attributes.isEmpty
            ? FixedBottom(
                paddingBottom: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                bottom: ElevatedButton(
                  onPressed: () => widget.onAddCustom(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: theme.textTheme.subtitle1?.color,
                    backgroundColor: theme.colorScheme.surface,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(translate('product:text_custom_attribute')),
                ),
                child: NotificationEmptyView(
                  icon: CommunityMaterialIcons.alpha_a_box,
                  title: AppLocalizations.of(context)!.translate('common:text_no_data'),
                ),
              )
            : _ViewListAttribute(
                cubit: cubit,
                selected: widget.selected,
                onApply: (List<Option>? value) {
                  widget.onAddTerm(value);
                },
                onCustom: () => widget.onAddCustom(),
              );
      },
    );
  }
}

class _ViewListAttribute extends StatefulWidget {
  final AttributeCubit cubit;
  final List<Option> selected;
  final Function onCustom;
  final Function(List<Option>?) onApply;

  const _ViewListAttribute({
    Key? key,
    required this.cubit,
    required this.selected,
    required this.onCustom,
    required this.onApply,
  }) : super(key: key);

  @override
  State<_ViewListAttribute> createState() => _ViewListAttributeState();
}

class _ViewListAttributeState extends State<_ViewListAttribute> {
  final List<Option> _value = [];

  Future _loadMore() async {
    await widget.cubit.loadMore();
  }

  Future _refresh() async {
    await widget.cubit.refresh();
  }

  void changeValue(Option value) {
    setState(() {
      int visit = _value.indexWhere((element) => element.key == value.key);
      bool isSelect = visit > -1;
      if (isSelect) {
        _value.removeAt(visit);
      } else {
        _value.add(Option(key: value.key, name: value.name));
      }
    });
  }

  Widget _body(AttributeState state, BuildContext context) {
    List<Option> emptyReview = List.generate(10, (index) => const Option(key: '0', name: '')).toList();
    List<Option> date = state.actionState is LoadingState
        ? emptyReview
        : state.attributes
            .map((e) => Option(
                  key: e.key,
                  name: e.name,
                  enabled: widget.selected.indexWhere((element) => element.key == e.key) < 0,
                ))
            .toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(25, 19, 25, 25),
      itemCount: date.length,
      itemBuilder: (context, index) {
        final item = date[index];
        if (item.key == '0') {
          return const ItemOptionLoading();
        }
        return ItemOption(
          option: item,
          onClick: changeValue,
          selectOptions: [
            ...widget.selected,
            ..._value,
          ],
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
        textSecondary: translate('product:text_custom_attribute'),
        onPressedTextSecondary: () => widget.onCustom(),
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
