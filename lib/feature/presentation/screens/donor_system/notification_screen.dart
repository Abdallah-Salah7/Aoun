import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      "title": "تبرعك أحدث فرقاً",
      "description": "شكراً لك ،تم إيصال الطعام للعائلات المحتاجة .",
      "imgPath": "assets/images/tabler_heart-filled.png",
      "isSeen": true,
    },
    {
      "title": "حملة إفطار صائم",
      "description":
          "انضم إلينا فى حملة إفطار صائم لهذا العام وساهم فى إطعام المحتاجين فى المناطق الأشد احتياجاً.",
      "imgPath": "assets/images/material-symbols_campaign-rounded.png",
      "isSeen": true,
    },
    {
      "title": "اكتمل بناء بئر المياه",
      "description":
          "بفضل تبرعك تم توفير مياه نظيفة ل 50  عائلة فى قرية نائية. ",
      "imgPath": "assets/images/CheckCircle.png",
      "isSeen": false,
    },
    {
      "title": "تأكيد عملية التبرع",
      "description":
          "تم استلام تبرعك بقيمة 1000 جنيه بنجاح لمشروع كفالة الأيتام ، شكراً لك !",
      "imgPath": "assets/images/CheckCircle.png",
      "isSeen": false,
    },
  ];

  final bool noNotification = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          title: const Text("الإشعارات", style: TextStyle(fontSize: 20)),
          backgroundColor: const Color(0xffE5EBE9),
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        body:
            noNotification
                ? _buildEmptyState(size)
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder:
                        (context, index) =>
                            _NotificationItem(item: notifications[index]),
                  ),
                ),
      ),
    );
  }

  Widget _buildEmptyState(Size size) {
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/rectangle with bell.png",
                  width: size.width * 0.8,
                ),
                Positioned(
                  right: size.width * 0.21,
                  top: size.height * 0.05,
                  child: Image.asset(
                    "assets/images/bells.png",
                    width: size.width * 0.1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "لا يوجد لديك إشعارات بعد !",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff2F674D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final Map<String, dynamic> item;
  const _NotificationItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 2, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            decoration: BoxDecoration(
              color: const Color(0xffE2F4EC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(item["imgPath"], fit: BoxFit.contain),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (item["isSeen"])
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xff288E5F),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
