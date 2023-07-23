# riverpod

## 必要なパッケージ

```pubspec.yaml
dependencies:
  flutter_riverpod: // <- consumerwidget
  flutter_hooks: // <- hookwidget
  riverpod_annotation:

dev_dependencies:
  build_runner:
  riverpod_generator: 2.1.4

```

`riverpod_annotation` `build_runner` `riverpod_generator`は、state（状態）を作成する際に、使用する

## 状態のファイル

- `s1`：状態が「int 型」の場合

```s1.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 's1.g.dart';

@riverpod
class S1Notifier extends _$S1Notifier {
  @override
  int build() {
    // 最初のデータ
    return 0;
  }
}
```

- `s2`：状態が「List 型」の場合

```s2.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 's2.g.dart';

@riverpod
class S2Notifier extends _$S2Notifier {
  @override
  List<string> build() {
    // 最初のデータ
    return ['A', 'B', 'C'];
  }
}

```

- `s3`：状態が「Future 型」の場合

```s3.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 's3.g.dart';

@riverpod
class S3Notifier extends _$S3Notifier {
  Future<String> build() async {
    // 3秒まつ
    const sec3 = Duration(seconds: 3);
    await Future.delayed(sec3);
    // 最初のデータ
    return '最初のデータ';
  }
}

```

- `s4`：状態が「Stream 型」の場合

```s4.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 's4.g.dart';

@riverpod
class S4Notifier extends _$S4Notifier {
　@override
  Stream<String> build() {
    // 1秒ごとに通知を受け取る stream
    final controller = StreamController<String>();
    const sec1 = Duration(seconds: 1);
    final timer = Timer.periodic(sec1, (t) {
      controller.add('メッセージが${t.tick}件届きました');
    });
    // 4秒後にストップ
    const sec4 = Duration(seconds: 4);
    Future.delayed(sec4, () {
      timer.cancel();
      controller.sink.close();
    });
    return controller.stream;
  }
}

```

作りたいデータによって、「_$〇〇Notifier 」と記載し、上記のようなクラスを作成する。<br>
あとは、riverpod generatorを利用することで、自動で、「Notifier」と「Provider」が選ばれ、コードが作られる。<br>
riverpod generatorコマンドは、以下の通りです。

```shell
flutter pub run build_runner build --delete-conflicting-outputs
```
