import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/global/resources/app_color.dart';

class WatchMovieScreen extends StatefulWidget {
  final int movieId;

  const WatchMovieScreen({super.key, required this.movieId});

  @override
  _WatchMovieScreenState createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  InAppWebViewController? controller;
  bool isLoading = true;
  bool hasInternet = true; // Track internet connectivity

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _checkConnectivity(); // Check connectivity on init
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    controller?.clearCache();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        hasInternet = false; // Update connectivity status
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Internet Connection')),
      );
    } else {
      setState(() {
        hasInternet = true; // Connectivity restored
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller != null && await controller!.canGoBack()) {
          controller!.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.gold,
          title: const Text("Watch Movie"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                controller?.reload(); // Reload current URL
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Page Reloaded')),
                );
              },
            ),
          ],
        ),
        body: Hero(
          tag: "hero",
          child: SafeArea(
            child: Stack(
              children: [
                if (hasInternet) // Show web view only if there's internet
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                          "https://vidsrc.net/embed/movie/${widget.movieId}"),
                    ),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        mediaPlaybackRequiresUserGesture: false,
                        javaScriptEnabled: true,
                      ),
                    ),
                    onWebViewCreated: (InAppWebViewController webController) {
                      controller = webController;
                    },
                    onLoadStop: (controller, url) {
                      setState(() {
                        isLoading = false; // Hide loading spinner
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      setState(() {
                        isLoading = false; // Hide loading spinner
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to load video: $message'),
                          action: SnackBarAction(
                            label: 'Retry',
                            onPressed: () {
                              controller?.reload();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                if (!hasInternet) // Show message if no internet
                  const Center(
                    child: Text(
                      "No internet connection. Please check your settings.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.gold),
                    ),
                  ),
                if (isLoading)
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.gold),
                        SizedBox(height: 10),
                        Text("Loading movie...",
                            style: TextStyle(color: AppColors.gold)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
