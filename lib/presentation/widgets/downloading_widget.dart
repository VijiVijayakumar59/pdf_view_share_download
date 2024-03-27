// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfview/presentation/widgets/constant_height_widget.dart';

class DownloadingWidget extends StatefulWidget {
  const DownloadingWidget({super.key});

  @override
  State<DownloadingWidget> createState() => _DownloadingWidgetState();
}

class _DownloadingWidgetState extends State<DownloadingWidget> {
  Dio dio = Dio();
  double progress = 0.0;
  void startDownloadin() async {
    const String url =
        "https://paytym.net/storage/pdfs/EMP18_PS_22-09-2023.pdf";
    const String fileName = "PDF.jpg";
    String path = await getFilePath(fileName);
    await dio.download(
      url,
      path,
      onReceiveProgress: (receivedBytes, totalBytes) {
        setState(() {
          progress = receivedBytes / totalBytes;
        });
        print(progress);
      },
      deleteOnError: true,
    ).then((value) => {
          Navigator.pop(context),
        });
  }

  Future<String> getFilePath(String filename) async {
    final dir = await getApplicationSupportDirectory();
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloadin();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const KHeight(
            size: 0.02,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
