import 'dart:math';
import 'dart:typed_data';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prodictproj/models/book_model.dart';
import 'package:signature/signature.dart';

class ShowDetail extends StatefulWidget {
  final BookModel bookModel;
  const ShowDetail({Key? key, required this.bookModel}) : super(key: key);

  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  BookModel? bookModel;
  PDFDocument? pdfDocument;
  String? myChoose;

  SignatureController? signatureController;
  Uint8List? signature;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookModel = widget.bookModel;
    processLoadPDF();

    signatureController = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.yellow,
    );
  }

  @override
  void dispose() {
    signatureController!.dispose();
    super.dispose();
  }

  Future<Null> processLoadPDF() async {
    String pathPDFdemo =
        'https://www.androidthai.in.th/bigc/test/receipt_4.pdf';
    await PDFDocument.fromURL(pathPDFdemo).then((value) {
      setState(() {
        pdfDocument = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookModel!.BOOK_NAME),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            children: [
              buidPdf(constraints),
              buildSing(constraints),
              buildControlPanel(constraints),
            ],
          ),
        ),
      ),
    );
  }

  Container buildSing(BoxConstraints constraints) => Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(30),
          border: Border.all(),
        ),
        width: constraints.maxWidth * 0.8,
        height: constraints.maxHeight * 0.2,
        child: Signature(
          controller: signatureController!,
          backgroundColor: Colors.grey.shade200,
        ),
      );

  Container buildControlPanel(BoxConstraints constraints) {
    return Container(
      decoration: BoxDecoration(),
      width: constraints.maxWidth,
      height: constraints.maxHeight * 0.4,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    radioApprove(),
                    radioKnow(),
                    radioApprove2(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    radioApprove(),
                    radioKnow(),
                    radioApprove2(),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    processSave();
                  },
                  child: Text('Save'),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Send Per'),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Send Dep'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  RadioListTile<String> radioApprove2() {
    return RadioListTile(
      value: 'approve2',
      groupValue: myChoose,
      onChanged: (value) {
        setState(() {
          myChoose = value as String?;
        });
      },
      title: Text(
        'อนุญาติ',
        style: TextStyle(fontSize: 13),
      ),
    );
  }

  RadioListTile<String> radioKnow() {
    return RadioListTile(
      value: 'know',
      groupValue: myChoose,
      onChanged: (value) {
        setState(() {
          myChoose = value as String?;
        });
      },
      title: Text(
        'ทราบ',
        style: TextStyle(fontSize: 13),
      ),
    );
  }

  RadioListTile<String> radioApprove() {
    return RadioListTile(
      value: 'approve',
      groupValue: myChoose,
      onChanged: (value) {
        setState(() {
          myChoose = value as String?;
        });
      },
      title: Text(
        'อนุมัติ',
        style: TextStyle(fontSize: 13),
      ),
    );
  }

  Widget buidPdf(BoxConstraints constraints) {
    return pdfDocument == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.6,
            child: PDFViewer(document: pdfDocument!),
          );
  }

  Future<Null> processSave() async {
    await Permission.storage.status.then((value) async {
      if (!value.isGranted) {
        await Permission.storage.request();
      }
    });

    await signatureController!.toPngBytes().then((value) async {
      signature = value;

      int i = Random().nextInt(100000);
      String nameFile = 'singnature$i.png';

      final result =
          await ImageGallerySaver.saveImage(signature!, name: nameFile);
      print('### result ==>> ${result.toString()}');
    });
  }
}
