// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

bool openAssetPath(String assetPath) {
  final String encodedPath = assetPath
      .split('/')
      .map((String segment) => Uri.encodeComponent(segment))
      .join('/');
  final String assetUrl = Uri.parse(html.document.baseUri ?? '/')
      .resolve('assets/$encodedPath')
      .toString();

  final html.AnchorElement link = html.AnchorElement(href: assetUrl)
    ..target = '_blank'
    ..rel = 'noopener'
    ..style.display = 'none';

  html.document.body?.append(link);
  link.click();
  link.remove();

  return true;
}
