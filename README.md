# File System App

Este projeto é uma API Ruby on Rails que simula um sistema de arquivos com suporte a diretórios e upload de arquivos.

## 📌 Contexto

- A branch `main` realiza o upload de arquivos **localmente no disco**.
- A branch `feature/cloudflare-storage` envia arquivos para o **Cloudflare R2 (compatível com S3)** via `ActiveStorage`.

---

## 🚀 Como executar

1. Suba os serviços com Docker:

```bash
docker-compose up --build
```

2. Acesse os endpoints RESTful para criar diretórios e subir arquivos.

---

## 🗂️ Endpoints principais

### 1. Criar diretório

`POST /directories`

**Body JSON:**

```json
{
  "directory": {
    "name": "Novo"
  }
}
```

---

### 2. Upload de arquivo

`POST /stored_files`

**Form-data esperado:**

| Campo                       | Tipo   | Obrigatório | Descrição                  |
| --------------------------- | ------ | ----------- | -------------------------- |
| `stored_file[file]`         | File   | ✅          | Arquivo a ser enviado      |
| `stored_file[name]`         | String | ✅          | Nome do arquivo            |
| `stored_file[directory_id]` | Int    | ✅          | ID do diretório de destino |

**Exemplo cURL:**

```bash
curl --location 'http://localhost:3000/stored_files' \
--form 'stored_file[file]=@"/caminho/do/arquivo.txt"' \
--form 'stored_file[directory_id]="8"' \
--form 'stored_file[name]="documento.txt"'
```

---

## ☁️ Integração com Cloudflare R2 (S3 Compatible)

> A integração com armazenamento S3 está funcional na branch `feature/cloudflare-storage`.

Para preservar as credenciais, as variáveis de ambiente não são incluídas no repositório, mas a configuração do serviço está completa e validada via testes automatizados.

```yml
# config/storage.yml

cloudflare:
  service: CloudflareS3
  access_key_id: <%= ENV['R2_ACCESS_KEY_ID'] %>
  secret_access_key: <%= ENV['R2_SECRET_ACCESS_KEY'] %>
  region: auto
  bucket: <%= ENV["R2_BUCKET"] %>
  endpoint: <%= ENV['R2_ENDPOINT'] %>
  force_path_style: true
```

---

## ✅ Status atual

- [x] Upload local via disco
- [x] Upload via Cloudflare R2 (ActiveStorage com S3)
- [x] Testes com RSpec cobrindo a criação de diretórios e envio de arquivos

---

## 🛡️ Observações

> As chaves de acesso não estão inclusas no projeto por segurança. Para testar a integração com R2, configure suas variáveis de ambiente no `.env`.
