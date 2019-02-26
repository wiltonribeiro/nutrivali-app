import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatelessWidget {

  final String url;
  WebView(this.url);

  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
          url: url,
          appBar: new AppBar(
            title: new Text("Nutrivali News"),
            backgroundColor: Theme.of(context).accentColor,
          ),
        ),
      },
    );
  }

}