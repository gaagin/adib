# İş taymeri — masaüstü brauzerdə Picture-in-Picture

İşə başla düyməsi ilə seans başladıldıqda ayrıca kompakt pəncərə açılır. Mövcud taymeri ▣ düyməsi ilə bu pəncərəyə keçirmək olar. Vaxta toxunmaq yığcam və adi rejimləri dəyişir.

Dayandır düyməsi mövcud seansı dayandırır; eyni pəncərədə başlanğıc və bitmə vaxtları redaktə edilir. Vaxtı yadda saxla düyməsinə qədər yaddaş əməliyyatı yoxdur. Sonra təsdiqlə düyməsi çıxarılıb. Pəncərəni bağlamaq taymeri dayandırmır; mövcud kart və redaktə qaralamaları əsas səhifəyə qaytarılır.

Chrome/Edge-də Document Picture-in-Picture API istifadə olunur. Dəstək olmadıqda ayrıca pop-up açılır (həmişə üstdə qalması təmin edilmir). Pop-up bloklanarsa taymer səhifədə işləməyə davam edir. Android və native desktop taymerləri dəyişdirilmir.

Yoxlama: python work_timer_pip_test.py (Playwright), python work_timer_pip_real_test.py; node --check work-timer-ui.js.
