import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_search_field.dart';
import 'package:mousa_store/features/search/view/search_view.dart';
import 'package:mousa_store/features/search/view_model/search_cubit.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) => AppSearchField(
    readOnly: true,
    hint: context.l10n.search_text(context.l10n.app_name),
    onTap: () {
      unawaited(
        navigateWithTransition<void>(
          context,
          BlocProvider(
            create: (context) => getIt<SearchCubit>(),
            child: const SearchView(),
          ),
        ),
      );
    },
  );
}
