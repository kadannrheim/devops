# Развёртывание vpn wireguard на docker через docker-compose
## Переменную PASSWORD уже не используют. Теперь PASSWORD_HASH. Генерируем хэш с помощью команды
`docker run --rm -it ghcr.io/wg-easy/wg-easy wgpw 'my_password'`
Символы $ экранируем ещё одним $. Из негерации кавычки убираем. Мануал здесь https://github.com/wg-easy/wg-easy/blob/master/How_to_generate_an_bcrypt_hash.md

## Структура
wireguard-ui/
├── .env
├── docker-compose.yml
├── Dockerfile
# └── config/
#    └── wg-easy/
#        ├── wg0.conf
#        ├── privatekey
#        └── другие_файлы_конфигурации
