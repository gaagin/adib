# Android source backup — 1.1.6 (recovered)

This is a Base64-split ZIP of the recovered Android source snapshot. APK binaries are excluded from this source backup.

Reassemble from the repository root:

```sh
cat android/1.1.6-recovered/ADIB-Android-1.1.6-Recovered-Source.zip.b64.part-* | base64 -d > ADIB-Android-1.1.6-Recovered-Source.zip
unzip -q ADIB-Android-1.1.6-Recovered-Source.zip -d ADIB-Android-1.1.6-Recovered-Source
```

ZIP SHA-256: `99457a923ad5d2fa9b210319def4e3a74077399a04f76c311b09834496159594`

Recovered from the uploaded APK with JADX 1.5.6 and Apktool 3.0.3. It is not the original Gradle project; JADX reports four problematic fragments. The Apktool/Smali project rebuild was verified.
