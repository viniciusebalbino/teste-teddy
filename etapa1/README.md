Suponha que você esteja trabalhando em um servidor
Linux e precisa executar um contêiner Docker de uma
imagem específica. Descreva os passos necessários para
realizar essa tarefa, incluindo a instalação do Docker, a
obtenção da imagem desejada e a execução do
contêiner. Certifique-se de mencionar comandos
relevantes e considerar qualquer configuração adicional
necessária.

---

## 1. Preparação do Servidor (Execução do Script)

O script fornecido é responsável por **preparar o servidor Ubuntu** para rodar contêineres, realizando a instalação completa e configurada do Docker Engine e Docker Compose.

### 1.1. Passos para Executar o Script

Assumindo que você está no diretório onde o script está salvo:

1.  **Conceder Permissão de Execução:**
    ```bash
    chmod +x nome_do_seu_script.sh
    ```
2.  **Executar o Script:**
    ```bash
    ./nome_do_seu_script.sh
    ```

---

## 2. Implantação da Aplicação Nginx (Docker Compose)

Após a preparação do servidor, o próximo passo é utilizar o arquivo `docker-compose.yaml` e o conteúdo HTML para subir o contêiner Nginx.

### 2.1. Execução

1.  **Navegue** para o diretório `nginx/`:
    ```bash
    cd nginx
    ```
2.  **Suba a Aplicação:** Utilize o Docker Compose para rodar o serviço. O `docker-compose.yaml` garante que o diretório `./html` seja mapeado para dentro do contêiner (`/usr/share/nginx/html`) e que a porta 80 do host seja exposta.
    ```bash
    docker compose up -d
    ```

### 2.3. Validação

A aplicação estará acessível na porta 80 do servidor:

* **Acesso Local:** `http://localhost:80`
* **Acesso Remoto:** `http://ip_do_host:80`