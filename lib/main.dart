import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hooks ProgressBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hooks ProgressBar'),
        ),
        body: Center(
          /// アニメーションに掛ける時間として、Durationクラスを渡す。仮で5秒を設定。
          child: HooksProgressBar(
            progressTime: Duration(seconds: 5),
          ),
        ),
      ),
    );
  }
}

class HooksProgressBar extends HookWidget {
  const HooksProgressBar({Key key, @required this.progressTime})
      : super(key: key);

  final Duration progressTime;

  @override
  Widget build(BuildContext context) {
    /// forwardは1回きり。repeatで繰り返しの表現となりますが、プログレスバーなので1回で良いかなと。
    final controller = useAnimationController(
      duration: progressTime,
    )..forward();

    /// AnimatedBuilderを使うことがポイント✨✨これがないとアニメーションしない。
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return LinearProgressIndicator(
          value: controller.value,

          /// 色を変更したい場合も念のため、記載しておきます。微妙にハマったので。
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
        );
      },
    );
  }
}
