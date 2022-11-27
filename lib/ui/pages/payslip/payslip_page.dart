import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:newbkmmobile/blocs/payslip/payslip_bloc.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/payslip_repository.dart';
import 'package:newbkmmobile/ui/widgets/pair_horizontal_text.dart';

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
    var date = DateTime.now().toString();
    selectedDateTime = DateTime.parse(date);
    _paySlipBloc.add(PaySlip(month: selectedDateTime.month, year: selectedDateTime.year));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titlePaySlipPage),
      ),
      body: BlocBuilder<PaySlipBloc, PaySlipState>(
        bloc: _paySlipBloc,
        builder: (context, state) {
          if (state is PaySlipInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaySlipLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaySlipSuccess) {
            var isAdjustmentPlus = false;
            var isAdjustmentMinus = false;

            var salaryTrip = double.parse(state.paySlipResp.salaryTrip ?? "0");
            var bonusTrip = double.parse(state.paySlipResp.bonusTrip ?? "0");
            var thr = double.parse(state.paySlipResp.thr ?? "0");
            var insentif = double.parse(state.paySlipResp.insentif ?? "0");
            var bonusDecrease = double.parse(state.paySlipResp.bonusDecrease ?? "0");
            var totalIncome = salaryTrip + bonusTrip + thr + insentif + bonusDecrease;

            var bpjsKet = double.parse(state.paySlipResp.bpjsKet ?? "0");
            var bpjsKes = double.parse(state.paySlipResp.bpjsKes ?? "0");
            var pph21 = double.parse(state.paySlipResp.pph21 ?? "0");
            var totalDeduction = bpjsKet + bpjsKes;

            var deptPayment = double.parse(state.paySlipResp.deptPayment ?? "0");
            var loanPayment = double.parse(state.paySlipResp.loanPayment ?? "0");
            var totalExpense = deptPayment + loanPayment;

            var saving = double.parse(state.paySlipResp.saving ?? "0");
            var remainingLoan = double.parse(state.paySlipResp.remainingLoan ?? "0");
            var remainingDept = double.parse(state.paySlipResp.remainingDept ?? "0");

            var total1 = salaryTrip + bonusTrip + thr + insentif + bonusDecrease;
            var total2 = bpjsKet + bpjsKes + pph21;
            var total3 = deptPayment + loanPayment;
            var thp = total1 - total2 - total3;

            double adjustment = 0;
            if (state.paySlipResp.adjustment != null) {
              adjustment = double.parse(state.paySlipResp.adjustment ?? "0");
              thp = thp + adjustment;
              if (adjustment > 0) {
                totalIncome = totalIncome + adjustment;
                isAdjustmentPlus = true;
                isAdjustmentMinus = false;
              } else if (adjustment < 0) {
                adjustment = adjustment.abs();
                totalDeduction = totalDeduction + adjustment;
                isAdjustmentPlus = false;
                isAdjustmentMinus = true;
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(R.strings.aturTanggal),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        height: 30.0,
                        width: MediaQuery.of(context).size.width/1.8,
                        child: TextFormField(
                          cursorColor: R.colors.colorText,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: R.colors.greenLogo,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: R.colors.greenLogo,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              color: R.colors.greenLogo,
                            ),
                          ),
                          initialValue: "${Constants.listMonthIndonesia[selectedDateTime.month-1]} ${selectedDateTime.year}",
                          onTap: () {
                            showMonthPicker(
                              context: context,
                              initialDate: selectedDateTime,
                              firstDate:DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((date) {
                              setState(() {
                                selectedDateTime = date!;
                                _paySlipBloc.add(PaySlip(month: selectedDateTime.month, year: selectedDateTime.year));
                              });
                            });
                          },
                          readOnly: true,
                          style: TextStyle(
                            color: R.colors.colorText,
                            fontSize: 16.0,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[300],
                          height: 6.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                R.strings.pendapatan,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                color: Colors.grey[300],
                                height: 1.0,
                              ),
                              const SizedBox(height: 10.0),
                              PairHorizontalText(
                                title: R.strings.gajiTrip,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(salaryTrip),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.bonusTrip,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(bonusTrip),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              Visibility(
                                visible: isAdjustmentPlus,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 18.0),
                                    PairHorizontalText(
                                      title: R.strings.penyesuaian,
                                      content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(adjustment),
                                      colorTitle: R.colors.colorText,
                                      colorContent: R.colors.colorText,
                                      fontSizeTitle: 14.0,
                                      fontSizeContent: 14.0,
                                      fontWeightTitle: FontWeight.normal,
                                      fontWeightContent: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.thr,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(thr),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.insentif,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(insentif),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.bonusAntarTeman,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(bonusDecrease),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                color: Colors.grey[300],
                                height: 1.0,
                              ),
                              const SizedBox(height: 10.0),
                              PairHorizontalText(
                                title: R.strings.total,
                                content: "+${NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(totalIncome)}",
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.greenLogo,
                                fontSizeTitle: 15.0,
                                fontSizeContent: 15.0,
                                fontWeightTitle: FontWeight.bold,
                                fontWeightContent: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[300],
                          height: 6.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                R.strings.potongan,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                color: Colors.grey[300],
                                height: 1.0,
                              ),
                              const SizedBox(height: 10.0),
                              PairHorizontalText(
                                title: R.strings.bpjsKet,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(bpjsKet),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.bpjsKes,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(bpjsKes),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              Visibility(
                                visible: isAdjustmentMinus,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 18.0),
                                    PairHorizontalText(
                                      title: R.strings.penyesuaian,
                                      content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(adjustment),
                                      colorTitle: R.colors.colorText,
                                      colorContent: R.colors.colorText,
                                      fontSizeTitle: 14.0,
                                      fontSizeContent: 14.0,
                                      fontWeightTitle: FontWeight.normal,
                                      fontWeightContent: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                color: Colors.grey[300],
                                height: 1.0,
                              ),
                              const SizedBox(height: 10.0),
                              PairHorizontalText(
                                title: R.strings.total,
                                content: "-${NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(totalDeduction)}",
                                colorTitle: R.colors.colorText,
                                colorContent: Colors.redAccent,
                                fontSizeTitle: 15.0,
                                fontSizeContent: 15.0,
                                fontWeightTitle: FontWeight.bold,
                                fontWeightContent: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[300],
                          height: 6.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                R.strings.pengeluaran,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                color: Colors.grey[300],
                                height: 1.0,
                              ),
                              const SizedBox(height: 10.0),
                              PairHorizontalText(
                                title: R.strings.angsuranSusut,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(deptPayment),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.angsuranPinjaman,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(loanPayment),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.angsuranLain,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(0),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                color: Colors.grey[300],
                                height: 1.0,
                              ),
                              const SizedBox(height: 10.0),
                              PairHorizontalText(
                                title: R.strings.total,
                                content: "-${NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(totalExpense)}",
                                colorTitle: R.colors.colorText,
                                colorContent: Colors.redAccent,
                                fontSizeTitle: 15.0,
                                fontSizeContent: 15.0,
                                fontWeightTitle: FontWeight.bold,
                                fontWeightContent: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[300],
                          height: 6.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                R.strings.info,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.jmlPerjalanan,
                                content: state.paySlipResp.numberOfTrip ?? "0",
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.totalTabungan,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(saving),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.sisaHutangYTD,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(remainingLoan),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                              const SizedBox(height: 18.0),
                              PairHorizontalText(
                                title: R.strings.sisaPinjamanYTD,
                                content: NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(remainingDept),
                                colorTitle: R.colors.colorText,
                                colorContent: R.colors.colorText,
                                fontSizeTitle: 14.0,
                                fontSizeContent: 14.0,
                                fontWeightTitle: FontWeight.normal,
                                fontWeightContent: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: R.colors.greenLogo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        PairHorizontalText(
                          title: R.strings.nettoGaji,
                          content: "${R.strings.rp} ${NumberFormat.simpleCurrency(name: "", decimalDigits: 2).format(thp)}",
                          colorTitle: Colors.white,
                          colorContent: Colors.white,
                          fontSizeTitle: 16.0,
                          fontSizeContent: 16.0,
                          fontWeightTitle: FontWeight.bold,
                          fontWeightContent: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (state is PaySlipError) {
            return Center(child: Text(state.message));
          }
          throw ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(R.strings.errorWidget)));
        },
      ),
    );
  }
}
