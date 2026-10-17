# ADIB Android 1.1.9 — напоминание в стиле TickTick

Восстановленный проект ADIB Android 1.1.7 с исправлением показа карточки напоминания.

## Что изменено
- Когда приложение ADIB уже открыто, сигнал задачи запускает собственную нижнюю карточку-окно сразу, без стандартного системного баннера поверх неё.
- Карточка сохраняет дизайн из примера: тёмный затемнённый фон, белая компактная карточка снизу, дата/список/иконки, заголовок и кнопки «Отсрочка»/«Завершить».
- Свайп вверх от верхнего края карточки открывает свойства задачи.
- Если ADIB не открыт и нужно показывать карточку поверх другого приложения, Android требует одноразовое разрешение «Поверх других приложений»; без него остаётся системное уведомление как резервный вариант.

## Сборка
Проект `apktool/` собирается Apktool 3.0.3:

```sh
java -jar apktool_3.0.3.jar b apktool -o ADIB-unsigned.apk
zipalign -f -p 4 ADIB-unsigned.apk ADIB-aligned.apk
apksigner sign --ks <собственный-keystore> --ks-key-alias <alias> \\
  --out ADIB.apk ADIB-aligned.apk
```

Приватный ключ подписи в архив не включён. Для обновления установленного приложения требуется исходный сертификат подписи.

Сборка проверена Apktool, `zipalign -c` и `apksigner verify`. Проверка на физическом устройстве не выполнялась.


GitHub backup: the complete project is stored as Base64 chunks named `ADIB-Android-1.1.9-TickTick-Source.zip.b64.part-*`. Reassemble in lexical order with `cat ...part-* | base64 -d > ADIB-Android-1.1.9-TickTick-Source.zip`.
