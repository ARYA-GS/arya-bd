---

## Documentação do Modelo de Banco de Dados

### 📊 Tabelas do Projeto (Modelo Conceitual)

Este documento descreve o **modelo conceitual** do banco de dados, detalhando as tabelas e seus atributos principais.

---

### 🧑‍💻 1. USUÁRIO

**Objetivo:** Representa os operadores do sistema.

**Atributos:**

* `usuario_id`: identificador único
* `nome`: nome completo
* `email`: único, usado para login
* `senha`: senha criptografada
* `data_criacao`: data de registro

---

### 🌍 2. REGIÃO (💡 atualizada)

**Objetivo:** Representa a área administrativa monitorada.

**Atributos:**

* `regiao_id`: identificador único
* `bairro`: nome do bairro
* `municipio`: cidade onde está localizada
* `estado`: UF (ex: SP, RJ)
* `classificacao_risco`: Baixo, Médio ou Alto (baseado em dados históricos ou manuais)

---

### 🔥 3. OCORRÊNCIA (💡 atualizada)

**Objetivo:** Representa eventos detectados pelo sistema (ex: temperatura elevada, fumaça).

**Atributos:**

* `ocorrencia_id`: identificador único
* `regiao_id`: FK para a tabela REGIÃO
* `tipo_ocorrencia`: exemplo: “Temperatura Elevada”, “Fumaça”
* `nivel_severidade`: Leve, Moderado, Crítico
* `data_ocorrencia`: data/hora da detecção
* `descricao`: texto livre explicando a ocorrência

---

### 📝 4. CADASTRO\_USUARIO

**Objetivo:** Registro das ações dos usuários em relação às ocorrências.

**Atributos:**

* `cadastro_id`: identificador único
* `usuario_id`: FK para USUÁRIO
* `ocorrencia_id`: FK para OCORRÊNCIA
* `data_cadastro`: quando foi feito o cadastro
* `observacoes`: campo para anotações ou comentários

---

### 🚁 5. DRONE

**Objetivo:** Simular drones fictícios utilizados para capturar imagens ou monitorar regiões.

**Atributos:**

* `drone_id`: identificador único
* `modelo`: nome/modelo fictício do drone
* `fabricante`: ex: “DJI”, “Parrot”
* `ativo`: sim/não (S/N) para indicar se o drone está em operação
* `regiao_id`: FK para REGIÃO monitorada (a qual o drone está “vinculado”)

---

### 📋 6. CADASTRO\_DRONE

**Objetivo:** Registra qual usuário cadastrou ou associou um drone ao sistema.

**Atributos:**

* `cadastro_drone_id`: identificador único
* `usuario_id`: FK para USUÁRIO
* `drone_id`: FK para DRONE
* `data_cadastro`: quando o drone foi registrado
* `status_operacao`: exemplo: “Simulado”, “Em teste”, “Desativado”
* `notas`: campo livre para anotações técnicas ou operacionais

---

### ✅ Resumo das Tabelas Atuais

| Nº  | Tabela           | Função Principal                                          |
| :-- | :--------------- | :-------------------------------------------------------- |
| 1   | **USUÁRIO** | Operadores do sistema                                     |
| 2   | **REGIÃO** | Localização administrativa dos eventos                    |
| 3   | **OCORRÊNCIA** | Eventos detectados (temperatura, fumaça etc.)             |
| 4   | **CADASTRO\_USUARIO** | Histórico de interação do usuário com ocorrências         |
| 5   | **DRONE** | Simulação dos drones que cobrem as regiões                |
| 6   | **CADASTRO\_DRONE** | Registro de quem cadastrou os drones e suas informações |
