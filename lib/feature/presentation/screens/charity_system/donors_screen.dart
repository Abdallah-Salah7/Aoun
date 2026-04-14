import 'package:aoun/feature/presentation/screens/charity_system/top_donors_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../widget/weekly_chart.dart';
import 'app_drawer.dart';

class DonorsScreen extends StatelessWidget {
  const DonorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 0,
        ),
        backgroundColor: const Color(0xffC7CDCD),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

             children: [

               Container(
                 decoration: const BoxDecoration(
                   borderRadius: BorderRadius.only(
                     bottomLeft: Radius.circular(25),
                     bottomRight: Radius.circular(25),
                   ),
                   color: Color(0xff2F674D),
                 ),
                 height: 148,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(
                     horizontal: 32,
                     vertical: 32,
                   ),
                   child: Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 28.0, top: 18),
                         child: Builder(
                           builder: (context) {
                             return InkWell(
                               onTap: () {
                                 Scaffold.of(context).openDrawer();
                               },
                               child: Image(
                                 image: AssetImage(ImageAssets.charityIcon),
                               ),
                             );
                           },
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 18.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               "المتبرعين",
                               style: GoogleFonts.manrope(
                                 fontSize: 22,
                                 fontWeight: FontWeight.w800,
                                 color: Colors.white,
                               ),
                             ),
                             Text(
                               "لوحة التحكم",
                               style: GoogleFonts.manrope(
                                 fontSize: 19,
                                 fontWeight: FontWeight.w400,
                                 color: Colors.white,
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               const SizedBox(height: 18),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: Colors.white,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.25),
                         blurRadius: 10,
                         spreadRadius: 1,
                         offset: const Offset(0, 6),
                       ),
                     ],
                   ),
                   padding: const EdgeInsets.symmetric(horizontal: 28),
                   child: Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
                         child: Container(
                           decoration: BoxDecoration(
                             color: const Color(0xffE3F0EA),
                             borderRadius: BorderRadius.circular(45),
                           ),
                           padding: const EdgeInsets.all(8),
                           child: Image(
                             image: AssetImage(ImageAssets.numDonors),
                             height: 36,
                             width: 36,
                           ),
                         ),
                       ),
                       Column(
                         children: [
                           Text(
                             "إجمالى المتبرعين",
                             style: GoogleFonts.manrope(
                               fontSize: 19,
                               fontWeight: FontWeight.w800,
                               color: const Color(0xff6A6969),
                             ),
                           ),
                           Text(
                             " 12,0000 متبرع",
                             style: GoogleFonts.manrope(
                               fontSize: 17,
                               fontWeight: FontWeight.w700,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: Colors.white,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.25),
                         blurRadius: 10,
                         spreadRadius: 1,
                         offset: const Offset(0, 6),
                       ),
                     ],
                   ),
                   padding: const EdgeInsets.symmetric(horizontal: 28),
                   child: Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
                         child: Container(
                           decoration: BoxDecoration(
                             color: const Color(0xffE3F0EA),
                             borderRadius: BorderRadius.circular(45),
                           ),
                           padding: const EdgeInsets.all(8),
                           child: Image(
                             image: AssetImage(ImageAssets.newDonors),
                             height: 36,
                             width: 36,
                           ),
                         ),
                       ),
                       Column(
                         children: [
                           Text(
                             "متبرعين جدد",
                             style: GoogleFonts.manrope(
                               fontSize: 19,
                               fontWeight: FontWeight.w800,
                               color: const Color(0xff6A6969),
                             ),
                           ),
                           Text(
                             "6,000 متبرع",
                             style: GoogleFonts.manrope(
                               fontSize: 17,
                               fontWeight: FontWeight.w700,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: Colors.white,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.25),
                         blurRadius: 10,
                         spreadRadius: 1,
                         offset: const Offset(0, 6),
                       ),
                     ],
                   ),
                   padding: const EdgeInsets.symmetric(horizontal: 28),
                   child: Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
                         child: Container(
                           decoration: BoxDecoration(
                             color: const Color(0xffE3F0EA),
                             borderRadius: BorderRadius.circular(45),
                           ),
                           padding: const EdgeInsets.all(8),
                           child: Image(
                             image: AssetImage(ImageAssets.totalDonation),
                             height: 36,
                             width: 36,
                           ),
                         ),
                       ),
                       Column(
                         children: [
                           Text(
                             "إجمالى التبرعات",
                             style: GoogleFonts.manrope(
                               fontSize: 19,
                               fontWeight: FontWeight.w800,
                               color: const Color(0xff6A6969),
                             ),
                           ),
                           Text(
                             " 452,000  ج.م",
                             style: GoogleFonts.manrope(
                               fontSize: 17,
                               fontWeight: FontWeight.w700,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 36.0,horizontal: 18),
                 child: WeeklyChart(title: "عدد المتبرعين",),
               ),
               TopDonorsScreen(),

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 28.0),
                 child: Row(
                   children: [
                     Text("جميع المتبرعين",
                       style: TextStyle(
                           fontSize: 22,
                           fontWeight: FontWeight.w800
                       ),),
                     Spacer(),
                     InkWell(
                       onTap: (){

                       },
                       child: Text("عرض المزيد",
                         style: TextStyle(
                             fontSize: 22,
                             fontWeight: FontWeight.w800,
                             color: Color(0xff248457)
                         ),),
                     )
                   ],
                 ),
               ),

               Container(
                 padding: const EdgeInsets.all(16),
                 margin: EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20),
                   boxShadow: [
                     BoxShadow(color: Colors.black12, blurRadius: 10),
                   ],
                 ),
                 child: ListView.separated(
                   shrinkWrap: true,
                   itemCount: 6,
                   separatorBuilder: (context, index) => const Divider(),
                   itemBuilder: (context, index) {
                     return ListTile(
                       contentPadding: EdgeInsets.zero,
                       leading: CircleAvatar(
                         backgroundColor: Color(0xffC7CDCD),
                         child: const Text(
                           "م",
                           style: TextStyle(
                             color: Color(0xFF1E5631),
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                       title: const Text(
                         "محمد أحمد",
                         style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                       ),
                       subtitle: const Text("منذ 5 دقائق",
                         style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w400
                         ),),
                       trailing: const Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text(
                             "500 ج.م",
                             style: TextStyle(
                                 color: Color(0xff255A41),
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16
                             ),
                           ),
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
}
