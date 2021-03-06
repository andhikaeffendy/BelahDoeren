import 'dart:convert';

import 'package:belah_duren/global/variable.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapScreen extends StatefulWidget {
  final String transactionToken;
  final String gopayMode;

  SnapScreen({
    this.transactionToken,
    this.gopayMode,
  });

  @override
  _SnapScreenState createState() => _SnapScreenState();
}

class _SnapScreenState extends State<SnapScreen> {
  WebViewController webViewController;
  bool _isLoading = false;

  // PRO
  var client_key = "Mid-client-zzCJ3yDC_UNEzEAu";
  var snap_url = "https://app.midtrans.com/snap/snap.js";

  // DEV/SANDBOX
  // var client_key = "SB-Mid-client-Vte1E3n5e-1sisSy";
  // var snap_url = "https://app.sandbox.midtrans.com/snap/snap.js";

  Future<bool> _onBackPressed() {
    return Future.value(true);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Keluar Pembayaran'),
        content: new Text('Batalkan Pembelian'),
        actions: [
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(false),
            color: Colors.yellow[600],
            textColor: Colors.black,
            child: Text("Tidak",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(true),
            color: Colors.yellow[600],
            textColor: Colors.black,
            child: Text("Iya",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          )
        ],
      ),
    ) ?? false ;
  }

  @override
  void initState() {
    _isLoading = true;
    super.initState();
  }

  @override
  void didUpdateWidget(SnapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.brown),
          title: Text("Pilih Pembayaran", style: TextStyle(color: Colors.brown)),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Stack(
            children: <Widget>[
              WebView(
                initialUrl: '',
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                javascriptChannels: <JavascriptChannel>[
                  JavascriptChannel(
                    name: 'Payment',
                    onMessageReceived: (JavascriptMessage receiver) {
                      print('==========>>>>>>>>>>>>>> PAYMENT CHANNEL BEGIN');
                      print(receiver.message);
                      if (receiver.message != null || receiver.message != 'undefined') {
                        if (receiver.message == 'close') {
                          Navigator.pop(context);
                        } else {
                          _handleResponse(receiver.message);
                        }
                      }
                      print('==========>>>>>>>>>>>>>> END');
                    },
                  ),
                ].toSet(),
                onWebViewCreated: (_controller) {
                  webViewController = _controller;
                  _loadHtmlFromAssets();
                },
                onPageFinished: (strURL) {
                  setState(() {
                    _isLoading = false;
                  });
                },
                navigationDelegate: (NavigationRequest request) {
                  print(request.url);
                  if (request.url.contains("gojek:")) {
                    launch(request.url);
                    return NavigationDecision.prevent;
                  } else {
                    return NavigationDecision.navigate;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadHtmlFromAssets() {
    webViewController.loadUrl(Uri.dataFromString('''<html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script 
          type="text/javascript"
          src="${snap_url}"
          data-client-key="${client_key}"
        ></script>
      </head>

      <body onload="setTimeout(function(){pay()}, 1000)">
        <script type="text/javascript">
            function pay() {
                snap.pay('${widget.transactionToken}', {
                  // Optional
                  onSuccess: function(result) {
                    Payment.postMessage('ok');
                  },
                  // Optional
                  onPending: function(result) {
                    Payment.postMessage('pending');
                  },
                  // Optional
                  onError: function(result) {
                    Payment.postMessage('error');
                  },
                  onClose: function() {
                    Payment.postMessage('close');
                  },
                  gopayMode: '${widget.gopayMode}'
                });
            }
        </script>
      </body>
    </html>''', mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }

  _handleResponse(message) {
    try {
      var title, desc;
      switch (message) {
        case 'ok':
          title = 'Pembelian Berhasil';
          desc = '';
          break;
        case 'pending':
          title = 'Pembelian Berhasil';
          desc = 'Silahkan segera selesaikan pembayaran anda';
          break;
        case 'error':
          title = 'Fraud detection!';
          desc = 'Pembelian ditolak.';
          break;
      }
      if (title.length == 0 && desc.length == 0)
        alertDialog(context, "payment error", "Something went wrong!");
      else
        _showConfirmDialog(title, desc);
    } catch (e) {
      alertDialog(context, "payment error", e.toString());
    }
  }

  void _showConfirmDialog(title, desc) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  desc,
                ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.yellow[600])),
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                  color: Colors.yellow[600],
                  textColor: Colors.black,
                  child: Text("Selesai",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                )
              ],
            ),
          ),
        );
      },
    );
    Navigator.of(context, rootNavigator: true).pop();
  }
}