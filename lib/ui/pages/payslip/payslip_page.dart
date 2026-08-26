import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newbkmmobile/blocs/payslip/payslip_bloc.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/core/library/month_picker_dialog/month_picker_dialog.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/payslip_repository.dart';
import 'package:newbkmmobile/ui/widgets/space_between_horizontal_text.dart';

class PaySlipPage extends StatefulWidget {
  const PaySlipPage({Key? key}) : super(key: key);

  @override
  State<PaySlipPage> createState() => _PaySlipPageState();
}

class _PaySlipPageState extends State<PaySlipPage> {
  final _paySlipBloc = PaySlipBloc(PaySlipRepository());
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime.now();
    _paySlipBloc.add(PaySlip(month: selectedDateTime.month, year: selectedDateTime.year));
  }

  @override
  void dispose() {
    _paySlipBloc.close();
    super.dispose();
  }

  /// Helper untuk memformat angka / string uang secara aman tanpa throw exception jika null / corrupt
  String _formatCurrency(dynamic value) {
    if (value == null) return "0.00";
    try {
      final double numVal;
      if (value is num) {
        numVal = value.toDouble();
      } else {
        final cleanString = value.toString().replaceAll(',', '').trim();
        numVal = double.tryParse(cleanString) ?? 0.0;
      }
      return NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(numVal);
    } catch (_) {
      return "0.00";
    }
  }

  // Fungsi helper untuk membuat desain Card yang seragam
  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF002B4C),
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
          const SizedBox(height: 12.0),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        centerTitle: true,
        title: Text(
          R.strings.titlePaySlipPage,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 HEADER & DATE PICKER (Selalu Muncul)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              decoration: const BoxDecoration(
                color: darkBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    R.strings.aturTanggal,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFFF9800),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showMonthPicker(
                        context: context,
                        initialDate: selectedDateTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            selectedDateTime = date;
                            _paySlipBloc.add(PaySlip(month: selectedDateTime.month, year: selectedDateTime.year));
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_outlined, color: R.colors.greenLogo, size: 18),
                          const SizedBox(width: 8.0),
                          Text(
                            "${Constants.listMonthIndonesia[(selectedDateTime.month - 1).clamp(0, 11)]} ${selectedDateTime.year}",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: R.colors.greenLogo,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Icon(Icons.keyboard_arrow_down, color: R.colors.greenLogo, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 KONTEN SLIP GAJI
            Expanded(
              child: BlocBuilder<PaySlipBloc, PaySlipState>(
                bloc: _paySlipBloc,
                builder: (context, state) {
                  if (state is PaySlipInitial || state is PaySlipLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: R.colors.greenLogo),
                    );
                  } else if (state is PaySlipSuccess) {
                    final data = state.payslipData;
                    final payroll = data.payroll;
                    final incomes = data.incomes;
                    final deductions = data.deductions;

                    // Cek jika seluruh objek kosong/null
                    if (payroll == null && incomes.isEmpty && deductions.isEmpty) {
                      return _buildEmptyState("Belum ada catatan slip gaji\nuntuk periode ini.");
                    }

                    final grossSalaryFormatted = _formatCurrency(payroll?.grossSalary);
                    final totalDeductionFormatted = _formatCurrency(payroll?.totalDeduction);
                    final netSalaryFormatted = _formatCurrency(payroll?.netSalary);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(height: 8),

                                // 🔹 KARTU PENDAPATAN (Dinamis dari list incomes)
                                _buildSectionCard(
                                  title: R.strings.pendapatan,
                                  children: [
                                    if (incomes.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Text(
                                          "Tidak ada rincian pendapatan",
                                          style: TextStyle(
                                            fontSize: 13.5,
                                            color: Colors.grey.shade500,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      )
                                    else
                                      ...incomes.map((income) {
                                        final itemTitle = (income.description != null && income.description!.trim().isNotEmpty)
                                            ? income.description!
                                            : "Pendapatan";
                                        final qtyVal = int.tryParse(income.qty?.toString() ?? '');
                                        final titleWithQty = (qtyVal != null && qtyVal > 1)
                                            ? "$itemTitle (${income.qty}x)"
                                            : itemTitle;

                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 14.0),
                                          child: SpaceBetweenHorizontalText(
                                            title: titleWithQty,
                                            content: _formatCurrency(income.amount),
                                            colorTitle: R.colors.colorText,
                                            colorContent: R.colors.colorText,
                                            fontSizeTitle: 14.0,
                                            fontSizeContent: 14.0,
                                            fontWeightTitle: FontWeight.normal,
                                            fontWeightContent: FontWeight.bold,
                                          ),
                                        );
                                      }).toList(),
                                    Container(color: Colors.grey.shade200, height: 1.0),
                                    const SizedBox(height: 12.0),
                                    SpaceBetweenHorizontalText(
                                      title: R.strings.total,
                                      content: "+$grossSalaryFormatted",
                                      colorTitle: R.colors.colorText,
                                      colorContent: R.colors.greenLogo,
                                      fontSizeTitle: 14.0,
                                      fontSizeContent: 15.0,
                                      fontWeightTitle: FontWeight.bold,
                                      fontWeightContent: FontWeight.bold,
                                    ),
                                  ],
                                ),

                                // 🔹 KARTU POTONGAN (Dinamis dari list deductions)
                                _buildSectionCard(
                                  title: R.strings.potongan,
                                  children: [
                                    if (deductions.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Text(
                                          "Tidak ada potongan",
                                          style: TextStyle(
                                            fontSize: 13.5,
                                            color: Colors.grey.shade500,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      )
                                    else
                                      ...deductions.map((deduction) {
                                        final itemTitle = (deduction.description != null && deduction.description!.trim().isNotEmpty)
                                            ? deduction.description!
                                            : "Potongan";

                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 14.0),
                                          child: SpaceBetweenHorizontalText(
                                            title: itemTitle,
                                            content: _formatCurrency(deduction.amount),
                                            colorTitle: R.colors.colorText,
                                            colorContent: R.colors.colorText,
                                            fontSizeTitle: 14.0,
                                            fontSizeContent: 14.0,
                                            fontWeightTitle: FontWeight.normal,
                                            fontWeightContent: FontWeight.bold,
                                          ),
                                        );
                                      }).toList(),
                                    Container(color: Colors.grey.shade200, height: 1.0),
                                    const SizedBox(height: 12.0),
                                    SpaceBetweenHorizontalText(
                                      title: R.strings.total,
                                      content: "-$totalDeductionFormatted",
                                      colorTitle: R.colors.colorText,
                                      colorContent: Colors.redAccent,
                                      fontSizeTitle: 14.0,
                                      fontSizeContent: 15.0,
                                      fontWeightTitle: FontWeight.bold,
                                      fontWeightContent: FontWeight.bold,
                                    ),
                                  ],
                                ),

                                // 🔹 KARTU INFO
                                _buildSectionCard(
                                  title: R.strings.info,
                                  children: [
                                    SpaceBetweenHorizontalText(
                                      title: R.strings.jmlPerjalanan,
                                      content: "${payroll?.numberOfTrip ?? 0} Trip",
                                      colorTitle: R.colors.colorText,
                                      colorContent: R.colors.colorText,
                                      fontSizeTitle: 14.0,
                                      fontSizeContent: 14.0,
                                      fontWeightTitle: FontWeight.normal,
                                      fontWeightContent: FontWeight.bold,
                                    ),
                                    if (payroll?.driver?.name != null && payroll!.driver!.name!.trim().isNotEmpty) ...[
                                      const SizedBox(height: 14.0),
                                      SpaceBetweenHorizontalText(
                                        title: "Nama Driver",
                                        content: payroll!.driver!.name!.trim(),
                                        colorTitle: R.colors.colorText,
                                        colorContent: R.colors.colorText,
                                        fontSizeTitle: 14.0,
                                        fontSizeContent: 14.0,
                                        fontWeightTitle: FontWeight.normal,
                                        fontWeightContent: FontWeight.bold,
                                      ),
                                    ],
                                    if (payroll?.driver?.rekeningNumber != null && payroll!.driver!.rekeningNumber!.trim().isNotEmpty) ...[
                                      const SizedBox(height: 14.0),
                                      SpaceBetweenHorizontalText(
                                        title: "No. Rekening",
                                        content: payroll!.driver!.rekeningNumber!.trim(),
                                        colorTitle: R.colors.colorText,
                                        colorContent: R.colors.colorText,
                                        fontSizeTitle: 14.0,
                                        fontSizeContent: 14.0,
                                        fontWeightTitle: FontWeight.normal,
                                        fontWeightContent: FontWeight.bold,
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),

                        // 🔹 KARTU NETTO GAJI (Bottom Fixed Bar)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                          decoration: BoxDecoration(
                            color: R.colors.greenLogo,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, -4),
                              ),
                            ],
                          ),
                          child: SafeArea(
                            top: false,
                            child: SpaceBetweenHorizontalText(
                              title: R.strings.nettoGaji,
                              content: "${R.strings.rp} $netSalaryFormatted",
                              colorTitle: Colors.white,
                              colorContent: Colors.white,
                              fontSizeTitle: 16.0,
                              fontSizeContent: 18.0,
                              fontWeightTitle: FontWeight.bold,
                              fontWeightContent: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (state is PaySlipError) {
                    final message = state.message.isNotEmpty
                        ? state.message
                        : "Belum ada catatan slip gaji\nuntuk bulan ini.";
                    return _buildEmptyState(message);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    const darkBlue = Color(0xFF002B4C);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              color: Colors.grey.shade400,
              size: 60.0,
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            "Tidak ada data",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}