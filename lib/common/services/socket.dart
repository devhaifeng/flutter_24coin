import 'dart:async';

import 'package:flutter_24coin/common/values/constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  final String _url;
  bool _isConnected = false;
  int _reconnectDelay = 3000;
  Timer? _reconnectTimer;
  final Function(dynamic) onMessage;
  final Function() onConnected;
  final Function() onDisconnected;

  WebSocketService({
    required String url,
    required this.onMessage,
    required this.onConnected,
    required this.onDisconnected,
  }) : _url = url;

  void connect() {
    try {
      _channel = IOWebSocketChannel.connect(
        _url,
        headers: {'Authorization': 'token: ${Constants.wsToken}', 'User-Agent': 'FlutterWebSocketClient'},
      );
      _subscription = _channel!.stream.listen(
        (message) {
          onMessage(message);
        },
        onDone: () {
          _isConnected = false;
          onDisconnected();
          _scheduleReconnect();
        },
        onError: (error) {
          _isConnected = false;
          onDisconnected();
          _scheduleReconnect();
        },
      );

      _isConnected = true;
      onConnected();
    } catch (e) {
      _isConnected = false;
      onDisconnected();
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (_reconnectTimer != null) return;

    _reconnectTimer = Timer(Duration(milliseconds: _reconnectDelay), () {
      _reconnectTimer = null;
      connect();

      // 指数退避策略
      _reconnectDelay = (_reconnectDelay * 2).clamp(1000, 30000);
    });
  }

  void send(dynamic message) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(message);
    }
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _subscription?.cancel();
    _channel?.sink.close();
    _isConnected = false;
    onDisconnected();
  }

  bool get isConnected => _isConnected;
}
