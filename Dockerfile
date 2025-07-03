FROM python:3.12-alpine

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Assumindo que o Dockerfile está na raiz do projeto e o código em 'imersao-devops-main/'.
COPY ./imersao-devops-main/requirements.txt .

# Instala as dependências do projeto
# Usar --no-cache-dir ajuda a manter a imagem menor.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY ./imersao-devops-main/ .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn
# O host 0.0.0.0 permite que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]