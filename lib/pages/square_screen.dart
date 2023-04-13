import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bluetooth_provider.dart';

class SquareScreen extends StatefulWidget {
  @override
  _SquareScreenState createState() => _SquareScreenState();
}

class _SquareScreenState extends State<SquareScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BluetoothProvider>(context, listen: false).startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Square')),
      body: Consumer<BluetoothProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.devices.length,
            itemBuilder: (context, index) {
              final device = provider.devices[index];
              return ListTile(
                title: Text(device.name),
                onTap: () async {
                  await Navigator.pushNamed(context, '/chat', arguments: device);
                },
                onLongPress: () {
                  // ユーザーをブロックする機能を実装してください
                },
              );
            },
          );
        },
      ),
    );
  }
}
