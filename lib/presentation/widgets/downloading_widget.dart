import 'dart:developer';

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

  void startDownloading() async {
    try {
      const String url =
          "https://paytym.net/storage/pdfs/EMP18_PS_22-09-2023.pdf";
      const String fileName = "PDF.pdf";
      String path = await getFilePath(fileName);
      log(path.toString());

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
      ).then((value) {
        Navigator.pop(context);
      });
    } catch (e) {
      print('Error downloading: $e');
    }
  }

  Future<String> getFilePath(String filename) async {
    final dir = await getApplicationSupportDirectory();
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloading(); // Corrected method name
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
