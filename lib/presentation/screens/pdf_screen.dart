// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:pdfview/presentation/widgets/constant_height_widget.dart';
import 'package:pdfview/presentation/widgets/icon_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final _flutterMediaDownloaderPlugin = MediaDownload();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Center(
            child: Text(
              "PDF View",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: const Color.fromARGB(255, 231, 227, 227),
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: SfPdfViewer.network(
                  "https://paytym.net/storage/pdfs/EMP18_PS_22-09-2023.pdf",
                ),
              ),
              const KHeight(
                size: 0.06,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 26,
                  right: 26,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconWidget(
                      icon: Icons.share_outlined,
                      onPressed: () {
                        Share.share(
                          'Check out this PDF: https://paytym.net/storage/pdfs/EMP18_PS_22-09-2023.pdf',
                        );
                      },
                    ),
                    IconWidget(
                      icon: Icons.file_download_outlined,
                      onPressed: () async {
                        _flutterMediaDownloaderPlugin.downloadMedia(
                          context,
                          "https://paytym.net/storage/pdfs/EMP18_PS_22-09-2023.pdf",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
