# Modern Data Stack

Ainda estou desenvolvendo este repositorio, qualquer coisa pode me chamar no LinkedIn.

Esse repositório foi criado com o objetivo de estudar e construir uma arquitetura de dados moderna, seguindo os melhores padrões.

## Arquitetura

![Arquitetura Modern Data Stack](docs/images/modern-data-stack.png)

### 🔄 **Data Ingestion**
- **Apache Flink**: Processamento de streaming em tempo real
- **Framework Personalizado**: Conectores customizados para fontes específicas

### 🌊 **Ambiente de Dados**
- **Apache Airflow**: Orquestração de workflows
- **Landing Zone**: Camada de dados brutos com Apache Iceberg
- **Data Vault**: Modelagem de dados historizada
- **Business Vault**: Regras de negócio aplicadas
- **Information Schema**: 
  - **OBT (One Big Table)**: Tabelas desnormalizadas
  - **Star Schema**: Modelagem dimensional

### ⚙️ **Data Processor**
- **dbt (Data Build Tool)**: Transformações de dados em SQL

### 💾 **Data Storage and SQL Engine**
- **MinIO**: Armazenamento de objetos S3-compatível
- **Dremio**: Engine SQL distribuído e virtualização de dados

### 📊 **Data Governance and Monitoring**
- **Grafana**: Dashboards de monitoramento e observabilidade
- **Prometheus**: Coleta de métricas e alertas
- **OpenLineage**: Rastreamento de linhagem de dados
- **OpenMetadata**: Catálogo de dados e descoberta
- **Great Expectations**: Validação e qualidade de dados

### 🔧 **Services**
- **FastAPI**: APIs REST para exposição de dados
- **Metabase**: Business Intelligence open-source
- **Looker**: Plataforma de BI empresarial
- **Tableau**: Visualização avançada de dados

### 🏗️ **Infraestrutura**
- **Docker**: Containerização de aplicações
- **GitHub**: Controle de versão e colaboração
- **Git**: Versionamento de código
- **Jenkins**: Servidor de CI/CD para automação de builds e deploys
- **Terraform**: Infrastructure as Code
- **Terragrunt**: Wrapper para Terraform
- **Pre-commit**: Hooks de validação
- **SonarQube**: Análise de qualidade de código
- **Pytest**: Testes automatizados
- **Checkov**: Scanner de segurança para Infrastructure as Code (Terraform, Docker, K8s)
- **Trivy**: Scanner de vulnerabilidades para containers e dependências
- **OpenTelemetry**: Observabilidade distribuída com traces, métricas e logs

## Estrutura do Repositório

```
local-data-stack/
├── docs/
│   └── images/           # Diagramas da arquitetura
├── stack/
│   ├── airflow/          # DAGs do Airflow
│   ├── dbt/              # Transformações dbt
│   ├── infra/            # Infrastructure as Code
│   ├── docker/           # Containers e docker-compose
│   ├── tests/            # Testes automatizados
│   └── scripts/          # Scripts de setup e utilitários
└── README.md             # Documentação principal             
```

## Referencias

- https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs