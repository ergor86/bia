versao=$(git rev-parse HEAD | cut -c 1-7)
#Comandos para enviar imagem versionada para o ECR da AWS
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 632872792512.dkr.ecr.us-east-1.amazonaws.com
docker build -t bia .
docker tag bia:latest 632872792512.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
docker push 632872792512.dkr.ecr.us-east-1.amazonaws.com/bia:$versao

#apagando arquivo pré-existente
rm .env 2> /dev/null

#chamando script para gerar o compose.yml com versão atualizada da imagem
./gerar-compose.sh

rm bia-versao-*.zip
zip -r bia-versao-$versao.zip compose.yml

#voltando o compose.yml para versão original
git checkout compose.yml
