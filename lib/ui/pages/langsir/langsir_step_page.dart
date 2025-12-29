import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_event.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_state.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/models/langsir_detail/local_hauling_detail_data.dart';
import 'langsir_form_page.dart';

class LangsirStepPage extends StatelessWidget {
  final String id;
  final ConvertDate _convertDate = ConvertDate();

  LangsirStepPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangsirBloc, LangsirState>(
      builder: (context, state) {
        if (state is LangsirLoading) {
          return Scaffold(
            body: Center(
              child: Image.asset(
                'assets/bkm_logo_animation.gif',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          );
        }


        if (state is LangsirFailure) {
          return Scaffold(
            body: Center(child: Text(state.error)),
          );
        }

        if (state is LangsirDetailLoaded) {
          return _buildContent(context, state.detail);
        }

        return const Scaffold(body: SizedBox());
      },
    );
  }

  // ================= UI CONTENT =================

  Widget _buildContent(
      BuildContext context,
      LocalHaulingDetailData data,
      ) {
    final Color darkBlue = const Color(0xFF002B4C);
    final Color orange = const Color(0xFFE55300);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Langsir',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: darkBlue,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFF2C4A64),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      body: Column(
        children: [
          _header(context, data, darkBlue, orange),
          _stepList(data, darkBlue),
        ],
      ),
    );
  }

  // ================= HEADER =================

  Widget _header(
      BuildContext context,
      LocalHaulingDetailData data,
      Color darkBlue,
      Color orange,
      ) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.doNumber ?? "-",
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "${data.pks?.code ?? "-"} → ${data.destination?.code ?? "-"}",
                        style: TextStyle(
                          color: orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " | ${data.commodity?.code ?? '-'}",
                        style: TextStyle(color: orange),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _convertDate.formatToDayMonthYear(data.doDate) ?? "-",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // ===== BUTTON (+) =====
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                final shouldRefresh = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => LangsirBloc(
                        context.read<LangsirBloc>().repository, // pakai repo yang sama
                      ),
                      child: LangsirFormPage(data: data),
                    ),
                  ),
                );

                if (shouldRefresh == true) {
                  context
                      .read<LangsirBloc>()
                      .add(FetchLangsirDetail(data.id ?? ""));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= STEP LIST =================

  Widget _stepList(
      LocalHaulingDetailData data,
      Color darkBlue,
      ) {
    final steps = data.doDetails ?? [];

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final s = steps[index];

          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              final shouldRefresh = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => LangsirBloc(
                      context.read<LangsirBloc>().repository,
                    ),
                    child: LangsirFormPage(
                      data: data,                 // data header
                      detailItemId: s.id,               // ⬅️ MODE EDIT
                    ),
                  ),
                ),
              );

              if (shouldRefresh == true) {
                context
                    .read<LangsirBloc>()
                    .add(FetchLangsirDetail(data.id ?? ""));
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: darkBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      children: [
                        _stepItem(
                          "Jumlah Muat",
                          s.loadQuantity?.toString() ?? "-",
                          "Tanggal Muat",
                          _convertDate
                              .formatToDayMonthYear(s.loadDate) ??
                              "-",
                          darkBlue,
                        ),
                        _stepItem(
                          "Jumlah Bongkar",
                          s.unloadQuantity?.toString() ?? "-",
                          "Tanggal Bongkar",
                          _convertDate
                              .formatToDayMonthYear(s.unloadDate) ??
                              "-",
                          darkBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _stepItem(
      String title1,
      String value1,
      String title2,
      String value2,
      Color darkBlue,
      ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title1,
              style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 2),
          Text(value1,
              style: TextStyle(
                  color: darkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
          const SizedBox(height: 4),
          Text(title2,
              style: const TextStyle(color: Colors.grey, fontSize: 11)),
          Text(value2,
              style: TextStyle(
                  color: darkBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
