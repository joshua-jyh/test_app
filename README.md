# test_app

測試用 Rails 7.2 + Vue 3 專案。前端使用 Vite，開發與部署流程都不使用 Docker。

## 技術版本

- Ruby 3.3.2
- Rails 7.2
- Node.js 18.20.8
- Vue 3
- Vite 6
- 開發／測試：SQLite
- staging／production：MySQL

## 本機啟動

```bash
nvm use
bundle install
npm ci
bin/rails db:prepare
bin/dev
```

預設網址：

- Rails + Vue：http://localhost:3000
- Rails health check：http://localhost:3000/up
- Rails JSON API：http://localhost:3000/api/status

`bin/dev` 會透過 Foreman 同時啟動 Rails 與 Vite。

## 環境設定

```bash
cp .env.example .env
```

本機開發使用 SQLite，不需要額外資料庫服務。部署環境使用 `.env` 內的 MySQL 連線設定。

## 測試與建置

```bash
bin/rails test
npm run build
bin/rubocop
bin/brakeman --no-pager
```

## Initr 首次部署

先修改下列檔案中的主機名稱、資料庫帳號與資料庫名稱：

- `config/initr.deploy.yml`
- `config/initr.update.yml`

部署主機需先安裝 Ruby、Node.js 18、MySQL client、Nginx 與 `initr`。

```bash
sudo install -d -o "$USER" -g "$USER" /var/www/test_app/shared
install -m 600 /dev/null /var/www/test_app/shared/.env
$EDITOR /var/www/test_app/shared/.env

initr keygen --repo git@github.com:YOUR_ORG/test_app.git --host staging-01

initr deploy \
  --git git@github.com:YOUR_ORG/test_app.git \
  --env staging \
  --deploy-to /var/www/test_app
```

`.env` 內容可參考 `.env.example`，必須在首次 deploy 前填入正式的 MySQL 設定。

## Initr 更新

```bash
initr update --env staging --deploy-to /var/www/test_app
initr status staging
initr logs staging
```

若某次更新需要在 migration 前執行一次性 Rails task，可在
`config/initr.update.yml` 設定：

```yaml
update:
  task: data:backfill
```
