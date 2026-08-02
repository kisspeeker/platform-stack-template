# platform-stack-template

## Быстрый старт

1. Create repository from this template (локально):
```bash
GROUP=gitlab-group
PROJECT=my-app

glab repo create "$GROUP/$PROJECT" --private -s

git remote add "$PROJECT" "git@gitlab.com:$GROUP/$PROJECT.git"
git push "$PROJECT" HEAD:master

# опционально
git remote remove "$PROJECT"
# git clone "git@gitlab.com:$GROUP/$PROJECT.git" "../$PROJECT"
```
2. DNS: `APP_DOMAIN` → сервер (`private` → NetBird IP).
3. Задать CI variables (`glab` ниже)

## Проставить [Project Variables](https://docs.gitlab.com/cli/variable/set/)
```bash
PROJECT_PATH=gitlab-group/my-app
DEPLOY_HOST=203.0.113.50
APP_DOMAIN=app.example.com
APP_VISIBILITY=private

# PROJECT (для каждого проекта)
glab variable list -R "$PROJECT_PATH" # список
glab variable set DEPLOY_HOST "$DEPLOY_HOST" -R "$PROJECT_PATH" -p -r
glab variable set APP_DOMAIN "$APP_DOMAIN" -R "$PROJECT_PATH" -p -r

# опционально
# glab variable set APP_VISIBILITY "$APP_VISIBILITY" -R "$PROJECT_PATH" -p -r
# glab variable set APP_PORT "3000" -R "$PROJECT_PATH" -p -r

# .env приложения
glab variable set APP_ENV -R "$PROJECT_PATH" -p -r < .env
```

## Начальные настройки

- Создать `PLATFORM_READ_TOKEN` (`read_repository` / `read_api` к `platform`)
  https://gitlab.com/-/user_settings/personal_access_tokens
- Job token: проект `platform` → Settings → CI/CD → Job token permissions → Default permissions для группы
- `glab auth login`
- Проставить [Group Variables](https://docs.gitlab.com/cli/variable/set/)
```bash
GROUP=gitlab-group
DEPLOY_USER=runner
PLATFORM_READ_TOKEN=glpat-xxx

glab variable list -g "$GROUP" # список
glab variable set DEPLOY_USER "$DEPLOY_USER" -g "$GROUP" -p -r
glab variable set DEPLOY_SSH_KEY -g "$GROUP" -p -r < ~/.ssh/ci_ed25519
glab variable set PLATFORM_READ_TOKEN "$PLATFORM_READ_TOKEN" -g "$GROUP" -p -r -m --hidden
```
