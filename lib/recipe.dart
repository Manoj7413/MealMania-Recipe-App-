import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MakeIt extends StatefulWidget {
  final String name;
  final List<String> ingardint;
  final String? url; // WebView URL
  const MakeIt({super.key, required this.name, required this.ingardint, this.url});

  @override
  State<MakeIt> createState() => _MakeItState();
}

class _MakeItState extends State<MakeIt> {
  double _progress=0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    double scHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()async{
        var isLastPage=await inAppWebViewController.canGoBack();
        if(isLastPage){
          inAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFA726), Color(0xFFFF7043),],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_circle_left, size: 35),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Required Recipe',
              style: TextStyle(fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 5,
            toolbarHeight: 80,
          ),
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(widget.url??"https://www.google.com"),
                ),
                onWebViewCreated: (InAppWebViewController controller, ){
                  inAppWebViewController = controller;
                },
                onProgressChanged: (InAppWebViewController controller , int progress){//progress indicater
                  setState(() {
                    _progress = progress/100;
                  });
                },
              ),
              _progress < 1.0 ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(), // Shows a loading indicator while loading
              ) : SizedBox()
            ],
          )
        ),
      ),
    );
  }
}
