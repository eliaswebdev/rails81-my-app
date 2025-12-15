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
