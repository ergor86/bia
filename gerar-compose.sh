#Atribui do primeiro ao sétimo caractere do hash do último commit para a variável versao
versao=$(git rev-parse HEAD | cut -c 1-7)

#Adiciona a linha TAG=<versao> dentro de .env
echo TAG=$versao >> .env

# Resolve todas as variáveis do compose-eb.yml (incluindo TAG do .env) e grava o resultado em compose-dev.yml
docker compose -f compose-eb.yml config --no-normalize > compose-dev.yml

#Remove a linha name: do compose-dev.yml, pois o EB não aceita essa linha
sed -i '/^name:/d' compose-dev.yml

#Substitui o compose.yml pelo arquivo com as variáveis resolvidas.
mv compose-dev.yml compose.yml