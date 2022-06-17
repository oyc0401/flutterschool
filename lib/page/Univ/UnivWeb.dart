// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// // ignore_for_file: public_member_api_docs
//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutterschool/DB/UnivDB.dart';
// import 'package:flutterschool/page/Univ/UnivName.dart';
// import 'package:flutterschool/page/Univ/UnivSearch.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
//
//
//
// ///@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// ///
// ///@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// ///
// ///@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//
// String nowUnivCode = "000001";
// int nowYear = 2023;
//
// class UnivWeb extends StatefulWidget {
//   UnivWeb({
//     Key? key,
//     this.cookieManager,
//     required this.year,
//     required this.univCode,
//   }) : super(key: key);
//
//   final CookieManager? cookieManager;
//   final int year;
//   final String univCode;
//
//   @override
//   State<UnivWeb> createState() => _UnivWebState();
// }
//
// class _UnivWebState extends State<UnivWeb> {
//   @override
//   void initState() {
//     super.initState();
//     nowUnivCode = widget.univCode;
//   }
//
//   UnivWay univWay = UnivWay.comprehensive;
//
//   InAppWebViewController? webViewController;
//
//   Uri get _uri {
//     if (2022 <= nowYear && nowYear <= 2023) {
//       switch (univWay) {
//         case UnivWay.comprehensive:
//           return Uri.parse(
//               "https://adiga.kr/kcue/ast/eip/eis/inf/stdptselctn/eipStdGenSlcIemWebView.do?"
//               "sch_year=${nowYear}&univ_cd=${nowUnivCode}&iem_cd=${26}");
//         case UnivWay.subject:
//           return Uri.parse(
//               "https://adiga.kr/kcue/ast/eip/eis/inf/stdptselctn/eipStdGenSlcIemWebView.do?"
//               "sch_year=${nowYear}&univ_cd=${nowUnivCode}&iem_cd=${31}");
//
//         case UnivWay.sat:
//           return Uri.parse(
//               "https://adiga.kr/kcue/ast/eip/eis/inf/stdptselctn/eipStdGenSlcIemWebView.do?"
//               "sch_year=${nowYear}&univ_cd=${nowUnivCode}&iem_cd=${41}");
//       }
//     } else if (nowYear == 2021) {
//       switch (univWay) {
//         case UnivWay.comprehensive:
//           return Uri.parse(
//               "https://adiga.kr/kcue/ast/eip/eis/inf/stdptselctn/eipStdGenSlcIemWebView.do?"
//               "sch_year=${nowYear}&univ_cd=${nowUnivCode}&iem_cd=${30}");
//         case UnivWay.subject:
//           return Uri.parse(
//               "https://adiga.kr/kcue/ast/eip/eis/inf/stdptselctn/eipStdGenSlcIemWebView.do?"
//               "sch_year=${nowYear}&univ_cd=${nowUnivCode}&iem_cd=${31}");
//
//         case UnivWay.sat:
//           return Uri.parse(
//               "https://adiga.kr/kcue/ast/eip/eis/inf/stdptselctn/eipStdGenSlcIemWebView.do?"
//               "sch_year=${nowYear}&univ_cd=${nowUnivCode}&iem_cd=${32}");
//       }
//     } else if (nowYear == 2020) {
//       switch (univWay) {
//         case UnivWay.comprehensive:
//           return Uri.parse(
//               "https://adiga.kr/kcue/ast/eip/eis/inf/stdptselctn/eipStdGenSlcIemWebView.do?"
//               "sch_year=${nowYear}&univ_cd=${nowUnivCode}&iem_cd=${13}");
//         case UnivWay.subject:
//           return Uri.parse("https://www.google.co.kr/");
//
//         case UnivWay.sat:
//           return Uri.parse("https://www.google.co.kr/");
//       }
//     } else {
//       return Uri.parse("https://www.google.co.kr/");
//     }
//   }
//
//   void NavigateUnivSearch() async {
//     await Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UnivSearch(),
//       ),
//     );
//   }
//
//   Future<void> setUrl() async =>
//       await webViewController?.loadUrl(urlRequest: URLRequest(url: _uri));
//
//   void setUnivCode(String url) {
//     if (url.contains("eipStdGenSlcIemWebView.do?sch_year=")) {
//       int index = url.lastIndexOf('univ_cd=');
//
//       nowUnivCode = url.substring(index + 8, index + 8 + 7);
//       print("대학 코드: ${nowUnivCode}");
//
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: buildAppBar(),
//       body: InAppWebView(
//         // contextMenu: contextMenu,
//         initialUrlRequest: URLRequest(
//           url: _uri,
//         ),
//         onWebViewCreated: (controller) {
//           webViewController = controller;
//         },
//         onLoadStart: (controller, url) {
//           print(url);
//         },
//       ),
//       floatingActionButton: FavorateButton(),
//     );
//   }
//
//   AppBar buildAppBar() {
//     return AppBar(
//       toolbarHeight: 140,
//       title: Column(
//         children: [
//           Text(
//             UnivName.getUnivName(nowUnivCode),
//             style: TextStyle(color: Colors.black),
//           ),
//           Row(
//             children: [
//               CupertinoButton(
//                   child: Text("학종"),
//                   onPressed: () {
//                     univWay = UnivWay.comprehensive;
//                     setUrl();
//                   }),
//               CupertinoButton(
//                 child: Text("교과"),
//                 onPressed: () {
//                   univWay = UnivWay.subject;
//                   setUrl();
//                 },
//               ),
//               CupertinoButton(
//                 child: Text("정시"),
//                 onPressed: () {
//                   univWay = UnivWay.sat;
//                   setUrl();
//                 },
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               CupertinoButton(
//                   child: Text(
//                     "<<",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   onPressed: () {
//                     nowYear--;
//                     setUrl();
//                     setState(() {});
//                   }),
//               Text(
//                 "${nowYear}",
//                 style: TextStyle(color: Colors.black),
//               ),
//               CupertinoButton(
//                 child: Text(
//                   ">>",
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 onPressed: () {
//                   nowYear++;
//                   setUrl();
//                   setState(() {});
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         IconButton(
//           onPressed: NavigateUnivSearch,
//           icon: const Icon(
//             Icons.search,
//             size: 28,
//             color: Color(0xff191919),
//           ),
//         ),
//         //SampleMenu(_controller.future, widget.cookieManager),
//       ],
//     );
//   }
// }
//
// enum UnivWay {
//   comprehensive,
//   subject,
//   sat,
// }
//
// class FavorateButton extends StatefulWidget {
//   FavorateButton({Key? key}) : super(key: key);
//
//   @override
//   State<FavorateButton> createState() => _FavorateButtonState();
// }
//
// class _FavorateButtonState extends State<FavorateButton> {
//   Icon get _icon {
//     if (isFavorate) {
//       return const Icon(
//         Icons.favorite,
//         color: Colors.redAccent,
//       );
//     } else {
//       return const Icon(
//         Icons.favorite_border,
//         color: Color(0xff191919),
//       );
//     }
//   }
//
//   bool isFavorate = false;
//
//   init() async {
//     UnivDB univDB = UnivDB();
//     List<UnivInfo> univList = await univDB.getInfo();
//     for (UnivInfo univ in univList) {
//       // 이미 즐겨찾기를 했으면
//       if (univ.univCode == nowUnivCode) {
//         isFavorate = true;
//         print("즐겨찾기 O");
//         return;
//       }
//     }
//     // 즐겨찾기를 안했으면
//     isFavorate = false;
//     print("즐겨찾기 X");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: init(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         print("re build");
//         return FloatingActionButton(
//           backgroundColor: Colors.white,
//           onPressed: addFavorite,
//           child: _icon,
//         );
//       },
//     );
//   }
//
//   addFavorite() async {
//     if (isFavorate) {
//       await deleteUniv();
//       isFavorate = false;
//     } else {
//       await insertUniv();
//       isFavorate = true;
//     }
//     setState(() {});
//   }
//
//   insertUniv() {
//     UnivDB univDB = UnivDB();
//     univDB.insertInfo(UnivInfo(
//         id: nowUnivCode,
//         univName: UnivName.getUnivName(nowUnivCode),
//         univCode: nowUnivCode,
//         preference: UnivDB.lenght));
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("북마크에 추가했습니다."),
//       ),
//     );
//   }
//
//   deleteUniv() {
//     UnivDB univDB = UnivDB();
//     univDB.deleteInfo(nowUnivCode);
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("북마크에서 삭제했습니다."),
//       ),
//     );
//   }
// }
//
// // enum MenuOptions {
// //   showUserAgent,
// //   listCookies,
// //   clearCookies,
// //   addToCache,
// //   listCache,
// //   clearCache,
// //   navigationDelegate,
// //   doPostRequest,
// //   loadLocalFile,
// //   loadFlutterAsset,
// //   loadHtmlString,
// //   transparentBackground,
// //   setCookie,
// // }
// //
// // class SampleMenu extends StatelessWidget {
// //   SampleMenu(this.controller, CookieManager? cookieManager, {Key? key})
// //       : cookieManager = cookieManager ?? CookieManager(),
// //         super(key: key);
// //
// //   final Future<WebViewController> controller;
// //   late final CookieManager cookieManager;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<WebViewController>(
// //       future: controller,
// //       builder:
// //           (BuildContext context, AsyncSnapshot<WebViewController> controller) {
// //         return PopupMenuButton<MenuOptions>(
// //           key: const ValueKey<String>('ShowPopupMenu'),
// //           onSelected: (MenuOptions value) {
// //             switch (value) {
// //               case MenuOptions.showUserAgent:
// //                 _onShowUserAgent(controller.data!, context);
// //                 break;
// //               case MenuOptions.listCookies:
// //                 _onListCookies(controller.data!, context);
// //                 break;
// //               case MenuOptions.clearCookies:
// //                 _onClearCookies(context);
// //                 break;
// //               case MenuOptions.addToCache:
// //                 _onAddToCache(controller.data!, context);
// //                 break;
// //               case MenuOptions.listCache:
// //                 _onListCache(controller.data!, context);
// //                 break;
// //               case MenuOptions.clearCache:
// //                 _onClearCache(controller.data!, context);
// //                 break;
// //               case MenuOptions.navigationDelegate:
// //                 _onNavigationDelegateExample(controller.data!, context);
// //                 break;
// //               case MenuOptions.doPostRequest:
// //                 _onDoPostRequest(controller.data!, context);
// //                 break;
// //               case MenuOptions.loadLocalFile:
// //                 _onLoadLocalFileExample(controller.data!, context);
// //                 break;
// //               case MenuOptions.loadFlutterAsset:
// //                 _onLoadFlutterAssetExample(controller.data!, context);
// //                 break;
// //               case MenuOptions.loadHtmlString:
// //                 _onLoadHtmlStringExample(controller.data!, context);
// //                 break;
// //               case MenuOptions.transparentBackground:
// //                 _onTransparentBackground(controller.data!, context);
// //                 break;
// //               case MenuOptions.setCookie:
// //                 _onSetCookie(controller.data!, context);
// //                 break;
// //             }
// //           },
// //           itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
// //             PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.showUserAgent,
// //               enabled: controller.hasData,
// //               child: const Text('Show user agent'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.listCookies,
// //               child: Text('List cookies'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.clearCookies,
// //               child: Text('Clear cookies'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.addToCache,
// //               child: Text('Add to cache'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.listCache,
// //               child: Text('List cache'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.clearCache,
// //               child: Text('Clear cache'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.navigationDelegate,
// //               child: Text('Navigation Delegate example'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.doPostRequest,
// //               child: Text('Post Request'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.loadHtmlString,
// //               child: Text('Load HTML string'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.loadLocalFile,
// //               child: Text('Load local file'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.loadFlutterAsset,
// //               child: Text('Load Flutter Asset'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               key: ValueKey<String>('ShowTransparentBackgroundExample'),
// //               value: MenuOptions.transparentBackground,
// //               child: Text('Transparent background example'),
// //             ),
// //             const PopupMenuItem<MenuOptions>(
// //               value: MenuOptions.setCookie,
// //               child: Text('Set cookie'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Future<void> _onShowUserAgent(
// //       WebViewController controller, BuildContext context) async {
// //     // Send a message with the user agent string to the Toaster JavaScript channel we registered
// //     // with the WebView.
// //     await controller.runJavascript(
// //         'Toaster.postMessage("User Agent: " + navigator.userAgent);');
// //   }
// //
// //   Future<void> _onListCookies(
// //       WebViewController controller, BuildContext context) async {
// //     final String cookies =
// //         await controller.runJavascriptReturningResult('document.cookie');
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //       content: Column(
// //         mainAxisAlignment: MainAxisAlignment.end,
// //         mainAxisSize: MainAxisSize.min,
// //         children: <Widget>[
// //           const Text('Cookies:'),
// //           _getCookieList(cookies),
// //         ],
// //       ),
// //     ));
// //   }
// //
// //   Future<void> _onAddToCache(
// //       WebViewController controller, BuildContext context) async {
// //     await controller.runJavascript(
// //         'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
// //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //       content: Text('Added a test entry to cache.'),
// //     ));
// //   }
// //
// //   Future<void> _onListCache(
// //       WebViewController controller, BuildContext context) async {
// //     await controller.runJavascript('caches.keys()'
// //         // ignore: missing_whitespace_between_adjacent_strings
// //         '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
// //         '.then((caches) => Toaster.postMessage(caches))');
// //   }
// //
// //   Future<void> _onClearCache(
// //       WebViewController controller, BuildContext context) async {
// //     await controller.clearCache();
// //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //       content: Text('Cache cleared.'),
// //     ));
// //   }
// //
// //   Future<void> _onClearCookies(BuildContext context) async {
// //     final bool hadCookies = await cookieManager.clearCookies();
// //     String message = 'There were cookies. Now, they are gone!';
// //     if (!hadCookies) {
// //       message = 'There are no cookies.';
// //     }
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //       content: Text(message),
// //     ));
// //   }
// //
// //
// //
// //   Future<void> _onSetCookie(
// //       WebViewController controller, BuildContext context) async {
// //     await cookieManager.setCookie(
// //       const WebViewCookie(
// //           name: 'foo', value: 'bar', domain: 'httpbin.org', path: '/anything'),
// //     );
// //     await controller.loadUrl('https://httpbin.org/anything');
// //   }
// //
// //   Future<void> _onDoPostRequest(
// //       WebViewController controller, BuildContext context) async {
// //     final WebViewRequest request = WebViewRequest(
// //       uri: Uri.parse('https://httpbin.org/post'),
// //       method: WebViewRequestMethod.post,
// //       headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
// //       body: Uint8List.fromList('Test Body'.codeUnits),
// //     );
// //     await controller.loadRequest(request);
// //   }
// //
// //   Future<void> _onLoadLocalFileExample(
// //       WebViewController controller, BuildContext context) async {
// //     final String pathToIndex = await _prepareLocalFile();
// //
// //     await controller.loadFile(pathToIndex);
// //   }
// //
// //   Future<void> _onLoadFlutterAssetExample(
// //       WebViewController controller, BuildContext context) async {
// //     await controller.loadFlutterAsset('assets/www/index.html');
// //   }
// //
// //
// //
// //   Widget _getCookieList(String cookies) {
// //     if (cookies == null || cookies == '""') {
// //       return Container();
// //     }
// //     final List<String> cookieList = cookies.split(';');
// //     final Iterable<Text> cookieWidgets =
// //         cookieList.map((String cookie) => Text(cookie));
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.end,
// //       mainAxisSize: MainAxisSize.min,
// //       children: cookieWidgets.toList(),
// //     );
// //   }
// //
// //   static Future<String> _prepareLocalFile() async {
// //     final String tmpDir = (await getTemporaryDirectory()).path;
// //     final File indexFile = File(
// //         <String>{tmpDir, 'www', 'index.html'}.join(Platform.pathSeparator));
// //
// //     await indexFile.create(recursive: true);
// //
// //
// //     return indexFile.path;
// //   }
// // }
//
// // class NavigationControls extends StatelessWidget {
// //   const NavigationControls(this._webViewControllerFuture, {Key? key})
// //       : assert(_webViewControllerFuture != null),
// //         super(key: key);
// //
// //   final Future<WebViewController> _webViewControllerFuture;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<WebViewController>(
// //       future: _webViewControllerFuture,
// //       builder:
// //           (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
// //         final bool webViewReady =
// //             snapshot.connectionState == ConnectionState.done;
// //         final WebViewController? controller = snapshot.data;
// //         return Row(
// //           children: <Widget>[
// //             IconButton(
// //               icon: const Icon(Icons.arrow_back_ios),
// //               onPressed: !webViewReady
// //                   ? null
// //                   : () async {
// //                       if (await controller!.canGoBack()) {
// //                         await controller.goBack();
// //                       } else {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(content: Text('No back history item')),
// //                         );
// //                         return;
// //                       }
// //                     },
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.arrow_forward_ios),
// //               onPressed: !webViewReady
// //                   ? null
// //                   : () async {
// //                       if (await controller!.canGoForward()) {
// //                         await controller.goForward();
// //                       } else {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(
// //                               content: Text('No forward history item')),
// //                         );
// //                         return;
// //                       }
// //                     },
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.replay),
// //               onPressed: !webViewReady ? null: () {
// //                       controller!.reload();
// //                     },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //}