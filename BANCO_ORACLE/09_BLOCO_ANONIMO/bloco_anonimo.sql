DECLARE
    v_id_drone   ARYA_DRONE.id_drone%TYPE := 'DRN001';
    v_status     ARYA_DRONE.status%TYPE;
    v_hub_status ARYA_HUB_OPERACIONAL.status%TYPE;
BEGIN
    SELECT d.status, h.status INTO v_status, v_hub_status
    FROM ARYA_DRONE d
    JOIN ARYA_HUB_OPERACIONAL h ON d.id_hub = h.id_hub
    WHERE d.id_drone = v_id_drone;

    IF LOWER(v_status) = 'inativo' AND LOWER(v_hub_status) = 'ativo' THEN
        UPDATE ARYA_DRONE SET status = 'ativo' WHERE id_drone = v_id_drone;
        DBMS_OUTPUT.PUT_LINE('Drone ativado com sucesso!');
        COMMIT; -- Adicionado COMMIT para salvar a alteração
    ELSE
        DBMS_OUTPUT.PUT_LINE('Drone não pode ser ativado. Verifique status ou hub.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Drone com ID ' || v_id_drone || ' não encontrado.');
END;


DECLARE
    v_severidade NUMBER := 8;
BEGIN
    IF v_severidade BETWEEN 1 AND 3 THEN
        DBMS_OUTPUT.PUT_LINE('Severidade Leve');
    ELSIF v_severidade BETWEEN 4 AND 6 THEN
        DBMS_OUTPUT.PUT_LINE('Severidade Moderada');
    ELSIF v_severidade BETWEEN 7 AND 10 THEN
        DBMS_OUTPUT.PUT_LINE('Severidade Grave');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Valor de severidade inválido');
    END IF;
END;


DECLARE
    v_total_ativos NUMBER;
    v_total_em_voo NUMBER;
BEGIN
    SELECT
        SUM(CASE WHEN LOWER(status) = 'ativo'  THEN 1 ELSE 0 END),
        SUM(CASE WHEN LOWER(status) = 'em voo' THEN 1 ELSE 0 END)
    INTO v_total_ativos, v_total_em_voo
    FROM ARYA_DRONE;

    DBMS_OUTPUT.PUT_LINE('Drones ativos: ' || v_total_ativos);
    IF v_total_em_voo = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum drone em voo no momento!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Drones em voo: ' || v_total_em_voo);
    END IF;
END;

DECLARE
    v_id_usuario VARCHAR2(50) := 'USR001';
    v_total_criticas NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total_criticas
    FROM ARYA_OCORRENCIA
    WHERE id_usuario = v_id_usuario AND nivel_severidade > 7;

    IF v_total_criticas > 3 THEN
        DBMS_OUTPUT.PUT_LINE('Usuário com muitas ocorrências críticas!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ocorrências críticas sob controle. Total: ' || v_total_criticas);
    END IF;
END;

DECLARE

    CURSOR c_usuarios IS
        SELECT
            u.id_usuario,
            u.nome,
            COUNT(o.id_ocorrencia) AS total_ocorrencias
        FROM ARYA_USUARIO u
        LEFT JOIN ARYA_OCORRENCIA o ON u.id_usuario = o.id_usuario
        GROUP BY u.id_usuario, u.nome;
BEGIN
    FOR r IN c_usuarios LOOP
        IF r.total_ocorrencias = 0 THEN
            CONTINUE;
        ELSIF r.total_ocorrencias > 5 THEN
            DBMS_OUTPUT.PUT_LINE('⚠️ Usuário: ' || r.nome || ' tem muitas ocorrências!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Usuário: ' || r.nome || ' | Ocorrências: ' || r.total_ocorrencias);
        END IF;


        EXIT WHEN r.id_usuario = 'USR010';
    END LOOP;
END;
