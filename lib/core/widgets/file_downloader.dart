import 'package:dio/dio.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';

Future<void> downloadAndOpenFile(
  BuildContext context,
  String url, {
  String? fileName,
  bool showProgressDialog = true,
}) async {
  final dio = Dio();
  final progress = ValueNotifier<double>(0);

  try {
    fileName ??= Uri.parse(url).pathSegments.last;

    final dir = await getTemporaryDirectory();
    final savePath = '${dir.path}/$fileName';

    if (showProgressDialog) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          content: ValueListenableBuilder<double>(
            valueListenable: progress,
            builder: (_, v, __) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.tr.loading),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: v > 0 ? v : null),
                const SizedBox(height: 8),
                Text('${(v * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ),
        ),
      );
    }

    await dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total > 0) progress.value = received / total;
      },
    );

    if (showProgressDialog && context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    final result = await OpenFile.open(savePath);

    if (result.type != ResultType.done && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم التحميل ولا يوجد عارض مناسب لفتح الملف.'),
        ),
      );
    }
  } catch (e) {
    if (showProgressDialog && context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('فشل تحميل أو فتح الملف')));
    }
  } finally {
    progress.dispose();
  }
}
