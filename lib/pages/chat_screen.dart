import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../helpers/encryption_helper.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({this.device});
  final BluetoothDevice device;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];
  // Bluetooth関連の変数
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  BluetoothCharacteristic _txCharacteristic;
  BluetoothCharacteristic _rxCharacteristic;
  List<BluetoothService> _services = [];

   @override
  void initState() {
    super.initState();
    _setupBluetoothConnection();
  }

    Future<void> _setupBluetoothConnection() async {
    // 接続可能なデバイスを探す
    await widget.device.connect();

    // デバイスのサービスを取得
    _services = await widget.device.discoverServices();

    // 適切なサービスとキャラクタリスティックを見つける
    for (final service in _services) {
      for (final characteristic in service.characteristics) {
        if (/* 送信用のキャラクタリスティックを特定する条件 */) {
          _txCharacteristic = characteristic;
        }
        if (/* 受信用のキャラクタリスティックを特定する条件 */) {
          _rxCharacteristic = characteristic;
          _setupMessageListener();
        }
      }
    }
  }

  void _setupMessageListener() {
    _rxCharacteristic?.setNotifyValue(true);
    _rxCharacteristic.value.listen((List<int> value) {
      setState(() {
        _messages.add(String.fromCharCodes(value));
      });
    });
  }

  void _sendMessage() {
    // final encryptedMessage = EncryptionHelper.encrypt(
    //     _messageController.text, 'your_encryption_key',);
        final message = _messageController.text;
    // ここで、実際にBluetoothを介してメッセージを送信する処理を実装してください。
    _txCharacteristic?.write(message.codeUnits);
    setState(() {
      _messages.add(_messageController.text);
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.device.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
