source utils.sh

versao=$(git rev-parse HEAD | cut -c 1-7)

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 632872792512.dkr.ecr.us-east-1.amazonaws.com
checar_ultimo_comando
docker build -t bia .
docker tag bia:latest 632872792512.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
docker push 632872792512.dkr.ecr.us-east-1.amazonaws.com/bia:$versao

rm .env 2> /dev/null
./gerar-compose.sh

# renomeia pro nome que o EB espera
cp compose.yml docker-compose.yml

rm -f bia-versao.zip
zip bia-versao.zip docker-compose.yml

# limpa
rm docker-compose.yml
git checkout compose.yml