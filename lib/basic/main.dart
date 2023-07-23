import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

main() {
  // アプリ
  // const app = MaterialApp(home: Sample());
  // プロバイダースコープでアプリを囲む
  // const scope = ProviderScope(child: app);
  // runApp(scope);
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: Sample(),
      ),
    ),
  );
}

// プロバイダー
final nicknameProvider = StateProvider<String>((ref) {
  // 変化するデータ
  return "ボタンを押してね";
});

// 画面
class Sample extends ConsumerWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // データを見張っておく
    final nickname = ref.watch(nicknameProvider);

    return Scaffold(
      // ニックネーム 1
      appBar: AppBar(title: Text(nickname)),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ニックネーム 2
            Text(nickname),
            // ボタン A
            ElevatedButton(onPressed: () => tapA(ref), child: const Text('A')),
            // ボタン B
            ElevatedButton(onPressed: () => tapB(ref), child: const Text('B')),
            // ボタン C
            ElevatedButton(onPressed: () => tapC(ref), child: const Text('C')),
            // ニックネーム 3
            Text(nickname),
          ],
        ),
      ),
    );
  }

  // ノティファイア でデータを変更する

  tapA(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'A が押されました';
  }

  tapB(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'B が押されました';
  }

  tapC(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'C が押されました';
  }
}
