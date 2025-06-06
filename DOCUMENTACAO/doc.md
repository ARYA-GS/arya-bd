# Arya-BD: Sistema de Gerenciamento de Operações com Drones

Este repositório contém o código-fonte do banco de dados para o **Projeto Arya**, um sistema robusto para gerenciamento, monitoramento e operação de uma frota de drones. O sistema foi projetado para registrar ocorrências (como desastres ambientais ou urbanos), alocar drones para missões de monitoramento e gerar relatórios analíticos.

Toda a estrutura foi desenvolvida utilizando **Oracle SQL e PL/SQL**, seguindo boas práticas de normalização, segurança e modularidade.

## 🏗️ Arquitetura do Banco de Dados

O banco de dados é composto por tabelas normalizadas, views, procedures, functions, triggers e packages que, juntas, formam a espinha dorsal do sistema Arya.

### 📜 Modelo Entidade-Relacionamento (MER)

O esquema do banco de dados é centrado em algumas entidades principais:

* **Usuarios (`ARYA_USUARIO`):** Pessoas que registram as ocorrências.
* **Endereços (`ARYA_ENDERECO`):** Localização geográfica das ocorrências e dos hubs.
* **Ocorrências (`ARYA_OCORRENCIA`):** Eventos que necessitam de monitoramento (ex: queimadas, enchentes).
* **Hubs Operacionais (`ARYA_HUB_OPERACIONAL`):** Bases de onde os drones operam.
* **Drones (`ARYA_DRONE`):** Os veículos aéreos não tripulados.
* **Missões (`ARYA_MISSAO_DRONE`):** A alocação de um drone para atender a uma ocorrência específica.

### 📋 Dicionário de Tabelas

A seguir, uma descrição detalhada das tabelas criadas no script `tabelas.sql`:

| Tabela | Descrição |
| :--- | :--- |
| **ARYA_USUARIO** | Armazena os dados dos usuários que interagem com o sistema. |
| **ARYA_ENDERECO** | Tabela centralizada para armazenar informações de endereço com coordenadas geográficas. |
| **ARYA_AREA_OPERACAO**| Define as áreas geográficas onde os drones podem operar. |
| **ARYA_HUB_OPERACIONAL**| Armazena os hubs (centros de operação) dos drones, incluindo seu status (ativo, inativo, etc.). |
| **ARYA_DRONE** | Cadastro dos drones, contendo modelo, status, capacidade de carga, autonomia e a qual hub pertence. |
| **ARYA_OCORRENCIA** | Registro de todos os eventos, com tipo, nível de severidade, descrição e localização. |
| **ARYA_MISSAO_DRONE** | Tabela de associação que vincula um drone a uma ocorrência, registrando o início, o fim e o status da missão. |

## ⚙️ Objetos do Banco de Dados

O repositório está organizado em scripts SQL que criam diferentes tipos de objetos para garantir a lógica, integridade e performance do banco de dados.

### 1. Funções (`funcoes.sql`)

Funções customizadas que realizam cálculos específicos e retornam um valor.

* `pontuacao_severidade(p_nivel_severidade)`: Classifica o nível de severidade numérico (ex: 1-10) em categorias textuais ('Baixo', 'Médio', 'Alto').
* `ranking_ocorrencias_hub(p_id_hub)`: Retorna a quantidade total de ocorrências associadas a um hub específico.
* `calcula_risco(p_nivel_severidade)`: Calcula um índice de risco simples, multiplicando a severidade por um fator fixo (1.5).

### 2. Procedures (`procedures.sql`)

Procedures que encapsulam operações de DML (Data Manipulation Language) para cada tabela do sistema, permitindo a inserção, atualização e exclusão de registros de forma controlada.

* `insert_arya_[tabela]`: Adiciona um novo registro à tabela.
* `update_arya_[tabela]`: Atualiza um registro existente na tabela.
* `delete_arya_[tabela]`: Remove um registro da tabela.

### 3. Triggers (`triggers.sql`)

Gatilhos que são disparados automaticamente antes de operações de `INSERT` ou `UPDATE` para garantir a validação e a integridade dos dados.

* `arya_usuario_validacao`: Valida o formato do e-mail e garante que a data de nascimento não seja no futuro.
* `arya_endereco_validacao`: Garante que os valores de latitude e longitude estejam dentro dos limites geográficos válidos (-90 a 90 para latitude, -180 a 180 para longitude).
* `arya_drone_validacao`: Impõe regras de negócio, como status válidos ('ativo', 'inativo', 'em voo', 'manutencao') e valores positivos para alcance e carga.
* `arya_missao_drone_validacao`: Valida as regras de uma missão, como a data de fim não ser anterior à de início.

### 4. Packages (`package.sql`, `package_body.sql`)

O `pkg_arya_management` é o principal componente de lógica de negócio do banco de dados. Ele agrupa todas as procedures, funções e lógicas de relatórios em um único pacote modular e de fácil manutenção.

**Principais Componentes do Pacote:**
* **CRUD Procedures:** Centraliza todas as procedures de `INSERT`, `UPDATE` e `DELETE` para as tabelas do sistema.
* **Funções de Negócio:** Inclui as funções `fnc_pontuacao_severidade`, `fnc_ranking_ocorrencias_hub`, e `fnc_calcula_risco`.
* **Relatórios e Listagens:** Contém procedures e funções que retornam `SYS_REFCURSOR` para gerar relatórios complexos, como:
    * `fnc_rel_contagem_drones_status`: Contagem de drones por status.
    * `fnc_rel_ocorrencias_tipo_avg_sev`: Total de ocorrências por tipo e sua severidade média.
    * `fnc_rel_drones_por_hub`: Lista de drones agrupados por hub.
    * `prc_listar_drones_manutencao`: Lista drones que estão em manutenção.
    * `prc_listar_hubs_sem_drones`: Identifica hubs que não possuem drones associados.

## 🔗 Links Úteis

* [Link do GitHub](https://github.com/ARYA-GS/arya-bd)
* [Link do Youtube](https://#)


---

## 👥 Integrantes

| Nome | RM | 
| :--- | :--- | 
| José Neto | 553844
| Vitor Cruz | 553621
| Keven Ike | 553215