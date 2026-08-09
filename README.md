# Excel Guru — Android App (Flutter)

Yeh ek complete, ready-to-build Flutter app hai jisme:

- **Lessons** — Excel Basics, Formulas, IF/AND/OR, VLOOKUP, Text/Date functions, Charts/Pivot, Shortcuts (Hinglish me, real formula examples ke saath)
- **Quiz** — har topic ke MCQ quiz, score save hota hai
- **Practice Simulator** — ek mini live spreadsheet jisme user khud formula type karke turant result dekh sakta hai (SUM, AVERAGE, IF, VLOOKUP jaisa nahi par SUM/AVG/MIN/MAX/COUNT/IF/AND/OR + cell refs)
- **AdMob ads** (banner + interstitial) — free users ko dikhte hain
- **Premium unlock** (in-app purchase) — ads hatane aur advanced lessons/quiz unlock karne ke liye

Sirf `lib/` folder aur `pubspec.yaml` yahan hain — Android/iOS "native shell" khud `flutter create` se generate hoga (neeche step 2).

---

## Step 1 — Apne computer par install karein (ek baar)

1. **Flutter SDK**: https://docs.flutter.dev/get-started/install/windows — installer chalayein, PATH me add ho jayega.
2. **Android Studio**: https://developer.android.com/studio — isse Android SDK aur emulator milta hai.
3. Terminal me check karein:
   ```bash
   flutter doctor
   ```
   Jo bhi ❌ dikhe (Android licenses, SDK path) usko `flutter doctor --android-licenses` ya Android Studio ke SDK Manager se fix karein.

## Step 2 — Naya Flutter project banayein aur yeh code copy karein

```bash
flutter create --org com.yourname excel_guru
```

Fir is folder (`ExcelGuruApp`) ke andar se:
- `pubspec.yaml` ko naye `excel_guru/pubspec.yaml` par **overwrite** karein
- `lib/` poora folder naye `excel_guru/lib/` par **overwrite** karein

Fir project ke andar:
```bash
flutter pub get
```

## Step 3 — App test karein (abhi test ads ke saath chalega)

```bash
flutter run
```

Phone USB se connect karein (Developer Mode + USB Debugging ON) ya ek Android emulator start karein. Abhi ke liye AdMob **test ad unit IDs** already lagi hain (`lib/services/ad_service.dart` me) — isliye ads turant dikhengi, koi real earning nahi hogi. Real earning ke liye Step 5 zaroori hai.

## Step 4 — App ki apni pehchaan (name, icon, package id)

1. **Package/App ID** badlein: `android/app/build.gradle` me `applicationId "com.yourname.excel_guru"` — yeh unique hona chahiye (Play Store par duplicate allowed nahi).
2. **App name**: `android/app/src/main/AndroidManifest.xml` me `android:label="Excel Guru"`.
3. **App icon**: `flutter_launcher_icons` package use karein — apna logo (1024x1024 PNG) design karke `pubspec.yaml` me configure karein, ya Android Studio ke Image Asset tool se.

## Step 5 — AdMob se real earning start karein

1. https://admob.google.com par account banayein (Google account se, free).
2. **Apps → Add App** — Android select karein, "Not published on Play Store yet" (pehli baar).
3. App ka **App ID** milega (`ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY`) — isse `android/app/src/main/AndroidManifest.xml` me `<application>` tag ke andar add karein:
   ```xml
   <meta-data
       android:name="com.google.android.gms.ads.APPLICATION_ID"
       android:value="ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY"/>
   ```
4. **Ad units** banayein — ek "Banner" aur ek "Interstitial". Dono ki Ad Unit ID milegi.
5. `lib/services/ad_service.dart` file kholein aur `bannerAdUnitId` / `interstitialAdUnitId` me apni real IDs daal dein (abhi Google ki test IDs hain).
6. AdMob payout ke liye **Payments** section me bank account, PAN details fill karein (India ke liye). Minimum payout threshold cross hone par har mahine paise account me aate hain.

## Step 6 — Premium (in-app purchase) set up karein

1. Play Console me app upload karne ke baad (Step 7), **Monetize → Products → In-app products** me jaakar ek product banayein:
   - Product ID: `excel_guru_premium_unlock` (yeh exact match hona chahiye `lib/services/purchase_service.dart` ke `premiumProductId` se)
   - Type: One-time purchase, price set karein (jaise ₹99)
   - Activate karein.
2. Yeh product tabhi purchase-able hota hai jab app ek baar signed build me Play Console par upload ho chuki ho (kam se kam Internal Testing track par) — naya app turant test nahi hoga.
3. Testing ke liye Play Console me apna Gmail **License Tester** add karein (Setup → License testing) taaki bina real payment ke test kar sakein.

## Step 7 — Play Store par publish karein

1. **Signing key banayein** (ek baar, isse safely save rakhein — kho gayi to app update kabhi nahi kar payenge):
   ```bash
   keytool -genkey -v -keystore excel_guru_key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias excelguru
   ```
2. `android/key.properties` file banayein:
   ```
   storePassword=<aapka password>
   keyPassword=<aapka password>
   keyAlias=excelguru
   storeFile=<path to excel_guru_key.jks>
   ```
3. `android/app/build.gradle` me signing config add karein (Flutter docs: "Build and release an Android app" — search "signing the app").
4. Release build banayein:
   ```bash
   flutter build appbundle
   ```
   Output: `build/app/outputs/bundle/release/app-release.aab`
5. https://play.google.com/console par jaakar (**one-time $25 registration fee** — lifetime) naya app create karein:
   - Store listing: title, short/long description, screenshots (kam se kam 2), feature graphic, app icon
   - **Privacy Policy URL** — zaroori hai (ads + purchases use karne ke liye). Free me Google Sites ya Blogger par ek simple privacy policy page bana ke publish kar sakte hain.
   - Content rating questionnaire fill karein
   - **Data safety** section: batayein ki app ads dikhata hai (AdMob) aur purchases collect karta hai
   - `.aab` file upload karein Internal Testing track par pehle, test karein, fir Production par promote karein.
6. Review me Google ko 1-7 din lag sakte hain.

## App ka structure (agar aage content badhana ho)

```
lib/
  data/lessons_data.dart   ← naye lessons yahan add karein (bas List me item badhayein)
  data/quiz_data.dart      ← naye quiz questions yahan
  services/formula_engine.dart  ← simulator ka formula engine (SUM/IF/etc.)
  services/ad_service.dart      ← AdMob ad unit IDs
  services/purchase_service.dart← premium purchase logic
  screens/                 ← saari UI screens
```

Naye lessons/quiz add karne ke liye sirf `lessons_data.dart` / `quiz_data.dart` me naya entry likhna hota hai — koi aur file badalne ki zaroorat nahi.

## Earning tips

- Zyada users = zyada ad revenue. Play Store me achhe screenshots, clear title ("Excel Sikhein Hindi Me — Excel Guru") aur keywords (Excel, spreadsheet, formulas) se organic downloads badhte hain.
- Regularly naye lessons/quiz add karte rahein — Play Store "recently updated" apps ko thoda better rank karta hai.
- Premium price bahut kam rakhein shuru me (₹49-99) taaki zyada log convert karein.
- AdMob me "Interstitial" ads bahut zyada frequency par mat dikhayein — is app me har 3 lesson/quiz ke baad ek dikhta hai, isse users irritate nahi hote aur retention better rehta hai (jo long-term earning ke liye zaroori hai).
