-- 1. ARYA_USUARIO
CREATE TABLE ARYA_USUARIO (
    id_usuario VARCHAR2(50) NOT NULL,
    nome VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    senha VARCHAR2(255) NOT NULL,
    data_nasc DATE,
    CONSTRAINT pk_arya_usuario PRIMARY KEY (id_usuario)
);

-- 2. ARYA_ESPECIFICACAO
CREATE TABLE ARYA_ESPECIFICACAO (
    id_especificacao VARCHAR2(50) NOT NULL,
    fabricante VARCHAR2(100),
    autonomia_minutos NUMBER, 
    tipo_drone VARCHAR2(100), 
    modelo VARCHAR2(100),
    CONSTRAINT pk_arya_especificacao PRIMARY KEY (id_especificacao)
);

-- 3. ARYA_ENDERECO
CREATE TABLE ARYA_ENDERECO (
    id_endereco VARCHAR2(50) NOT NULL,
    bairro VARCHAR2(100),
    cidade VARCHAR2(100) NOT NULL,
    estado VARCHAR2(50) NOT NULL,
    pais VARCHAR2(50) NOT NULL,
    latitude NUMBER,
    longitude NUMBER,
    CONSTRAINT pk_arya_endereco PRIMARY KEY (id_endereco)
);

-- 4. ARYA_AREA_OPERACAO
CREATE TABLE ARYA_AREA_OPERACAO (
    id_area_operacao VARCHAR2(50) NOT NULL,
    latitude_central NUMBER NOT NULL,
    longitude_central NUMBER NOT NULL,
    CONSTRAINT pk_arya_area_operacao PRIMARY KEY (id_area_operacao)
);

-- 5. ARYA_HUB_OPERACIONAL
CREATE TABLE ARYA_HUB_OPERACIONAL (
    id_hub VARCHAR2(50) NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    status VARCHAR2(50),
    id_endereco VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_arya_hub_operacional PRIMARY KEY (id_hub)
);

-- 6. ARYA_DRONE
CREATE TABLE ARYA_DRONE (
    id_drone VARCHAR2(50) NOT NULL,
    id_hub VARCHAR2(50),
    nome VARCHAR2(100) NOT NULL,
    status VARCHAR2(50),
    id_especificacao VARCHAR2(50) NOT NULL,
    carregamento VARCHAR2(255),
    CONSTRAINT pk_arya_drone PRIMARY KEY (id_drone)
);

-- 7. ARYA_OCORRENCIA
CREATE TABLE ARYA_OCORRENCIA (
    id_ocorrencia VARCHAR2(50) NOT NULL,
    tipo_ocorrencia VARCHAR2(100) NOT NULL,
    nivel_severidade NUMBER NOT NULL,
    data_ocorrencia TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    descricao CLOB,
    id_usuario VARCHAR2(50) NOT NULL,
    id_endereco VARCHAR2(50) NOT NULL,
    id_area_operacao VARCHAR2(50),
    CONSTRAINT pk_arya_ocorrencia PRIMARY KEY (id_ocorrencia)
);

-- 8. ARYA_OUTPUT_MODELO
CREATE TABLE ARYA_OUTPUT_MODELO (
    id_output VARCHAR2(50) NOT NULL,
    nome_modelo_ml VARCHAR2(150),
    data_geracao TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    id_endereco VARCHAR2(50),
    status_processamento VARCHAR2(50),
    resultado CLOB,
    CONSTRAINT pk_arya_output_modelo PRIMARY KEY (id_output)
);

-- Relacionamentos com ALTER TABLE

-- ARYA_HUB_OPERACIONAL referencia ARYA_ENDERECO
ALTER TABLE ARYA_HUB_OPERACIONAL
ADD CONSTRAINT fk_arya_hub_endereco FOREIGN KEY (id_endereco) REFERENCES ARYA_ENDERECO(id_endereco);

-- ARYA_DRONE referencia ARYA_HUB_OPERACIONAL e ARYA_ESPECIFICACAO
ALTER TABLE ARYA_DRONE
ADD CONSTRAINT fk_arya_drone_hub FOREIGN KEY (id_hub) REFERENCES ARYA_HUB_OPERACIONAL(id_hub);

ALTER TABLE ARYA_DRONE
ADD CONSTRAINT fk_arya_drone_especificacao FOREIGN KEY (id_especificacao) REFERENCES ARYA_ESPECIFICACAO(id_especificacao);

-- ARYA_OCORRENCIA referencia ARYA_USUARIO, ARYA_ENDERECO, ARYA_AREA_OPERACAO
ALTER TABLE ARYA_OCORRENCIA
ADD CONSTRAINT fk_arya_ocorrencia_usuario FOREIGN KEY (id_usuario) REFERENCES ARYA_USUARIO(id_usuario);

ALTER TABLE ARYA_OCORRENCIA
ADD CONSTRAINT fk_arya_ocorrencia_endereco FOREIGN KEY (id_endereco) REFERENCES ARYA_ENDERECO(id_endereco);

ALTER TABLE ARYA_OCORRENCIA
ADD CONSTRAINT fk_ocorrencia_area_operacao FOREIGN KEY (id_area_operacao) REFERENCES ARYA_AREA_OPERACAO(id_area_operacao);
