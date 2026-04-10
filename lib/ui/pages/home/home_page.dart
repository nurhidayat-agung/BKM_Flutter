import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/home/home_bloc.dart';
import 'package:newbkmmobile/blocs/home/home_event.dart';
import 'package:newbkmmobile/blocs/home/home_state.dart';
import 'package:newbkmmobile/core/currency_formatter.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/ui/pages/repair/repair_page.dart';
import 'package:newbkmmobile/ui/pages/trip/trip_page.dart';
import 'package:newbkmmobile/ui/pages/trip/trip_list_page.dart';
import 'package:newbkmmobile/ui/pages/workshop/workshop_page.dart';
import 'package:newbkmmobile/ui/pages/history/history_page.dart';
import 'package:newbkmmobile/ui/pages/service_book/service_book_page.dart';
import 'package:newbkmmobile/ui/pages/service_part/service_part_page.dart';
import 'package:newbkmmobile/ui/pages/payslip/payslip_page.dart';
import 'package:newbkmmobile/ui/pages/profile/profile_page.dart';
import 'package:newbkmmobile/ui/pages/leave/leave_page.dart';
import 'package:newbkmmobile/ui/pages/langsir/langsir_list_page.dart';
import 'package:newbkmmobile/repositories/leave_repository.dart';
import 'package:newbkmmobile/services/http_communicator.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/models/common/announcement.dart';
import 'package:newbkmmobile/repositories/common_repository.dart';


class HomePage extends StatefulWidget {
  final LoginRepository loginRepository;

