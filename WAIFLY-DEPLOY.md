# ADIB — размещение на Waifly

## 1. Создание сервера

1. Откройте https://dash.waifly.com
2. Создайте аккаунт. Банковская карта для бесплатного плана не нужна.
3. Откройте **Servers** и нажмите **Create**.
4. Укажите:
   - Name: `adib-plan`
   - Egg: `NodeJS`
   - Location: `FR2` или `FR1`, если FR2 недоступен
   - Free resources: 30% CPU, 300 MiB RAM, 1024 MiB disk
5. Не выбирайте WordPress.

## 2. Загрузка проекта

1. Откройте созданный сервер.
2. Перейдите в его Pterodactyl Panel.
3. Откройте **Files**.
4. Загрузите в корень сервера:
   - `server.js`
   - `package.json`
   - `ela-nov-paketleme-dynamic.html`
5. Создайте файл `.env` в корне сервера.

Файл `.env` должен содержать ваши значения:

```env
NOTION_TOKEN=secret_...
PLAN_DATABASE_ID=...
MAKINA_DATABASE_ID=...
PLAN_DATA_SOURCE_ID=...
MAKINA_DATA_SOURCE_ID=...
TODO_DATABASE_ID=0ac3a96e-4687-4194-84cd-de563a12d85a
TODO_DATA_SOURCE_ID=b3d991ebc75b47ab8a88d2c723bc56db
GORULEN_ISLER_DATABASE_ID=02f39358-ebb4-4d32-b164-249f39ea2949
GORULEN_ISLER_DATA_SOURCE_ID=3136a23f839c40d3b6387de4d60af7f5
NOTION_VERSION=2025-09-03
CORS_ORIGIN=*
```

Не загружайте `.env` в GitHub и не публикуйте его.

## 3. Запуск

Откройте **Console** и выполните:

```bash
npm start
```

В `package.json` уже указана команда:

```json
"start": "node server.js"
```

Сервер использует встроенные модули Node.js, поэтому отдельная установка npm-пакетов для текущей версии не требуется.

## 4. Проверка

После запуска скопируйте адрес из поля **Web address** Waifly и откройте его в браузере.

Проверьте:

```text
https://ваш-адрес-waifly/
https://ваш-адрес-waifly/api/plan-snapshot?full=1
```

Первый адрес должен открыть ADIB. Второй должен вернуть JSON со снимком планов и машин.

## Важно

Бесплатный план Waifly ограничен 300 MiB RAM, 1 GB диска и 30% CPU. Для текущего лёгкого Node.js-сервера этого должно хватить. Серверные файлы не должны записывать большой кэш на диск.
