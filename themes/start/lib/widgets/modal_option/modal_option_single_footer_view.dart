import 'package:flutter/material.dart';
import 'package:ui/models/option.dart';

import '../input/input_search_field.dart';

import 'button_footer.dart';
import 'list_option_single.dart';
import 'modal_option_container.dart';

class ModalOptionSingleFooterView extends StatefulWidget {
  final List<Option> options;
  final String? value;
  final bool isExpand;
  final bool isSearch;
  final String? hintTextSearch;
  final String? textButtonBottom;
  final ValueChanged<String?> onPressButton;
  final String? textSecondaryButton;
  final ValueChanged<String?>? onPressSecondaryButton;

  const ModalOptionSingleFooterView({
    Key? key,
    required this.options,
    this.value,
    this.isExpand = false,
    this.isSearch = false,
    this.hintTextSearch,
    this.textButtonBottom,
    required this.onPressButton,
    this.textSecondaryButton,
    this.onPressSecondaryButton,
  })  : assert(options.length > 0),
        super(key: key);

  @override
  State<ModalOptionSingleFooterView> createState() => _ModalOptionSingleFooterViewState();
}

class _ModalOptionSingleFooterViewState extends State<ModalOptionSingleFooterView> {
  String _valueSearch = '';
  String? _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  void changeSearch(String search) {
    setState(() {
      _valueSearch = search;
    });
  }

  void changeValue(String value) {
    setState(() {
      _value = value;
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
      footer: ButtonFooter(
        text: widget.textButtonBottom ?? 'Apply',
        onPressedText: () => widget.onPressButton(_value),
        textSecondary: widget.textSecondaryButton,
        onPressedTextSecondary:
            widget.onPressSecondaryButton != null ? () => widget.onPressSecondaryButton!.call(_value) : null,
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
      ),
      isExpand: widget.isExpand,
      padding: const EdgeInsets.only(top: 15),
      child: ListOptionSingle(
        data: options,
        keySelected: _value,
        clickSelect: changeValue,
        padding: const EdgeInsets.fromLTRB(25, 19, 25, 10),
      ),
    );
  }
}
