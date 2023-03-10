import 'package:flutter/material.dart';
import 'package:ui/models/option.dart';

import '../input/input_search_field.dart';

import 'list_option_single.dart';
import 'modal_option_container.dart';

class ModalOptionSingleView extends StatefulWidget {
  final List<Option> options;
  final String? value;
  final ValueChanged<String> onChanged;
  final bool isExpand;
  final bool isSearch;
  final String? hintTextSearch;

  const ModalOptionSingleView({
    Key? key,
    required this.options,
    this.value,
    required this.onChanged,
    this.isExpand = false,
    this.isSearch = false,
    this.hintTextSearch,
  })  : assert(options.length > 0),
        super(key: key);

  @override
  State<ModalOptionSingleView> createState() => _ModalOptionSingleViewState();
}

class _ModalOptionSingleViewState extends State<ModalOptionSingleView> {
  String _valueSearch = '';

  void changeSearch(String search) {
    setState(() {
      _valueSearch = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Option> options = _valueSearch.isEmpty
        ? widget.options
        : widget.options
            .where((element) =>
                element.key.toLowerCase().contains(_valueSearch.toLowerCase()) ||
                element.name.toLowerCase().contains(_valueSearch.toLowerCase()))
            .toList();

    return ModalOptionContainer(
      search: widget.isSearch
          ? Padding(
              padding: const EdgeInsets.fromLTRB(25, 17, 25, 5),
              child: InputSearchField(
                initialValue: _valueSearch,
                onChanged: changeSearch,
                hintText: widget.hintTextSearch,
              ),
            )
          : null,
      isExpand: widget.isExpand,
      padding: const EdgeInsets.only(top: 15),
      child: ListOptionSingle(
        data: options,
        keySelected: widget.value,
        clickSelect: widget.onChanged,
        padding: const EdgeInsets.fromLTRB(25, 19, 25, 25),
      ),
    );
  }
}
