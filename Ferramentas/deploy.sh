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

# Executar a verificação de segurança com OWASP ZAP
echo "Iniciando a verificação de segurança com OWASP ZAP..."
mkdir /home/runner/work/HdB-Estudo_de_caso/HdB-Estudo_de_caso/relatorios
if docker run --network host -v $(pwd):/HdB-Estudo_de_caso/relatorios -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t http://localhost:5000 -r ./HdB-Estudo_de_caso/relatorios/report.html; then
    echo "Verificação de segurança concluída com sucesso."
else
    echo "Erro na verificação de segurança."
fi

# Parar o processo do deploy
echo "Parando o deploy..."
kill $DEPLOY_PID
wait $DEPLOY_PID  # Aguardar o processo do deploy terminar
