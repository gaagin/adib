# Sürətli başlanğıc

- Açıq JS/CSS resursları SHA-256 məzmun identifikatoru ilə ünvanlanır. Eyni fayl yeni buraxılışda yenidən endirilmir.
- HTML və bütün API cavabları `no-store` olaraq qalır. Service worker yalnız icazəli, məzmun identifikatorlu JS/CSS fayllarını saxlayır.
- Şəxsiyyət və icazə yoxlaması dəyişməyib. Hesab və ya icazə reviziyası dəyişəndə köhnə şəxsi məlumatlar əvvəlki qayda ilə təmizlənir.
- Təsdiqlənmiş istifadəçinin saxlanmış tapşırıqları fon yeniləməsini və şəbəkə vaxtını gözləmədən göstərilir.
- Pomodoro başlanğıcı və iş taymeri server əməliyyatları təsdiqlənmiş vaxt tələb edir; cihaz saatına keçid yoxdur.
- HTML/JS/CSS gzip ilə ötürülə bilər. İlk açılış kəşi doldurur; giriş yoxlaması və dəyişmiş faylların alınması üçün şəbəkə yenə lazımdır.

Yoxlamalar: `node --test test/ui-assets.test.cjs test/notion-date-picker.test.cjs`, `python ui_cache_browser_test.py`, `python fast_start_browser_test.py`, `python loading_ui_test.py`, `python account_ui_test.py`.
