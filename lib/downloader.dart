import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';

class Downloader extends StatefulWidget {
  const Downloader({Key? key}) : super(key: key);

  @override
  _DownloaderState createState() => _DownloaderState();
}

class _DownloaderState extends State<Downloader> {
  late OtaEvent currentEvent;

  @override
  void initState() {
    super.initState();
    tryOtaUpdate();
  }

  Future<void> tryOtaUpdate() async {
    try {
      OtaUpdate()
          .execute(
        'https://nrm.in.th/dl/production-health-offline-0.2.3.apk',
        // destinationFilename: 'production-health-offline-0.2.3.apk',
      )
          .listen(
        (OtaEvent event) {
          setState(() {
            currentEvent = event;
          });
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กำลังดาวโหลดเวอร์ชั่นใหม่'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('กำลังดาวโหลด'),
            Text(
              '${currentEvent.value}%',
              style: TextStyle(color: Colors.redAccent, fontSize: 50.0),
            ),
            const Text(
                'เมื่อดาวโหลดเสร็จสิ้น กรุณาเปิดอนุญาติติดตั้ง และกดปุ่ม Install'),
            const Text('เมื่อติดตั้งเสร็จกรุณาปิด App แล้วเปิดใหม่อีกครั้ง'),
          ],
        ),
      ),
    );
  }
}
