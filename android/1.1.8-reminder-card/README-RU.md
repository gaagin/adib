# ADIB Android 1.1.8 — карточка напоминания

Исходники восстановленного проекта ADIB Android 1.1.7 с изменениями для версии 1.1.8.

## Изменения
- Карточка напоминания приведена к размеру и композиции предоставленного образца: тёмный фон, компактная белая карточка, дата/контейнер/иконки в шапке, заголовок, пустая область и две кнопки снизу.
- Высота обычного окна — 270 dp; тестовое окно не изменено.
- Кнопка Pomodoro перемещена в шапку, а нижняя широкая кнопка убрана.
- Свайп вверх за верхнюю кромку карточки открывает свойства задачи ADIB.
- Увеличено затемнение фона; обработчик жеста и версия включены в Smali-проект и Java-исходники.

## Сборка
Проект `apktool/` собирается Apktool 3.0.3:

```sh
java -jar apktool_3.0.3.jar b apktool -o ADIB-unsigned.apk
zipalign -f -p 4 ADIB-unsigned.apk ADIB-aligned.apk
apksigner sign --ks <собственный-keystore> --ks-key-alias <alias> \\
  --out ADIB.apk ADIB-aligned.apk
```

В архиве нет приватного ключа подписи. Для обновления уже установленной копии Android требует сертификат, которым была подписана установленная версия; иначе нужно удалить старую копию или подписать тем же ключом.

Сборка проверена Apktool, `zipalign -c` и `apksigner verify`. Проверка на физическом Android-устройстве не выполнялась.


GitHub backup note: the full source archive is stored in Base64 chunks named `ADIB-Android-1.1.8-Reminder-Source.zip.b64.part-*`. Reassemble in lexical order with `cat ...part-* | base64 -d > ADIB-Android-1.1.8-Reminder-Source.zip`.
