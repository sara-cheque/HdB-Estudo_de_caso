#!/bin/bash

# Iniciar o deploy
echo "Realizando deploy no ambiente de stage"
python ./todo_project/run.py &  # Inicia o deploy em segundo plano
DEPLOY_PID=$!

# Aguardar o deploy iniciar
for i in {1..10}; do
    if curl -s http://localhost:5000 > /dev/null; then
        echo "Aplicação está rodando."
        break
    else
        echo "Aguardando a aplicação iniciar..."
        sleep 3
    fi
done