import 'package:flutter/material.dart';

import '../helpers/app_constants.dart';
import 'label_text.dart';

class LabelCountdownTimer extends StatefulWidget {
  /// Text Style for Countdown Text.
  final TextStyle? textStyle;

  /// This Callback will execute when the Countdown Ends.
  final VoidCallback? onComplete;

  /// This Callback will execute when the Countdown Starts.
  final VoidCallback? onStart;

  /// Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
  final bool isReverse;

  /// Countdown duration in Seconds.
  final int duration;

  /// Countdown initial elapsed Duration in Seconds.
  final int initialDuration;

  /// Handles the timer start.
  final bool autoStart;

  /// Format for the Countdown Text.
  final String? textFormat;

  /// Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
  final LabelCountDownTimerController? controller;

  const LabelCountdownTimer({
    Key? key,
    required this.textStyle,
    required this.duration,
    required this.controller,
    this.initialDuration = 0,
    this.isReverse = false,
    this.autoStart = true,
    this.onStart,
    required this.onComplete,
    this.textFormat,
  }) : super(key: key);

  @override
  LabelCountdownTimerState createState() => LabelCountdownTimerState();
}

class LabelCountdownTimerState extends State<LabelCountdownTimer>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? animation;

  void _setController() {
    widget.controller?._state = this;
    widget.controller?._isReverse = widget.isReverse;
    widget.controller?._initialDuration = widget.initialDuration;
    widget.controller?._duration = widget.duration;

    if (widget.initialDuration > 0 && widget.autoStart) {
      if (widget.isReverse) {
        _controller?.value = 1 - (widget.initialDuration / widget.duration);
      } else {
        _controller?.value = (widget.initialDuration / widget.duration);
      }

      widget.controller?.start();
    }
  }

  void _setAnimation() {
    if (widget.autoStart) {
      if (widget.isReverse) {
        _controller!.reverse(from: 1);
      } else {
        _controller!.forward();
      }
    }
  }

  String _getTime(Duration duration) {
    // For HH:mm:ss format
    if (widget.textFormat == CountdownTextFormat.HH_MM_SS) {
      return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    // For mm:ss format
    else if (widget.textFormat == CountdownTextFormat.MM_SS) {
      return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    // For ss format
    else if (widget.textFormat == CountdownTextFormat.SS) {
      return (duration.inSeconds).toString().padLeft(2, '0');
    }
    // For s format
    else if (widget.textFormat == CountdownTextFormat.S) {
      return '${(duration.inSeconds)}';
    } else {
      // Default format
      return _defaultFormat(duration);
    }
  }

  _defaultFormat(Duration duration) {
    if (duration.inHours != 0) {
      return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else if (duration.inMinutes != 0) {
      return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      return '${duration.inSeconds % 60}';
    }
  }

  String get timerString {
    Duration duration = _controller!.duration! * _controller!.value;

    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String get hrLabel {
    Duration duration = _controller!.duration! * _controller!.value;
    return duration.inHours.toString().padLeft(2, '0');
  }

  String get minLabel {
    Duration duration = _controller!.duration! * _controller!.value;
    return duration.inMinutes.toString().padLeft(2, '0');
  }

  String get secLabel {
    Duration duration = _controller!.duration! * _controller!.value;
    return (duration.inSeconds % 60).toString().padLeft(2, '0');
  }

  void _onStart() {
    if (widget.onStart != null) widget.onStart!();
  }

  void _onComplete() {
    if (widget.onComplete != null) widget.onComplete!();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: widget.duration), vsync: this);
    animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    _controller!.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          _onStart();
          break;

        case AnimationStatus.reverse:
          _onStart();
          break;

        case AnimationStatus.dismissed:
          _onComplete();
          break;
        case AnimationStatus.completed:

          /// [AnimationController]'s value is manually set to [1.0] that's why [AnimationStatus.completed] is invoked here this animation is [isReverse]
          /// Only call the [_onComplete] block when the animation is not reversed.
          if (!widget.isReverse) _onComplete();
          break;
        default:
        // Do nothing
      }
    });

    _setAnimation();
    _setController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller!,
        builder: (BuildContext context, Widget? child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LabelText(label: 'HRS', value: hrLabel),
                  LabelText(label: 'MIN', value: minLabel),
                  LabelText(label: 'SEC', value: secLabel),
                ],
              ),
              Text(
                timerString,
                textAlign: TextAlign.center,
                style: widget.textStyle,
              ),
            ],
          );
        });
  }
}

/// Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
class LabelCountDownTimerController {
  late LabelCountdownTimerState _state;
  late bool _isReverse;
  int? _initialDuration, _duration;

  /// This Method Starts the Countdown Timer
  void start() {
    if (_isReverse) {
      _state._controller?.reverse(
          from:
              _initialDuration == 0 ? 1 : 1 - (_initialDuration! / _duration!));
    } else {
      _state._controller?.forward(
          from: _initialDuration == 0 ? 0 : (_initialDuration! / _duration!));
    }
  }

  /// This Method Pauses the Countdown Timer
  void pause() {
    _state._controller?.stop(canceled: false);
  }

  /// This Method stops the Countdown Timer
  void stop() {
    _state._controller?.stop(canceled: true);
  }

  /// This Method Resumes the Countdown Timer
  void resume() {
    if (_isReverse) {
      _state._controller?.reverse(from: _state._controller!.value);
    } else {
      _state._controller?.forward(from: _state._controller!.value);
    }
  }

  /// This Method Restarts the Countdown Timer,
  /// Here optional int parameter **duration** is the updated duration for countdown timer

  void restart({int? duration}) {
    _state._controller!.duration =
        Duration(seconds: duration ?? _state._controller!.duration!.inSeconds);
    if (_isReverse) {
      _state._controller?.reverse(from: 1);
    } else {
      _state._controller?.forward(from: 0);
    }
  }

  /// This Method returns the **Current Time** of Countdown Timer i.e
  /// Time Used in terms of **Forward Countdown** and Time Left in terms of **Reverse Countdown**

  String getTime() {
    return _state
        ._getTime(_state._controller!.duration! * _state._controller!.value);
  }
}
