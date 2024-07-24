import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import '../../view_model/home_view_model.dart';


class NotificationView extends StatefulWidget{
  const NotificationView({super.key});
  @override
  State<NotificationView> createState() => _NotificationView();
}

class _NotificationView extends State<NotificationView> {
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: TColor.bg,
      appBar: AppBar(
        titleSpacing: 0.0,
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/img/logo_app.png',
            fit: BoxFit.contain,
          ),
        ),
        title:
        Container(
          margin: const EdgeInsets.only(left: 5),
          child: Text(
            "Hôm nay nghe gì ? ",
            style: TextStyle(
                color: TColor.primaryTextM,
                fontSize: 27,
                fontWeight: FontWeight.w900
            ),
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25,),
            Card(
              color: TColor.primaryLine.withOpacity(0.7),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/img/img_14.png',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chill cùng Phan Mạnh Quỳnh",
                            style: TextStyle(
                              color: TColor.primaryText80,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: Text(
                                    "Bạn có một bài hát mới để nghe! Hãy chill cùng Phan Mạnh Quỳnh bằng những bài hát của anh ấy! Bạn đang tìm kiếm bài hát yêu thích của mình, ...",
                                    style: TextStyle(
                                      color: TColor.secondaryText.withOpacity(0.8),
                                      fontSize: 10,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30)
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "20:05",
                              style: TextStyle(fontSize:10,color: TColor.secondaryText.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: TColor.darkGray.withOpacity(0.7),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/img/img_14.png',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chill cùng Phan Mạnh Quỳnh",
                            style: TextStyle(
                              color: TColor.primaryText80,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: Text(
                                    "Bạn có một bài hát mới để nghe! Hãy chill cùng Phan Mạnh Quỳnh bằng những bài hát của anh ấy! Bạn đang tìm kiếm bài hát yêu thích của mình, ...",
                                    style: TextStyle(
                                      color: TColor.secondaryText.withOpacity(0.8),
                                      fontSize: 10,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30)
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "20:05",
                              style: TextStyle(fontSize:10,color: TColor.secondaryText.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: TColor.darkGray.withOpacity(0.7),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/img/img_14.png',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chill cùng Phan Mạnh Quỳnh",
                            style: TextStyle(
                              color: TColor.primaryText80,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: Text(
                                    "Bạn có một bài hát mới để nghe! Hãy chill cùng Phan Mạnh Quỳnh bằng những bài hát của anh ấy! Bạn đang tìm kiếm bài hát yêu thích của mình, ...",
                                    style: TextStyle(
                                      color: TColor.secondaryText.withOpacity(0.8),
                                      fontSize: 10,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30)
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "20:05",
                              style: TextStyle(fontSize:10,color: TColor.secondaryText.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: TColor.darkGray.withOpacity(0.7),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/img/img_14.png',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chill cùng Phan Mạnh Quỳnh",
                            style: TextStyle(
                              color: TColor.primaryText80,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: Text(
                                    "Bạn có một bài hát mới để nghe! Hãy chill cùng Phan Mạnh Quỳnh bằng những bài hát của anh ấy! Bạn đang tìm kiếm bài hát yêu thích của mình, ...",
                                    style: TextStyle(
                                      color: TColor.secondaryText.withOpacity(0.8),
                                      fontSize: 10,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30)
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "20:05",
                              style: TextStyle(fontSize:10,color: TColor.secondaryText.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: TColor.darkGray.withOpacity(0.7),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/img/img_14.png',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chill cùng Phan Mạnh Quỳnh",
                            style: TextStyle(
                              color: TColor.primaryText80,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: Text(
                                    "Bạn có một bài hát mới để nghe! Hãy chill cùng Phan Mạnh Quỳnh bằng những bài hát của anh ấy! Bạn đang tìm kiếm bài hát yêu thích của mình, ...",
                                    style: TextStyle(
                                      color: TColor.secondaryText.withOpacity(0.8),
                                      fontSize: 10,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30)
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "20:05",
                              style: TextStyle(fontSize:10,color: TColor.secondaryText.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: TColor.darkGray.withOpacity(0.7),
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/img/img_14.png',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chill cùng Phan Mạnh Quỳnh",
                            style: TextStyle(
                              color: TColor.primaryText80,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: Text(
                                    "Bạn có một bài hát mới để nghe! Hãy chill cùng Phan Mạnh Quỳnh bằng những bài hát của anh ấy! Bạn đang tìm kiếm bài hát yêu thích của mình, ...",
                                    style: TextStyle(
                                      color: TColor.secondaryText.withOpacity(0.8),
                                      fontSize: 10,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30)
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "20:05",
                              style: TextStyle(fontSize:10,color: TColor.secondaryText.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}