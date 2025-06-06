CREATE OR REPLACE PACKAGE BODY pkg_arya_management AS

 -- PROCEDURES: ARYA_USUARIO

 PROCEDURE insert_arya_usuario (
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

     PROCEDURE update_arya_usuario (
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

     PROCEDURE delete_arya_usuario (
        p_id_usuario IN VARCHAR2
    ) AS
    BEGIN
        DELETE FROM ARYA_USUARIO WHERE id_usuario = p_id_usuario;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_usuario: ' || SQLERRM);
    END;

    -- PROCEDURES: ARYA_ENDERECO

     PROCEDURE insert_arya_endereco (
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

     PROCEDURE update_arya_endereco (
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

     PROCEDURE delete_arya_endereco (
        p_id_endereco IN VARCHAR2
    ) AS
    BEGIN
        DELETE FROM ARYA_ENDERECO WHERE id_endereco = p_id_endereco;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_endereco: ' || SQLERRM);
    END;

    -- PROCEDURES: ARYA_AREA_OPERACAO

     PROCEDURE insert_arya_area_operacao (
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

     PROCEDURE update_arya_area_operacao (
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

     PROCEDURE delete_arya_area_operacao (
        p_id_area_operacao IN VARCHAR2
    ) AS
    BEGIN
        DELETE FROM ARYA_AREA_OPERACAO WHERE id_area_operacao = p_id_area_operacao;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro em delete_arya_area_operacao: ' || SQLERRM);
    END;

    -- PROCEDURES: ARYA_HUB_OPERACIONAL

     PROCEDURE insert_arya_hub_operacional (
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

     PROCEDURE update_arya_hub_operacional (
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

     PROCEDURE delete_arya_hub_operacional (
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

     PROCEDURE insert_arya_drone (
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

     PROCEDURE update_arya_drone (
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

     PROCEDURE delete_arya_drone (
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

     PROCEDURE insert_arya_ocorrencia (
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

     PROCEDURE update_arya_ocorrencia (
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

     PROCEDURE delete_arya_ocorrencia (
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

     PROCEDURE insert_arya_missao_drone (
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

     PROCEDURE update_arya_missao_drone (
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

     PROCEDURE delete_arya_missao_drone (
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

    --------------------------------------------------------------------------------
    -- FUNCTIONS
    --------------------------------------------------------------------------------
    -- Retorna a pontuação categorizada da severidade de uma ocorrência
     FUNCTION pontuacao_severidade (
        p_nivel_severidade IN NUMBER
    ) RETURN VARCHAR2 IS
        v_pontuacao VARCHAR2(10);
    BEGIN
        IF p_nivel_severidade <= 3 THEN
            v_pontuacao := 'Baixo';
        ELSIF p_nivel_severidade <= 7 THEN
            v_pontuacao := 'Médio';
        ELSE
            v_pontuacao := 'Alto';
        END IF;
        RETURN v_pontuacao;
    END;

    -- Retorna a quantidade de ocorrências relacionadas a um hub específico
     FUNCTION ranking_ocorrencias_hub (
        p_id_hub IN VARCHAR2
    ) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(o.id_ocorrencia)
        INTO v_total
        FROM ARYA_OCORRENCIA o
        JOIN ARYA_AREA_OPERACAO ao ON o.id_area_operacao = ao.id_area_operacao
        JOIN ARYA_HUB_OPERACIONAL h ON h.id_endereco = ao.id_endereco -- Substituir pelo relacionamento correto
        WHERE h.id_hub = p_id_hub;
        
        RETURN v_total;
    END;


    -- Calcula um índice numérico de risco baseado no nível de severidade
     FUNCTION calcula_risco (
        p_nivel_severidade IN NUMBER
    ) RETURN NUMBER IS
        v_risco NUMBER;
    BEGIN
        v_risco := p_nivel_severidade * 1.5;
        RETURN v_risco;
    END;

    --------------------------------------------------------------------------------
    -- PROCEDURES FROM ANONYMOUS BLOCKS
    --------------------------------------------------------------------------------
    PROCEDURE prc_listar_drones_manutencao AS
        CURSOR c_drones_manutencao IS
            SELECT id_drone, nome, status FROM ARYA_DRONE WHERE LOWER(status) = 'manutencao';
        v_id ARYA_DRONE.id_drone%TYPE;
        v_nome ARYA_DRONE.nome%TYPE;
        v_status ARYA_DRONE.status%TYPE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--- DRONES EM MANUTENÇÃO ---');
        OPEN c_drones_manutencao;
        LOOP
            FETCH c_drones_manutencao INTO v_id, v_nome, v_status;
            EXIT WHEN c_drones_manutencao%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ' | Nome: ' || v_nome || ' | Status: ' || v_status);
        END LOOP;
        CLOSE c_drones_manutencao;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END prc_listar_drones_manutencao;

    PROCEDURE prc_listar_ocorrencias_criticas AS
        CURSOR c_ocorrencias_severas IS
            SELECT id_ocorrencia, tipo_ocorrencia, nivel_severidade FROM ARYA_OCORRENCIA WHERE nivel_severidade > 7;
        v_id ARYA_OCORRENCIA.id_ocorrencia%TYPE;
        v_tipo ARYA_OCORRENCIA.tipo_ocorrencia%TYPE;
        v_nivel ARYA_OCORRENCIA.nivel_severidade%TYPE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--- OCORRÊNCIAS CRÍTICAS ---');
        OPEN c_ocorrencias_severas;
        LOOP
            FETCH c_ocorrencias_severas INTO v_id, v_tipo, v_nivel;
            EXIT WHEN c_ocorrencias_severas%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ' | Tipo: ' || v_tipo || ' | Severidade: ' || v_nivel);
        END LOOP;
        CLOSE c_ocorrencias_severas;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END prc_listar_ocorrencias_criticas;

    PROCEDURE prc_ativar_drones_hubs_ativos AS
        CURSOR c_drones_inativos IS
            SELECT d.id_drone FROM ARYA_DRONE d
            JOIN ARYA_HUB_OPERACIONAL h ON d.id_hub = h.id_hub
            WHERE LOWER(d.status) = 'inativo' AND LOWER(h.status) = 'ativo';
    BEGIN
        FOR r IN c_drones_inativos LOOP
            UPDATE ARYA_DRONE SET status = 'ativo' WHERE id_drone = r.id_drone;
            DBMS_OUTPUT.PUT_LINE('Drone ativado: ' || r.id_drone);
        END LOOP;
        COMMIT; -- O COMMIT foi mantido conforme o script original.
                -- Em muitos cenários, o controle de transação é feito pela aplicação chamadora.
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END prc_ativar_drones_hubs_ativos;

    PROCEDURE prc_rel_usuarios_ocorren_out AS
        CURSOR c_usuario_ocorrencias IS
            SELECT u.id_usuario, u.nome, COUNT(o.id_ocorrencia) AS total
            FROM ARYA_USUARIO u
            LEFT JOIN ARYA_OCORRENCIA o ON u.id_usuario = o.id_usuario
            GROUP BY u.id_usuario, u.nome;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--- RELATÓRIO USUÁRIOS x OCORRÊNCIAS (Output) ---');
        FOR r IN c_usuario_ocorrencias LOOP
            DBMS_OUTPUT.PUT_LINE('Usuário: ' || r.nome || ' | Total Ocorrências: ' || r.total);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END prc_rel_usuarios_ocorren_out;

    PROCEDURE prc_listar_hubs_sem_drones AS
        CURSOR c_hubs_sem_drones IS
            SELECT h.id_hub, h.nome FROM ARYA_HUB_OPERACIONAL h
            WHERE NOT EXISTS (
                SELECT 1 FROM ARYA_DRONE d WHERE d.id_hub = h.id_hub
            );
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--- HUBs SEM DRONES ASSOCIADOS ---');
        FOR r IN c_hubs_sem_drones LOOP
            DBMS_OUTPUT.PUT_LINE('Hub: ' || r.nome || ' (' || r.id_hub || ')');
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END prc_listar_hubs_sem_drones;

    --------------------------------------------------------------------------------
    -- FUNCTIONS FOR REPORTS (returning SYS_REFCURSOR)
    --------------------------------------------------------------------------------
    FUNCTION fnc_rel_contagem_drones_status
        RETURN SYS_REFCURSOR
    AS
        o_ref_cursor SYS_REFCURSOR;
    BEGIN
        OPEN o_ref_cursor FOR
            SELECT status, COUNT(*) AS total_drones
            FROM ARYA_DRONE
            GROUP BY status
            ORDER BY total_drones DESC;
        RETURN o_ref_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END fnc_rel_contagem_drones_status;

    FUNCTION fnc_rel_ocorrencias_tipo_avg_sev
        RETURN SYS_REFCURSOR
    AS
        o_ref_cursor SYS_REFCURSOR;
    BEGIN
        OPEN o_ref_cursor FOR
            SELECT tipo_ocorrencia, COUNT(*) AS total_ocorrencias, AVG(nivel_severidade) AS severidade_media
            FROM ARYA_OCORRENCIA
            GROUP BY tipo_ocorrencia
            ORDER BY total_ocorrencias DESC;
        RETURN o_ref_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END fnc_rel_ocorrencias_tipo_avg_sev;

    FUNCTION fnc_rel_drones_por_hub
        RETURN SYS_REFCURSOR
    AS
        o_ref_cursor SYS_REFCURSOR;
    BEGIN
        OPEN o_ref_cursor FOR
            SELECT h.id_hub, h.nome AS nome_hub, h.status AS status_hub, COUNT(d.id_drone) AS total_drones
            FROM ARYA_HUB_OPERACIONAL h
            LEFT JOIN ARYA_DRONE d ON h.id_hub = d.id_hub
            GROUP BY h.id_hub, h.nome, h.status
            ORDER BY total_drones DESC;
        RETURN o_ref_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END fnc_rel_drones_por_hub;

    FUNCTION fnc_rel_usuarios_rank_ocorrencias
        RETURN SYS_REFCURSOR
    AS
        o_ref_cursor SYS_REFCURSOR;
    BEGIN
        OPEN o_ref_cursor FOR
            SELECT u.id_usuario, u.nome, COUNT(o.id_ocorrencia) AS total_ocorrencias
            FROM ARYA_USUARIO u
            LEFT JOIN ARYA_OCORRENCIA o ON u.id_usuario = o.id_usuario
            GROUP BY u.id_usuario, u.nome
            ORDER BY total_ocorrencias DESC;
        RETURN o_ref_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END fnc_rel_usuarios_rank_ocorrencias;

    FUNCTION fnc_rel_ocorrencias_area_avg_sev
        RETURN SYS_REFCURSOR
    AS
        o_ref_cursor SYS_REFCURSOR;
    BEGIN
        OPEN o_ref_cursor FOR
            SELECT a.id_area_operacao, COUNT(o.id_ocorrencia) AS total_ocorrencias, AVG(o.nivel_severidade) AS severidade_media
            FROM ARYA_AREA_OPERACAO a
            LEFT JOIN ARYA_OCORRENCIA o ON a.id_area_operacao = o.id_area_operacao
            GROUP BY a.id_area_operacao
            ORDER BY severidade_media DESC;
        RETURN o_ref_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END fnc_rel_ocorrencias_area_avg_sev;

END pkg_arya_management;
