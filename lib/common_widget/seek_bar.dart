import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class SeekBarData{
  final Duration position;
  final Duration duration;
  SeekBarData(this.position,this.duration);
}
class SeekBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;
  const SeekBar(
    {super.key,
    required this.position,
    required this.duration,
    this.onChanged,
    this.onChangeEnd
  });

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  String _formatDuration(Duration? duration){
    if(duration == null){
      return '--:--';
    }else{
      String minutes = duration!.inMinutes.toString().padLeft(2,'0');
      String seconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
      return '$minutes:$seconds';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 5,
                    thumbShape: const RoundSliderThumbShape(
                      disabledThumbRadius: 6,
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 09
                    ),
                    activeTrackColor: TColor.primaryLine,
                    inactiveTrackColor: TColor.primaryLine.withOpacity(0.3),
                    thumbColor: TColor.primaryLine,
                    overlayColor: TColor.primaryLine,
                  ),
                  child: Slider(
                    min: 0.0,
                    max: widget.duration.inMilliseconds.toDouble(),
                    value: min(
                        _dragValue ?? widget.position.inMilliseconds.toDouble(),
                        widget.duration.inMilliseconds.toDouble()),
                    onChanged: (value){
                      setState(() {
                        _dragValue= value;
                      });
                      if(widget.onChanged != null){
                        widget.onChanged!(
                            Duration(
                              milliseconds: value.round()
                            )
                        );
                      }
                    },
                    onChangeEnd: (value){
                      if(widget.onChangeEnd != null){
                        widget.onChangeEnd!(
                            Duration(
                                milliseconds: value.round()
                            ),
                        );
                      }
                      _dragValue == null;
                    },
                  )
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 8,left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(widget.position),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: TColor.primaryText60
                ),),
                Text(_formatDuration(widget.duration),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: TColor.primaryText60
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
