import 'package:community_material_icon/community_material_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';

class VariationItem extends StatefulWidget {
  final int idProduct;
  final dynamic data;
  final ValueChanged<int> onDelete;
  final Function(Map<String, dynamic> data) onEdit;

  const VariationItem({
    Key? key,
    required this.idProduct,
    this.data,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  VariationItemState createState() => VariationItemState();
}

class VariationItemState extends State<VariationItem> with SnackMixin, LoadingMixin, VariationMixin {
  bool _loading = false;

  Future<void> _onDelete(int idVariation, BuildContext context, TranslateType translate) async {
    String? value = await showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('common:text_delete')),
          content: Text(translate('product:text_content_remove', {'name': '#$idVariation'})),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context), child: Text(translate('common:text_cancel'))),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(translate('common:text_ok')),
            ),
          ],
        );
      },
    );
    if (value == 'OK') {
      setState(() {
        _loading = true;
      });
      if (mounted) deleteVariation(idVariation, context, translate);
    }
  }

  deleteVariation(int idVariation, BuildContext context, TranslateType translate) async {
    try {
      await ProductsRepository(context.read<HttpClient>()).deleteVariation(
        idProduct: widget.idProduct,
        idVariation: idVariation,
        requestData: RequestData(
          query: {"app-builder-decode": true},
          token: context.read<AuthenticationBloc>().state.token,
        ),
      );
      setState(() {
        _loading = false;
      });
      widget.onDelete(idVariation);
      if (mounted) showSuccess(context, translate('message:text_delete_variation_success', {'number': '$idVariation'}));
    } on DioError catch (e) {
      setState(() {
        _loading = false;
      });
      String? message = e.response != null && e.response?.data != null ? e.response?.data['message'] : e.message;
      showError(context, message ?? translate('message:text_delete_variation_fail', {'number': '#$idVariation'}));
    }
  }

  String textAttribute() {
    List<String> value = [];
    if (widget.data is Map) {
      final attributes = widget.data['attributes'];
      if (attributes is List) {
        for (int i = 0; i < attributes.length; i++) {
          dynamic option = attributes[i];
          if (option is Map && option['name'] is String && option['option'] is String) {
            value.add('${option['name']}: ${option['option']}');
          }
        }
      }
    }
    return value.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    bool loading = !(widget.data is Map && ConvertData.stringToInt(widget.data['id']) > 0);

    int idVariation = loading ? 0 : ConvertData.stringToInt(widget.data['id']);
    String attribute = textAttribute();

    return VariationItemUi(
      title: buildTitle(
        title: TextButton(
          onPressed: () => widget.onEdit(widget.data),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: AlignmentDirectional.centerStart,
            minimumSize: Size.zero,
          ),
          child: Text('#$idVariation'),
        ),
        theme: theme,
        isLoading: loading,
      ),
      attribute: loading || (!loading && attribute.isNotEmpty)
          ? buildAttribute(text: attribute, theme: theme, isLoading: loading)
          : null,
      buttonDelete: buildButtonDelete(
        child: _loading
            ? buildLoading(radius: 10)
            : InkResponse(
                onTap: () => _onDelete(idVariation, context, translate),
                radius: 25,
                child: const Icon(CommunityMaterialIcons.trash_can),
              ),
        isLoading: loading,
      ),
    );
  }
}
