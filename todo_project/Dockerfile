# Usar uma imagem Python base
FROM python:3.9-slim

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o arquivo requirements.txt para o diretório de trabalho
COPY requirements.txt requirements.txt

# Instalar as dependências do projeto
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo o código da aplicação para o diretório de trabalho
COPY . .

# Definir a porta que o Flask vai usar
EXPOSE 5000

# Comando para iniciar a aplicação
CMD ["python", "run.py"]