# MyApp

Bem-vindo ao **MyApp**! Esta é uma aplicação Ruby on Rails moderna, utilizando a stack padrão "Omakase" do Rails 8.1.

## 🛠 Tech Stack

- **Ruby**: 3.4.7
- **Rails**: 8.1.1
- **Database**: PostgreSQL
- **Frontend**:
  - [Hotwire](https://hotwired.dev/) (Turbo & Stimulus)
  - [Tailwind CSS](https://tailwindcss.com/) (via `tailwindcss-rails`)
  - [Importmap](https://github.com/rails/importmap-rails) (sem necessidade de Node.js/bundlers para JS)
- **Deployment**: [Kamal](https://kamal-deploy.org/) (Dockerizado)

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado em sua máquina:

- **Ruby 3.4.7** (Gerenciado via `asdf`)
- **PostgreSQL** (Serviço de banco de dados rodando)
- **Git**
- **libvips** (Necessário para processamento de imagens do Active Storage)
  - Ubuntu/Debian: `sudo apt install libvips`
  - macOS: `brew install vips`


## 🚀 Como rodar o projeto localmente

Siga os passos abaixo para configurar o ambiente de desenvolvimento:

### 1. Clone o repositório

```bash
git clone git@github.com:eliaswebdev/rails81-my-app.git
cd myapp
```

### 2. Instale as dependências

Instale a versão do Ruby e as gems do projeto:

```bash
asdf install
bundle install
```

### 3. Configuração do Banco de Dados

Certifique-se que o PostgreSQL está rodando e configure o banco de dados:

```bash
# Cria o banco de dados e roda as migrações iniciais
bin/rails db:prepare
```

> **Nota:** Se precisar configurar credenciais específicas do banco, edite o arquivo `config/database.yml` ou exporte as variáveis de ambiente necessárias.

### 4. Iniciando a Aplicação

Para iniciar o servidor web junto com o processamento de CSS (Tailwind), utilize o comando:

```bash
bin/dev
```

Acesse a aplicação em [http://localhost:3000](http://localhost:3000).

---

## 🧪 Testes

Para rodar a suíte de testes (Minitest):

```bash
bin/rails test
```

Para rodar testes de sistema (System Tests):

```bash
bin/rails test:system
```

## 📦 Deployment

Este projeto está configurado para deploy com **Kamal**.

```bash
kamal setup
```

Consulte a [documentação do Kamal](https://kamal-deploy.org/) para mais detalhes pré-requisitos de deploy.

## 🐳 Rodando com Docker (desenvolvimento)

Existe um `docker-compose.dev.yml` preparado para desenvolvimento com serviços para o app e o PostgreSQL.

1. Ajuste variáveis locais no arquivo `.env.development.local` (criado como exemplo).

2. Construir a imagem e subir os serviços:

```bash
docker compose -f docker-compose.dev.yml up --build
```

3. A aplicação ficará disponível em http://localhost:3000 e o banco em `localhost:5432`.

Observações:
- O `docker-compose.dev.yml` monta o código fonte em `/rails` dentro do container para facilitar desenvolvimento.
- Se sua aplicação usa `config/master.key` ou `RAILS_MASTER_KEY`, adicione o valor no `.env.development.local` antes de subir.

### Acessar o Rails Console via Docker

Use um destes comandos para abrir o `rails console` conectado ao banco que está sendo executado pelo `docker-compose`:

- Se o serviço `web` já estiver rodando (mantém o container em execução):

```bash
docker compose -f docker-compose.dev.yml exec web ./bin/rails console
```

- Para abrir um container efêmero (não precisa deixar o `web` em background):

```bash
docker compose -f docker-compose.dev.yml run --rm web ./bin/rails console
```

Dicas rápidas:

- Subir apenas o banco se necessário:

```bash
docker compose -f docker-compose.dev.yml up -d db
```

- Garantir que o esquema/migrações estejam aplicados:

```bash
docker compose -f docker-compose.dev.yml exec web ./bin/rails db:prepare
```

- Forçar variáveis de ambiente temporárias ao rodar o console:

```bash
docker compose -f docker-compose.dev.yml run --rm -e RAILS_ENV=development web ./bin/rails console
```

## **Makefile — atalhos úteis**

Incluí um `Makefile` com atalhos comuns para facilitar o dia a dia de desenvolvimento. Você pode ver todos os alvos executando:

```bash
make help
```

Comandos mais usados:

- **Iniciar os serviços (detached)**: `make up` (usa [docker-compose.dev.yml](docker-compose.dev.yml))
- **Parar e remover containers**: `make down`
- **Construir imagens**: `make build`
- **Abrir console (container em execução)**: `make console`
- **Console efêmero**: `make rconsole`
- **Preparar banco de desenvolvimento**: `make db_prepare`
- **Preparar banco de teste (evita EnvironmentMismatch)**: `make db_test_setup`
- **Rodar testes**: `make test`
- **Tailwind watcher**: `make css_watch`
- **Abrir shell no container web**: `make shell`

Exemplo rápido para preparar o banco de teste e rodar os testes:

```bash
# prepara o banco de teste (seta o env e carrega o schema)
make db_test_setup

# roda a suíte de testes
make test
```

Os alvos do `Makefile` chamam `docker compose -f docker-compose.dev.yml` quando apropriado, portanto garanta que o Docker Compose esteja instalado.

