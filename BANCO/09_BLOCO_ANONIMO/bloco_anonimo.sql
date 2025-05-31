-- 1. Verificar se um drone pode ser ativado
DECLARE
    v_id_drone ARYA_DRONE.id_drone%TYPE := 'DRN001';
    v_status ARYA_DRONE.status%TYPE;
    v_hub_status ARYA_HUB_OPERACIONAL.status%TYPE;
BEGIN
    SELECT d.status, h.status INTO v_status, v_hub_status
    FROM ARYA_DRONE d
    JOIN ARYA_HUB_OPERACIONAL h ON d.id_hub = h.id_hub
    WHERE d.id_drone = v_id_drone;

    IF LOWER(v_status) = 'inativo' AND LOWER(v_hub_status) = 'ativo' THEN
        UPDATE ARYA_DRONE SET status = 'ativo' WHERE id_drone = v_id_drone;
        DBMS_OUTPUT.PUT_LINE('Drone ativado com sucesso!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Drone não pode ser ativado. Verifique status ou hub.');
    END IF;
END;

-- 2. Classificar nível de severidade
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

-- 3. Contar drones ativos e em voo
DECLARE
    v_total_ativos NUMBER;
    v_total_em_voo NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total_ativos FROM ARYA_DRONE WHERE LOWER(status) = 'ativo';
    SELECT COUNT(*) INTO v_total_em_voo FROM ARYA_DRONE WHERE LOWER(status) = 'em voo';

    DBMS_OUTPUT.PUT_LINE('Drones ativos: ' || v_total_ativos);
    IF v_total_em_voo = 0 THEN
        DBMS_OUTPUT.PUT_LINE('⚠️ Nenhum drone em voo no momento!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Drones em voo: ' || v_total_em_voo);
    END IF;
END;

-- 4. Verificar se há muitas ocorrências críticas registradas por um usuário específico
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

-- 5. Loop com CONTINUE e EXIT
DECLARE
    CURSOR c_usuarios IS
        SELECT u.id_usuario, u.nome,
            (SELECT COUNT(*) FROM ARYA_OCORRENCIA o WHERE o.id_usuario = u.id_usuario) AS total_ocorrencias
        FROM ARYA_USUARIO u;

BEGIN
    FOR r IN c_usuarios LOOP
        IF r.total_ocorrencias = 0 THEN
            CONTINUE;
        ELSIF r.total_ocorrencias > 5 THEN
            DBMS_OUTPUT.PUT_LINE('⚠️ Usuário: ' || r.nome || ' tem muitas ocorrências!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Usuário: ' || r.nome || ' | Ocorrências: ' || r.total_ocorrencias);
        END IF;

        -- Simula limite de 10 iterações para exemplo (em sistemas reais use EXIT lógicos)
        EXIT WHEN r.id_usuario = 'USR010';
    END LOOP;
END;
