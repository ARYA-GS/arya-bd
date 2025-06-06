-- PROCEDURES: ARYA_USUARIO

CREATE OR REPLACE PROCEDURE insert_arya_usuario (
    p_id_usuario     IN VARCHAR2,
    p_nome           IN VARCHAR2,
    p_email          IN VARCHAR2,
    p_senha          IN VARCHAR2,
    p_data_nasc      IN DATE
) AS
BEGIN
    INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc)
    VALUES (p_id_usuario, p_nome, p_email, p_senha, p_data_nasc);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em insert_arya_usuario: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE update_arya_usuario (
    p_id_usuario     IN VARCHAR2,
    p_nome           IN VARCHAR2,
    p_email          IN VARCHAR2,
    p_senha          IN VARCHAR2,
    p_data_nasc      IN DATE
) AS
BEGIN
    UPDATE ARYA_USUARIO
    SET nome = p_nome,
        email = p_email,
        senha = p_senha,
        data_nasc = p_data_nasc
    WHERE id_usuario = p_id_usuario;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em update_arya_usuario: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE delete_arya_usuario (
    p_id_usuario IN VARCHAR2
) AS
BEGIN
    DELETE FROM ARYA_USUARIO WHERE id_usuario = p_id_usuario;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_usuario: ' || SQLERRM);
END;

-- PROCEDURES: ARYA_ENDERECO

CREATE OR REPLACE PROCEDURE insert_arya_endereco (
    p_id_endereco IN VARCHAR2,
    p_bairro      IN VARCHAR2,
    p_cidade      IN VARCHAR2,
    p_estado      IN VARCHAR2,
    p_pais        IN VARCHAR2,
    p_latitude    IN NUMBER,
    p_longitude   IN NUMBER
) AS
BEGIN
    INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude)
    VALUES (p_id_endereco, p_bairro, p_cidade, p_estado, p_pais, p_latitude, p_longitude);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em insert_arya_endereco: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE update_arya_endereco (
    p_id_endereco IN VARCHAR2,
    p_bairro      IN VARCHAR2,
    p_cidade      IN VARCHAR2,
    p_estado      IN VARCHAR2,
    p_pais        IN VARCHAR2,
    p_latitude    IN NUMBER,
    p_longitude   IN NUMBER
) AS
BEGIN
    UPDATE ARYA_ENDERECO
    SET bairro = p_bairro,
        cidade = p_cidade,
        estado = p_estado,
        pais = p_pais,
        latitude = p_latitude,
        longitude = p_longitude
    WHERE id_endereco = p_id_endereco;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em update_arya_endereco: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE delete_arya_endereco (
    p_id_endereco IN VARCHAR2
) AS
BEGIN
    DELETE FROM ARYA_ENDERECO WHERE id_endereco = p_id_endereco;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_endereco: ' || SQLERRM);
END;

-- PROCEDURES: ARYA_AREA_OPERACAO

CREATE OR REPLACE PROCEDURE insert_arya_area_operacao (
    p_id_area_operacao IN VARCHAR2,
    p_latitude_central IN NUMBER,
    p_longitude_central IN NUMBER
) AS
BEGIN
    INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central)
    VALUES (p_id_area_operacao, p_latitude_central, p_longitude_central);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em insert_arya_area_operacao: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE update_arya_area_operacao (
    p_id_area_operacao IN VARCHAR2,
    p_latitude_central IN NUMBER,
    p_longitude_central IN NUMBER
) AS
BEGIN
    UPDATE ARYA_AREA_OPERACAO
    SET latitude_central = p_latitude_central,
        longitude_central = p_longitude_central
    WHERE id_area_operacao = p_id_area_operacao;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em update_arya_area_operacao: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE delete_arya_area_operacao (
    p_id_area_operacao IN VARCHAR2
) AS
BEGIN
    DELETE FROM ARYA_AREA_OPERACAO WHERE id_area_operacao = p_id_area_operacao;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_area_operacao: ' || SQLERRM);
END;

-- PROCEDURES: ARYA_HUB_OPERACIONAL

