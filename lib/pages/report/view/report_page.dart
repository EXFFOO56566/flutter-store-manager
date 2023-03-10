// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:reports_repository/reports_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/pages/home/report_stats/bloc/report_stats_cubit.dart';

// View
import 'package:flutter_store_manager/themes.dart';
import 'widgets/report_page_body.dart';

class ReportPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/ReportPage';

  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('home:text_report')),
      backgroundColor: theme.canvasColor,
      body: BlocProvider<ReportStatsCubit>(
        create: (_) => ReportStatsCubit(
          reportsRepository: ReportsRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
        ),
        child: const ReportPageBody(),
      ),
    );
  }
}
