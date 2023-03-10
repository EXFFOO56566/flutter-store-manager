// Flutter library
import 'package:flutter/material.dart';

// Bloc
import 'package:category_repository/category_repository.dart';
import 'categories_form_selected.dart';
import 'categories_form_modal_select.dart';

class CategoriesForm extends StatelessWidget {
  final List<Category> selected;
  final void Function(List<Category>) onChanged;

  const CategoriesForm({
    Key? key,
    required this.selected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoriesFormSelected(categories: selected, onChanged: onChanged),
        CategoriesFormModalSelect(onChanged: onChanged, selected: selected)
      ],
    );
  }
}