CREATE OR REPLACE PROCEDURE insert_arya_hub_operacional (
    p_id_hub IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_status IN VARCHAR2,
    p_id_endereco IN VARCHAR2
)
IS
BEGIN
    INSERT INTO ARYA_HUB_OPERACIONAL (
        id_hub, nome, status, id_endereco
    ) VALUES (
        p_id_hub, p_nome, p_status, p_id_endereco
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em insert_arya_hub_operacional: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE update_arya_hub_operacional (
    p_id_hub IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_status IN VARCHAR2,
    p_id_endereco IN VARCHAR2
)
IS
BEGIN
    UPDATE ARYA_HUB_OPERACIONAL
    SET nome = p_nome,
        status = p_status,
        id_endereco = p_id_endereco
    WHERE id_hub = p_id_hub;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em update_arya_hub_operacional: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE delete_arya_hub_operacional (
    p_id_hub IN VARCHAR2
)
IS
BEGIN
    DELETE FROM ARYA_HUB_OPERACIONAL
    WHERE id_hub = p_id_hub;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_hub_operacional: ' || SQLERRM);
END;

-- PROCEDURES: ARYA_DRONE

CREATE OR REPLACE PROCEDURE insert_arya_drone (
    p_id_drone IN VARCHAR2,
    p_id_hub IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_status IN VARCHAR2,
    p_modelo IN VARCHAR2,
    p_alcanceKM IN NUMBER,
    p_cargaKg IN NUMBER,
    p_carregamento IN VARCHAR2
)
IS
BEGIN
    INSERT INTO ARYA_DRONE (
        id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento
    ) VALUES (
        p_id_drone, p_id_hub, p_nome, p_status, p_modelo, p_alcanceKM, p_cargaKg, p_carregamento
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em insert_arya_drone: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE update_arya_drone (
    p_id_drone IN VARCHAR2,
    p_id_hub IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_status IN VARCHAR2,
    p_modelo IN VARCHAR2,
    p_alcanceKM IN NUMBER,
    p_cargaKg IN NUMBER,
    p_carregamento IN VARCHAR2
)
IS
BEGIN
    UPDATE ARYA_DRONE
    SET id_hub = p_id_hub,
        nome = p_nome,
        status = p_status,
        modelo = p_modelo,
        alcanceKM = p_alcanceKM,
        cargaKg = p_cargaKg,
        carregamento = p_carregamento
    WHERE id_drone = p_id_drone;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em update_arya_drone: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE delete_arya_drone (
    p_id_drone IN VARCHAR2
)
IS
BEGIN
    DELETE FROM ARYA_DRONE
    WHERE id_drone = p_id_drone;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_drone: ' || SQLERRM);
END;

-- PROCEDURES: ARYA_OCORRENCIA

CREATE OR REPLACE PROCEDURE insert_arya_ocorrencia (
    p_id_ocorrencia IN VARCHAR2,
    p_tipo_ocorrencia IN VARCHAR2,
    p_nivel_severidade IN NUMBER,
    p_data_ocorrencia IN TIMESTAMP,
    p_descricao IN CLOB,
    p_id_usuario IN VARCHAR2,
    p_id_endereco IN VARCHAR2,
    p_id_area_operacao IN VARCHAR2
)
IS
BEGIN
    INSERT INTO ARYA_OCORRENCIA (
        id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao
    ) VALUES (
        p_id_ocorrencia, p_tipo_ocorrencia, p_nivel_severidade, p_data_ocorrencia, p_descricao, p_id_usuario, p_id_endereco, p_id_area_operacao
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em insert_arya_ocorrencia: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE update_arya_ocorrencia (
    p_id_ocorrencia       IN VARCHAR2,
    p_tipo_ocorrencia     IN VARCHAR2,
    p_nivel_severidade    IN NUMBER,
    p_data_ocorrencia     IN TIMESTAMP,
    p_descricao           IN CLOB,
    p_id_usuario          IN VARCHAR2,
    p_id_endereco         IN VARCHAR2,
    p_id_area_operacao    IN VARCHAR2
)
IS
BEGIN
    UPDATE ARYA_OCORRENCIA
    SET tipo_ocorrencia     = p_tipo_ocorrencia,
        nivel_severidade    = p_nivel_severidade,
        data_ocorrencia     = p_data_ocorrencia,
        descricao           = p_descricao,
        id_usuario          = p_id_usuario,
        id_endereco         = p_id_endereco,
        id_area_operacao    = p_id_area_operacao
    WHERE id_ocorrencia = p_id_ocorrencia;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em update_arya_ocorrencia: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE delete_arya_ocorrencia (
    p_id_ocorrencia IN VARCHAR2
)
IS
BEGIN
    DELETE FROM ARYA_OCORRENCIA
    WHERE id_ocorrencia = p_id_ocorrencia;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_ocorrencia: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE insert_arya_missao_drone (
    p_id_missao IN VARCHAR2,
    p_id_drone IN VARCHAR2,
    p_id_ocorrencia IN VARCHAR2,
    p_dataInicio IN TIMESTAMP,
    p_dataFim IN TIMESTAMP,
    p_status IN VARCHAR2
)
IS
BEGIN
    INSERT INTO ARYA_MISSAO_DRONE (
        id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status
    ) VALUES (
        p_id_missao, p_id_drone, p_id_ocorrencia, p_dataInicio, p_dataFim, p_status
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em insert_arya_missao_drone: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE update_arya_missao_drone (
    p_id_missao IN VARCHAR2,
    p_id_drone IN VARCHAR2,
    p_id_ocorrencia IN VARCHAR2,
    p_dataInicio IN TIMESTAMP,
    p_dataFim IN TIMESTAMP,
    p_status IN VARCHAR2
)
IS
BEGIN
    UPDATE ARYA_MISSAO_DRONE
    SET id_drone = p_id_drone,
        id_ocorrencia = p_id_ocorrencia,
        dataInicio = p_dataInicio,
        dataFim = p_dataFim,
        status = p_status
    WHERE id_missao = p_id_missao;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em update_arya_missao_drone: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE delete_arya_missao_drone (
    p_id_missao IN VARCHAR2
)
IS
BEGIN
    DELETE FROM ARYA_MISSAO_DRONE
    WHERE id_missao = p_id_missao;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_missao_drone: ' || SQLERRM);
END;
