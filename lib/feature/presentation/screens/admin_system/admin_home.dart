import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../data/data_sources/admin_service.dart';
import '../../../data/models/admin_stats_model.dart';
import '../../state_management/cubit/admin_cubit.dart';
import '../../state_management/cubit/admin_state.dart';
import 'admin_app_drawer.dart';
import 'data_chart.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AdminAppDrawer(),
        backgroundColor: const Color(0xffC7CDCD),

        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            _buildAppBar(),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "الإحصائيات",
                      style: GoogleFonts.manrope(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildStatsSection(),

                    const SizedBox(height: 28),

                    Text(
                      "عدد التسجيلات الجديدة",
                      style: GoogleFonts.manrope(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const DataChart(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 AppBar separated = lighter rebuild
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xff2F674D),
      expandedHeight: 120,
      toolbarHeight: 120,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),

      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [

              Builder(
                builder: (context) {
                  return InkWell(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Image.asset(
                      ImageAssets.charityIcon,
                      width: 32,
                      height: 32,
                      color: Colors.white,
                    ),
                  );
                },
              ),

              const SizedBox(width: 22),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "إدارة الجمعيات",
                    style: GoogleFonts.manrope(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "لوحة التحكم",
                    style: GoogleFonts.manrope(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              const Icon(Icons.notifications, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return BlocBuilder<AdminStatsCubit, AdminStatsState>(
      builder: (context, state) {
        if (state is AdminStatsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is AdminStatsError) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is AdminStatsSuccess) {
          final stats = state.stats;

          return Column(
            children: [
              _card(
                "إجمالى عدد الجمعيات",
                "${stats.totalCharities} جمعية",
                ImageAssets.totalCharity,
              ),

              const SizedBox(height: 14),

              _card(
                "عدد الجمعيات المقبولة",
                "${stats.approvedCharities} جمعية",
                ImageAssets.acceptCharity,
              ),

              const SizedBox(height: 14),

              _card(
                "عدد الجمعيات المرفوضة",
                "${stats.rejectedCharities} جمعية",
                ImageAssets.deleteCharity,
              ),

              const SizedBox(height: 14),

              _card(
                "عدد الجمعيات الموقوفة",
                "${stats.suspendedCharities} جمعية",
                ImageAssets.stopCharity,
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  /// 🔥 lighter widget (const style reduced rebuild cost)
  Widget _card(String title, String value, String icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // lighter shadow
            blurRadius: 6, // reduced
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffE3F0EA),
              borderRadius: BorderRadius.circular(45),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(icon, height: 35, width: 35),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff6A6969),
                  )),
              Text(value,
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}