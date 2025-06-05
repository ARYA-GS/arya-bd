-- 1. ARYA_USUARIO
CREATE TABLE ARYA_USUARIO (
    id_usuario VARCHAR2(50) NOT NULL,
    nome VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    senha VARCHAR2(255) NOT NULL,
    data_nasc DATE,
    CONSTRAINT pk_arya_usuario PRIMARY KEY (id_usuario)
);

-- 2. ARYA_ENDERECO
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

-- 3. ARYA_AREA_OPERACAO
CREATE TABLE ARYA_AREA_OPERACAO (
    id_area_operacao VARCHAR2(50) NOT NULL,
    latitude_central NUMBER NOT NULL,
    longitude_central NUMBER NOT NULL,
    CONSTRAINT pk_arya_area_operacao PRIMARY KEY (id_area_operacao)
);

-- 4. ARYA_HUB_OPERACIONAL
CREATE TABLE ARYA_HUB_OPERACIONAL (
    id_hub VARCHAR2(50) NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    status VARCHAR2(50),
    id_endereco VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_arya_hub_operacional PRIMARY KEY (id_hub)
);

-- 5. ARYA_DRONE
CREATE TABLE ARYA_DRONE (
    id_drone VARCHAR2(50) NOT NULL,
    id_hub VARCHAR2(50),
    nome VARCHAR2(100) NOT NULL,
    status VARCHAR2(50),
    modelo VARCHAR2(100) NOT NULL,
    alcanceKM NUMBER,
    cargaKg NUMBER,
    carregamento VARCHAR2(255),
    CONSTRAINT pk_arya_drone PRIMARY KEY (id_drone)
);

-- 6. ARYA_OCORRENCIA
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

-- 7. ARYA_OUTPUT_MODELO
CREATE TABLE ARYA_OUTPUT_MODELO (
    id_output VARCHAR2(50) NOT NULL,
    nome_modelo_ml VARCHAR2(150),
    data_geracao TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    id_endereco VARCHAR2(50),
    status_processamento VARCHAR2(50),
    resultado CLOB,
    CONSTRAINT pk_arya_output_modelo PRIMARY KEY (id_output)
);

-- 8. ARYA_MISSAO_DRONE (nova tabela)
CREATE TABLE ARYA_MISSAO_DRONE (
    id_missao VARCHAR2(50) NOT NULL,
    id_drone VARCHAR2(50) NOT NULL,
    id_ocorrencia VARCHAR2(50) NOT NULL,
    dataInicio TIMESTAMP NOT NULL,
    dataFim TIMESTAMP,
    status VARCHAR2(50),
    CONSTRAINT pk_arya_missao_drone PRIMARY KEY (id_missao)
);

-- RELACIONAMENTOS COM ALTER TABLE

-- ARYA_HUB_OPERACIONAL referencia ARYA_ENDERECO
ALTER TABLE ARYA_HUB_OPERACIONAL
ADD CONSTRAINT fk_arya_hub_endereco FOREIGN KEY (id_endereco) REFERENCES ARYA_ENDERECO(id_endereco);

-- ARYA_DRONE referencia ARYA_HUB_OPERACIONAL
ALTER TABLE ARYA_DRONE
ADD CONSTRAINT fk_arya_drone_hub FOREIGN KEY (id_hub) REFERENCES ARYA_HUB_OPERACIONAL(id_hub);

-- ARYA_OCORRENCIA referencia ARYA_USUARIO, ARYA_ENDERECO, ARYA_AREA_OPERACAO
ALTER TABLE ARYA_OCORRENCIA
ADD CONSTRAINT fk_arya_ocorrencia_usuario FOREIGN KEY (id_usuario) REFERENCES ARYA_USUARIO(id_usuario);

ALTER TABLE ARYA_OCORRENCIA
ADD CONSTRAINT fk_arya_ocorrencia_endereco FOREIGN KEY (id_endereco) REFERENCES ARYA_ENDERECO(id_endereco);

ALTER TABLE ARYA_OCORRENCIA
ADD CONSTRAINT fk_ocorrencia_area_operacao FOREIGN KEY (id_area_operacao) REFERENCES ARYA_AREA_OPERACAO(id_area_operacao);

-- ARYA_MISSAO_DRONE referencia ARYA_DRONE e ARYA_OCORRENCIA
ALTER TABLE ARYA_MISSAO_DRONE
ADD CONSTRAINT fk_missao_drone_drone FOREIGN KEY (id_drone) REFERENCES ARYA_DRONE(id_drone);

ALTER TABLE ARYA_MISSAO_DRONE
ADD CONSTRAINT fk_missao_drone_ocorrencia FOREIGN KEY (id_ocorrencia) REFERENCES ARYA_OCORRENCIA(id_ocorrencia);
