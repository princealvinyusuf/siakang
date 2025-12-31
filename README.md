# PASKER ID – Labour Market Intelligence (Mobile)

Flutter mobile app for Android and iOS that delivers labour market intelligence (LMI) snapshots for policymakers, analysts, researchers, and internal Kemnaker stakeholders.

## Features
- Home: key indicator cards, 12‑month unemployment trend chart, latest report preview with Tableau link.
- Reports: searchable/filterable library, summaries, PDF download links, deep link to interactive view.
- Report detail: embedded Tableau (WebView) page.
- Data: quick stat highlights and download shortcuts.
- Profile: role selection, language switch (ID/EN), notification toggles, privacy/About links.

## Project layout
- `lib/main.dart` – app entry + bottom navigation.
- `lib/screens/*` – Home, Reports, Report Detail (WebView), Data, Profile.
- `lib/data/mock_data.dart` – mock indicators, trends, report metadata.
- `lib/widgets/*` – reusable UI components.
- `lib/theme/app_theme.dart` – colors/typography using Google Fonts.
- `pubspec.yaml` – dependencies: `fl_chart`, `webview_flutter`, `url_launcher`, `google_fonts`.

## Getting started
1) Install Flutter (3.24+ recommended) and platform toolchains for Android/iOS.
2) From the repo root:
```bash
cd mobile_app
flutter pub get
# If platform folders are missing, generate them:
flutter create . --platforms=android,ios
```
3) Run the app:
```bash
flutter run -d android   # or -d ios / simulator
```

## Build
- Android: `flutter build apk` or `flutter build appbundle`
- iOS: `flutter build ipa` (on macOS with Xcode)

## Notes
- Replace the sample Tableau URL in `ReportDetailScreen` and `HomeScreen` with the real embed link.
- Replace mock PDF URLs with production files; `url_launcher` opens them externally.
- For iOS WebView, ensure ATS/network rules fit your Tableau host in `ios/Runner/Info.plist` after platforms are generated.

