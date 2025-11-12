import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/home/home_bloc.dart';
import 'package:newbkmmobile/blocs/home/home_event.dart';
import 'package:newbkmmobile/blocs/home/home_state.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/core/grid_item.dart';
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

  List<GridItem> listGrid = [
    GridItem(title: "Pengangkutan Baru", image: AssetImage("assets/menu_trip.png"), color: Colors.blueAccent, widget: const TripPage()),
    GridItem(title: "Langsir", image: AssetImage("assets/ic_workshop.png"), color: Colors.orange, widget: const WorkshopPage()),
    GridItem(title: "Riwayat Pengangkutan", image: AssetImage("assets/menu_history.png"), color: Colors.deepPurpleAccent, widget: const HistoryPage()),
    GridItem(title: "Bengkel", image: AssetImage("assets/menu_service_trans.png"), color: Colors.red, widget: const ServiceBookPage()),
    GridItem(title: "Pengajuan Cuti", image: AssetImage("assets/menu_part_trans.png"), color: Colors.green, widget: const ServicePartPage()),
    GridItem(title: "Slip Gaji", image: AssetImage("assets/menu_salary.png"), color: Colors.lightGreen, widget: const PaySlipPage()),
  ];

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
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              String userName = "Pengguna";
              String balance = "0";

              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                userName = state.name;
                balance = state.balance;
              } else if (state is HomeError) {
                return Center(child: Text(state.message));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // 🔹 Header section (logo + saldo)
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF001F3F), Color(0xFF023E73)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔸 Logo & Profil
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/BKM_Logo_BG_White.png", height: 40),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.person, color: Color(0xFF001F3F)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Good morning, $userName",
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),

                          // 🔸 Kartu Saldo
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF023E73),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Image.asset("assets/dompet.png", width: 28, height: 28, fit: BoxFit.contain),
                                const SizedBox(width: 10),
                                const Text(
                                  "IDR ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _isSaldoHidden ? "**************" : balance,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => setState(() => _isSaldoHidden = !_isSaldoHidden),
                                  icon: Icon(
                                    _isSaldoHidden ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Menu Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listGrid.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.95,
                        ),
                        itemBuilder: (context, index) {
                          final item = listGrid[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item.widget)),
                            child: Column(
                              children: [
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF002E5B), Color(0xFFFF5B2E)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: ImageIcon(item.image, color: Colors.white, size: 34),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
