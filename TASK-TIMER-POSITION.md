# Tapşırıqda sürətli taymer

Avadanlıq tapşırıqlarında mövcud iş taymeri Tarix və vaxt sahəsindən dərhal sonraya köçürülür. Eyni DOM düyünü və mövcud seanslar saxlanılır.

Şəxsi tapşırıqlarda eyni yerdə Pomodoro bloku göstərilir: müddət, ümumi fokus vaxtı, Başlat/Davam et/Bitir. Başlat ADIBHomeBridge.timerAction, Bitir ADIBBrowserPomodoro.action(..., finish) istifadə edir; ikinci taymer modeli və əlavə şəbəkə sorğuları yaradılmır. Parametrlər mövcud əlavə əməliyyatlar menyusunda qalır. Yaradılmamış tapşırıqda başlanğıc düyməsi söndürülüb.

Yoxlamalar: python task_timer_position_test.py; python task_work_timer_attach_test.py. Telefon və masaüstü ölçüləri, mövcud idarələrin saxlanılması, təkrar bağlama, gec cavab zamanı düymə bloklanması və tarix dəyərinin dəyişməməsi.
