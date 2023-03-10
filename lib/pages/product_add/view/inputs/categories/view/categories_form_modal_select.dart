import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

import '../cubit/categories_cubit.dart';

class CategoriesFormModalSelect extends StatelessWidget {
  final List<Category> selected;
  final void Function(List<Category>) onChanged;

  const CategoriesFormModalSelect({
    Key? key,
    required this.onChanged,
    required this.selected,
  }) : super(key: key);

  void _selectCategories(BuildContext context) async {
    List<Option>? value = await showModalBottomSheet<List<Option>?>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return BlocProvider(
            create: (context) {
              return CategoriesCubit(
                categoryRepository: CategoryRepository(context.read<HttpClient>()),
              );
            },
            child: _Modal(selected: selected.map((Category e) => Option(key: '${e.id}', name: '${e.name}')).toList()),
          );
        });

    if (value != null) {
      onChanged(value.map((Option o) => Category(id: int.parse(o.key), name: o.name)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: ElevatedColorButton.surface(
        onPressed: () => _selectCategories(context),
        minimumSize: const Size(0, 41),
        padding: const EdgeInsets.symmetric(horizontal: 38),
        textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(AppLocalizations.of(context)!.translate('product:text_select_category')),
      ),
    );
  }
}

class _Modal extends StatefulWidget {
  final List<Option> selected;

  const _Modal({Key? key, required this.selected}) : super(key: key);

  @override
  State<_Modal> createState() => _ModalState();
}

class _ModalState extends State<_Modal> with LoadingMixin {
  @override
  void didChangeDependencies() {
    context.read<CategoriesCubit>().getCategories();
    super.didChangeDependencies();
  }

  List<Option> _preOptions(List<Category>? categories) {
    if (categories == null) return [];
    return categories
        .map((Category e) => Option(key: '${e.id}', name: '${e.name}', options: _preOptions(e.categories)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.8, minHeight: mediaQuery.size.height * 0.5),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        buildWhen: (previous, current) => previous.categories != current.categories,
        builder: (context, state) {
          if (state.loading && state.categories.isEmpty) {
            return Center(child: buildLoading());
          }
          return ModalMultiOptionApply(
            options: _preOptions(state.categories),
            value: widget.selected,
            onChanged: (List<Option> data) {
              Navigator.pop(context, data);
            },
          );
        },
      ),
    );
  }
}
