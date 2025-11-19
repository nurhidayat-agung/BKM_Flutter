import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/home/home_bloc.dart';
import 'package:newbkmmobile/blocs/home/home_event.dart';
import 'package:newbkmmobile/blocs/home/home_state.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/ui/pages/trip/trip_page.dart';
import 'package:newbkmmobile/ui/pages/workshop/workshop_page.dart';
import 'package:newbkmmobile/ui/pages/history/history_page.dart';
import 'package:newbkmmobile/ui/pages/service_book/service_book_page.dart';
import 'package:newbkmmobile/ui/pages/service_part/service_part_page.dart';
import 'package:newbkmmobile/ui/pages/payslip/payslip_page.dart';
import 'package:newbkmmobile/ui/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  final LoginRepository loginRepository;

  const HomePage({Key? key, required this.loginRepository}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSaldoHidden = true;
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(loginRepository: widget.loginRepository);
    _homeBloc.add(LoadUserData());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeBloc,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // biar bisa gradient header terlihat
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
                      balance = state.balance;
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/BKM_Logo_BG_White.png", height: 36),
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const ProfilePage()),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.person, color: Color(0xFF001F3F)),
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
                              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                          borderRadius: BorderRadius.circular(6),
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
                                                : balance,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => setState(() =>
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
                                  const Expanded(
                                    child: Text(
                                      "Setiap supir wajib mengupload foto SPB dengan gambar yang jelas, jika masih tidak jelas tidak akan dapat DO berikutnya.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
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
                                _menuItem("Pengangkutan Baru", "assets/Pengangkutan_Baru.png", const TripPage(), context),
                                _menuItem("Langsir", "assets/Langsir.png", const WorkshopPage(), context),
                                _menuItem("Riwayat Pengangkutan", "assets/Riwayat_Pengangkutan.png", const HistoryPage(), context),
                                _menuItem("Bengkel", "assets/Bengkel.png", const ServiceBookPage(), context),
                                _menuItem("Pengajuan Cuti", "assets/Pengajuan_Cuti.png", const ServicePartPage(), context),
                                _menuItem("Slip Gaji", "assets/slip_gaji.png", const PaySlipPage(), context),
                              ],
                            ),
                          ),

                          const SizedBox(height: 2),
                          // 🔹 DOMPET INFO
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(child: _walletBox("Tabungan", "IDR $tabungan")),
                                const SizedBox(width: 12),
                                Expanded(child: _walletBox("Uang Tertahan", "IDR $uangTertahan")),
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

  Widget _menuItem(String title, String imagePath, Widget page, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // FIXED HEIGHT ICON (tidak pakai Expanded)
          SizedBox(
            height: 90,
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.contain,
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
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF001F3F))),
        ],
      ),
    );
  }
}