  const HomePage({Key? key, required this.loginRepository}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSaldoHidden = true;
  final LeaveRepository _leaveRepository = LeaveRepository();
  final CommonRepository _commonRepository = CommonRepository();
  bool _leavePopupShown = false;
  late HomeBloc _homeBloc;

  bool _isCurrentlyOnLeave = false;
  String _activeLeaveType = "";
  DateTime? _activeLeaveStart;
  DateTime? _activeLeaveEnd;

  String leaveStatusTitle = "Status Cuti Aktif";
  String leaveMessageTemplate = "";
  String _announcementText = "";


  List<Announcement> _announcements = [];
  int _currentAnnouncementIndex = 0;
  final PageController _announcementPageController = PageController();
  Timer? _announcementTimer;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(loginRepository: widget.loginRepository);
    _homeBloc.add(LoadUserData());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCommonData();
      checkLeaveStatus();
    });
  }

  @override
  void dispose() {
    _homeBloc.close();
    _announcementTimer?.cancel();
    _announcementPageController.dispose();
    super.dispose();
  }

  void _startAnnouncementAutoScroll() {
    if (_announcements.length <= 1) return;
    _announcementTimer?.cancel();
    _announcementTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final nextIndex = (_currentAnnouncementIndex + 1) % _announcements.length;
      _announcementPageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeBloc,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          // biar bisa gradient header terlihat
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F9FC),
          body: Stack(
            children: [
              // 🔹 HEADER BACKGROUND (gradient full ke atas)
              Container(
                height: 160, // atau sesuai header height
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF001F3F), Color(0xFF023E73)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // 🔹 BODY
              SafeArea(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    String tabungan = "2.000.000";
                    String uangTertahan = "500.000";
                    String userName = "Pengguna";
                    String balance = "0";
                    if (state is HomeLoaded) {
                      userName = state.name;
                      balance = state.balance ?? "0.00";
                      tabungan = state.savings ?? "0.00";
                      uangTertahan = state.heldAmmount ?? "0.00";
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          // 🔹 HEADER
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF001F3F), Color(0xFF023E73)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(28),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🔸 Logo dan Profile
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Image.asset("assets/BKM_Logo_BG_White.png",
                                        height: 36),
                                    GestureDetector(
                                      onTap: () =>
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (
                                                _) => const ProfilePage()),
                                          ),
                                      child: const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.person,
                                            color: Color(0xFF001F3F)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                // 🔸 Good morning text
                                Text(
                                  "Good morning,",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  userName.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 🔹 KARTU SALDO
                          Transform.translate(
                            offset: const Offset(0, -40),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F1F3),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // 🔸 Ikon dompet + label saldo
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF001F3F),
                                          borderRadius: BorderRadius.circular(
                                              6),
                                        ),
                                        child: const Text(
                                          "Saldo",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Image.asset("assets/dompet.png",
                                          width: 40, height: 40),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  // 🔸 Nilai saldo
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "IDR ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            _isSaldoHidden
                                                ? "**************"
                                                : CurrencyFormatter
                                                .formatFromString(balance),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              setState(() =>
                                              _isSaldoHidden = !_isSaldoHidden),
                                          child: Icon(
                                            _isSaldoHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // 🔹 ANNOUNCEMENT BOX
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/anountment.png",
                                      width: 30, height: 30),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SizedBox(
                                      height: 38,
                                      child: _announcements.isEmpty
                                          ? const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Tidak ada pengumuman saat ini.",
                                          style: TextStyle(fontSize: 13, color: Colors.black87),
                                        ),
                                      )
                                          : PageView.builder(
                                        controller: _announcementPageController,
                                        scrollDirection: Axis.vertical,
                                        itemCount: _announcements.length,
                                        itemBuilder: (context, index) {
                                          return Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _announcements[index].message ?? "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // 🔹 MENU GRID
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 28,
                              childAspectRatio: 0.70,
                              children: [
                                _menuItem("Pengangkutan Baru",
                                    "assets/Pengangkutan_Baru.png",
                                    const TripListPage(),
                                    context,isRestrictedDuringLeave: true,showBadge: false),
                                    // isRestrictedDuringLeave: true),// Panggil ini untuk block pengangkutan
                                _menuItem("Langsir", "assets/Langsir.png",
                                    const LangsirListPage(), context),
                                _menuItem("Riwayat Pengangkutan",
                                    "assets/Riwayat_Pengangkutan.png",
                                    const HistoryPage(), context),
                                _menuItem("Bengkel", "assets/Bengkel.png",
                                    const RepairPage(), context),
                                _menuItem("Pengajuan Cuti",
                                    "assets/Pengajuan_Cuti.png",
                                    const LeaveApplicationPageWrapper(),
                                    context),
                                _menuItem("Slip Gaji", "assets/slip_gaji.png",
                                    const PaySlipPage(), context),
                              ],
                            ),
                          ),

                          const SizedBox(height: 2),
                          // 🔹 DOMPET INFO
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(child: _walletBox("Tabungan",
                                    "IDR ${CurrencyFormatter.formatFromString(
                                        tabungan)}")),
                                const SizedBox(width: 12),
                                Expanded(child: _walletBox("Uang Tertahan",
                                    "IDR ${CurrencyFormatter.formatFromString(
                                        uangTertahan)}")),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(String title, String imagePath, Widget page,
      BuildContext context, {bool isRestrictedDuringLeave = false, bool showBadge = false}) {
    return GestureDetector(
      onTap: () {
        if (isRestrictedDuringLeave && _isCurrentlyOnLeave &&
            _activeLeaveStart != null && _activeLeaveEnd != null) {
          showLeavePopup(
              _activeLeaveType, _activeLeaveStart!, _activeLeaveEnd!);
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // FIXED HEIGHT ICON
          SizedBox(
            height: 90,
            child: Badge(
              isLabelVisible: showBadge,
              backgroundColor: Colors.red,
              smallSize: 14,
            offset: const Offset(-25, 25),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.contain,
            ),
          ),
          ),
          const SizedBox(height: 8),
          // TEXT MANAGE HEIGHT
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF001F3F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001F3F))),
        ],
      ),
    );
  }

  /// ===============================
  /// FUNGSI MENGAMBIL DATA COMMON API (LEWAT REPOSITORY)
  /// ===============================
  Future<void> fetchCommonData() async {
    try {
      debugPrint("MULAI FETCH API COMMON");

      final responseMap = await _commonRepository.getCommonData();
      final status = responseMap['status'];
      final result = responseMap['result'];

      debugPrint("STATUS API: $status");

      if (status == 200 && result != null) {
        final data = result['data'] ?? result;

        if (data != null) {
          //Update Pesan Cuti
          final messageConfig = data["messages"]?["leave"];
          if (messageConfig != null) {
            leaveStatusTitle = messageConfig["status"] ?? leaveStatusTitle;
            leaveMessageTemplate = messageConfig["message"]?.toString() ?? "";
          }

          //Update Pengumuman
          final List announcementsData = data['announcements'] ?? [];
          debugPrint("JUMLAH PENGUMUMAN DARI JSON: ${announcementsData.length}");

          final activeAnnouncements = announcementsData
              .map((a) => Announcement.fromJson(a as Map<String, dynamic>))
              .where((a) {
            bool isActive = (a.isActive == 1 || a.isActive?.toString() == "1");
            bool isMessageValid = (a.message != null && a.message!.isNotEmpty);
            return isActive && isMessageValid;
          })
              .toList();

          debugPrint("PENGUMUMAN LOLOS FILTER: ${activeAnnouncements.length}");

          if (mounted) {
            setState(() {
              if (activeAnnouncements.isNotEmpty) {
                _announcements = activeAnnouncements;
                _currentAnnouncementIndex = 0;
                _startAnnouncementAutoScroll();
              } else {
                _announcements = [];
              }
            });
          }
        }
      } else {
        debugPrint("API GAGAL. Status: $status, Result: $result");
      }

      // =======================================================
      // 🚨 KODE TESTER CUTI (HAPUS JIKA SUDAH SELESAI UJI COBA)
      // =======================================================
      // if (mounted) {
      //   setState(() {
      //     _isCurrentlyOnLeave = true; // Paksa status cuti jadi AKTIF
      //     _activeLeaveType = "Cuti Lebaran (TEST)";
      //     _activeLeaveStart = DateTime.now(); // Mulai hari ini
      //     _activeLeaveEnd = DateTime.now().add(const Duration(days: 3)); // Sampai 3 hari ke depan
      //   });
      //
      //   // Munculkan popupnya
      //   if (!_leavePopupShown) {
      //     _leavePopupShown = true;
      //     showLeavePopup(_activeLeaveType, _activeLeaveStart!, _activeLeaveEnd!);
      //   }
      // }
      // =======================================================

    } catch (e) {
      debugPrint("ERROR FETCH COMMON: $e");
    }
  }

  /// ===============================
  /// FUNGSI CEK STATUS CUTI SUPIR
  /// ===============================
  Future<void> checkLeaveStatus() async {
    final (status, result) = await _leaveRepository.getLeavesByUser();
    if (status != 200 || result == null) return;

    // Fallback jika template pesan masih kosong
    if (leaveMessageTemplate
        .trim()
        .isEmpty) {
      leaveMessageTemplate =
      "Anda sedang dalam masa cuti: {leave_type}\nPeriode: {start_date} s/d {start_end}\nSelama masa cuti, Anda tidak dapat mengambil atau melihat transaksi.\nAkses akan aktif kembali setelah masa cuti berakhir.";
    }

    final List leaves = result["data"] ?? [];

    // Normalisasi tanggal hari ini (hilangkan jam, menit, detik agar akurat)
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);

    for (var leave in leaves) {
      final statusLeave = leave["status"]?["field_value"];

      // tambah ini ==>  || statusLeave == "pending"
      // kalo mau pop up muncul dan bloc pengangkutan baru jika status pasih tunda/panding
      // tambah setelah "approved"
      if (statusLeave == "approved") {
        final start = DateTime.parse(leave["start_date"]);
        final startDate = DateTime(start.year, start.month, start.day);

        final end = DateTime.parse(leave["end_date"]);
        final endDate = DateTime(end.year, end.month, end.day);

        // Cek status cuti apakah hari ini berada di dalam rentang cuti (inklusif)
        if ((todayDate.isAtSameMomentAs(startDate) ||
            todayDate.isAfter(startDate)) &&
            (todayDate.isAtSameMomentAs(endDate) ||
                todayDate.isBefore(endDate))) {
          final leaveType = leave["leave_type"]?["name"] ?? "Cuti";

          if (mounted) {
            setState(() {
              _isCurrentlyOnLeave = true;
              _activeLeaveType = leaveType;
              _activeLeaveStart = startDate;
              _activeLeaveEnd = endDate;
            });
          }

          if (!_leavePopupShown && mounted) {
            _leavePopupShown = true;
            showLeavePopup(leaveType, startDate, endDate);
          }
          break;
        }
      }
    }
  }

  /// ===============================
  /// POPUP INFORMASI CUTI
  /// ===============================
  void showLeavePopup(String type, DateTime start, DateTime end) {
    // Format tanggal menjadi YYYY-MM-DD
    final startDateStr = "${start.year}-${start.month.toString().padLeft(
        2, '0')}-${start.day.toString().padLeft(2, '0')}";
    final endDateStr = "${end.year}-${end.month.toString().padLeft(
        2, '0')}-${end.day.toString().padLeft(2, '0')}";

    String cleanTemplate = leaveMessageTemplate.replaceAll(RegExp(r'\n\s+'), '\n');

    // Handle replace text dan memastikan \n terbaca sebagai baris baru
    String messageWithTags = cleanTemplate
        .replaceAll("{leave_type}", "<bold>$type</bold>")
        .replaceAll("{start_date}", "<bold>$startDateStr</bold>")
        .replaceAll("{start_end}", "<bold>$endDateStr</bold>")
        .replaceAll(r'\n', '\n');

    List<TextSpan> textSpans = [];
    List<String> parts = messageWithTags.split('<bold>');

    for (String part in parts) {
      if (part.contains('</bold>')) {
        List<String> subParts = part.split('</bold>');
        // Bagian pertama (subParts[0]) adalah teks yang di dalam tag <bold> -> JADIKAN TEBAL
        textSpans.add(TextSpan(
          text: subParts[0],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ));
        if (subParts.length > 1) {
          textSpans.add(TextSpan(text: subParts[1]));
        }
      } else {
        textSpans.add(TextSpan(text: part));
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      // Cegah popup ditutup paksa dengan mengetuk area abu-abu(sebagai blok untuk menutup popup)
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // Sesuaikan tinggi dengan konten
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leaveStatusTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF001F3F),
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                      children: textSpans,
                    ),
                  ),

                  // Tombol Menutup PopUp
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF001F3F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        "Mengerti",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}