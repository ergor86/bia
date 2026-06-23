error() {
    echo "ERRO! ==> $1"
}

checar_ultimo_comando() {
    if [ $? != 0 ]; then
        error "Erro no deploy. Parando tudo..."
        exit 1;
    fi
}