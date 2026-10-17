# ADIB Android 1.1.7 — system Back fix

This update is based on the recovered 1.1.6 Android project. It fixes Android system Back for the WebView app: dismisses app overlays, menus, dialogs, search/filter panels and chat first; then uses in-app/WebView history; exits at the root. Android 13+ registers OnBackInvokedCallback; older Android uses Activity.onBackPressed.

## Complete recovered source

The complete Apktool/Smali project plus JADX-readable sources are stored as a split Base64 ZIP in this directory. APK binaries are excluded from the source archive.

```sh
cat android/1.1.7-system-back/ADIB-Android-1.1.7-SystemBack-Recovered-Source.zip.b64.part-* | base64 -d > ADIB-Android-1.1.7-SystemBack-Recovered-Source.zip
unzip -q ADIB-Android-1.1.7-SystemBack-Recovered-Source.zip
```

ZIP SHA-256: `19f86d7e5d15e2fcf940daec49d3fa6199732806a5a713293d21e56e84793b5e`

The project is recovered from the supplied 1.1.6 APK, not the original Gradle project. Build from `project/adib-android-1.1.7-system-back/apktool` with Apktool 3.0.3. Smali is the authoritative buildable source; JADX output is for reading.

## Verification

- Apktool build succeeded; package `com.adib.mobile.online`, version `1.1.7-system-back` (versionCode 9).
- APK signature verified. Certificate SHA-256 matches the supplied 1.1.6 APK: `76994dac75f25c7a2425bf235416f46d1db9669bbf194209cbfa8577532d56d3`.
- No physical device was connected for runtime verification.
