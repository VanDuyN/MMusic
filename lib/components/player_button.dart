import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/components/play_pause_button.dart';
import 'package:mmusic/services/song_handler.dart';
class PlayerButton extends StatelessWidget {
  final SongHandler songHandler;
  const PlayerButton({super.key, required this.songHandler});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.repeat,
                weight: 14,
                color: TColor.primaryText,
              )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:const  EdgeInsets.all(1),
                width: 60,
                height: 60,
                child: IconButton(
                  onPressed: songHandler.skipToPrevious,
                  icon :Icon(
                    weight: 14,
                    size: 40,
                    Icons.skip_previous,
                    color: TColor.primaryText,
                  ),
                ),
              ),
              PlayPauseButton(songHandler: songHandler, size: 56),
              Container(
                margin:const  EdgeInsets.all(1),
                width: 60,
                height: 60,
                child: IconButton(
                  onPressed: songHandler.skipToNext,
                  icon :Icon(
                    weight: 14,
                    size: 40,
                    Icons.skip_next,
                    color: TColor.primaryText,
                  ),
                ),
              ),
            ],
          ),

          IconButton(
            onPressed: (){},
            icon: Image.asset(
              "assets/img/shuffle.png",
              color: TColor.primaryText,
              width: 24,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}


// class  extends StatelessWidget {
//   final SongHandler songHandler;
//
//   PlayerBtton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         IconButton(
//             onPressed: (){},
//             icon: Icon(
//               Icons.repeat,
//               weight: 14,
//               color: TColor.primaryText,
//             )
//         ),
//         Row(
//           children: [
//             IconButton(
//               onPressed: songHandler.skipToPrevious,
//               icon :Icon(
//                 Icons.skip_next,
//                 color: TColor.primaryText,
//               ),
//             ),
//             PlayPauseButton(songHandler: songHandler, size: 45),
//             IconButton(
//               onPressed: songHandler.skipToNext,
//               icon :Icon(
//                 Icons.skip_next,
//                 color: TColor.primaryText,
//               ),
//             ),
//           ],
//         ),
//         IconButton(
//           onPressed: (){},
//           icon: Image.asset(
//             "assets/img/shuffle.png",
//             color: TColor.primaryText,
//             width: 24,
//             height: 30,
//           ),
//         ),
//       ],
//     );
//   }
//}