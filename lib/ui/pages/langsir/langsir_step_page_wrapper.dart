import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_event.dart';
import 'package:newbkmmobile/repositories/langsir_repository.dart';
import 'langsir_step_page.dart';

class LangsirStepPageWrapper extends StatelessWidget {
  final String id;

  const LangsirStepPageWrapper({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LangsirBloc(LangsirRepository())
        ..add(FetchLangsirDetail(id)),
      child: LangsirStepPage(id: id),
    );
  }
}
