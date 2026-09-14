# Динамический план Ela Nov Paketleme

## 1. Подготовка

1. Установите Node.js 18 или новее.
2. Скопируйте `.env.example` в `.env`.
3. Заполните `.env`:
   - `NOTION_TOKEN` — секретный токен Notion-интеграции;
   - `PLAN_DATABASE_ID` — UUID базы Plan;
   - `MAKINA_DATABASE_ID` — UUID базы Makina;
   - `PLAN_DATA_SOURCE_ID` — ID источника данных Plan;
   - `MAKINA_DATA_SOURCE_ID` — ID источника данных Makina;
   - `TODO_DATABASE_ID` — UUID базы ToDo, если нужны задачи.
4. Предоставьте Notion-интеграции доступ к базам Plan, Makina и ToDo.

Для новых баз Notion оставьте также `PLAN_DATA_SOURCE_ID` и `MAKINA_DATA_SOURCE_ID` из `.env.example`. Версия API должна быть `NOTION_VERSION=2025-09-03`.

Не добавляйте `.env` в Git и не отправляйте его другим людям.

## 2. Запуск

Откройте терминал в этой папке и выполните:

```bash
npm start
```

Откройте в браузере:

```text
http://localhost:3000
```

Проверка сервера:

```text
http://localhost:3000/api/health
```

Данные плана:

```text
http://localhost:3000/api/plan-snapshot
```

## 3. Как работает обновление

HTML вызывает `/api/plan-snapshot` при нажатии «Обновить» и автоматически каждые 60 секунд. Сервер одним запросом получает Plan, Makina и ToDo из Notion и возвращает общий JSON-снимок.

## 4. Имена свойств

В базе Plan используются: `Plan`, `Parent Plan`, `Tip`, `X`, `Y`, `Eni`, `Uzunluğu`, `Scale`, `Status`.

В базе Makina используются: `Makina`, `Plan`, `Tip`, `Status`, `X`, `Y`, `Eni`, `Uzunluğu`, `Dönmə bucağı`.

Если в ToDo свойства называются иначе, измените три переменные `TODO_*` в `.env`.

## 5. Сохранение положения и размера

Перемещение и изменение размеров оборудования отправляются на сервер через `PATCH /api/layout` и записываются в свойства `X`, `Y`, `Eni` и `Uzunluğu` страницы Notion. Для этого у интеграции должно быть включено право `Update content`.

Если запись не удалась, ошибка появится под холстом. В этом случае проверьте окно сервера и доступ интеграции.


## Ссылки на элементы

Сервис формирует глубокие ссылки вида `...#element=equipment&id=...&zoom=2` для планов, машин и задач. Открытие такой ссылки сразу показывает нужный элемент с масштабом 200%; для задачи также открывается её карточка.

В базах Notion `Makina`, `ToDo` и `Gorulen isler` добавлено новое URL-свойство `ADIB link`. Сервис автоматически заполняет/обновляет его после первого обращения к `/api/plan-snapshot`. На Railway задайте `PUBLIC_APP_URL=https://adib-production-eba3.up.railway.app`. Для ручного запуска синхронизации используйте `POST /api/sync-links`.
