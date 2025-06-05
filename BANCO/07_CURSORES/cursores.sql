-- Listar Drones em Manutenção
DECLARE
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
END;
/

-- Ocorrências com severidade alta
DECLARE
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
END;
/

-- Ativar drones com hubs ativos
BEGIN
    FOR r IN (
        SELECT d.id_drone
        FROM ARYA_DRONE d
        JOIN ARYA_HUB_OPERACIONAL h ON d.id_hub = h.id_hub
        WHERE LOWER(d.status) = 'inativo' AND LOWER(h.status) = 'ativo'
    ) LOOP
        UPDATE ARYA_DRONE SET status = 'ativo' WHERE id_drone = r.id_drone;
        DBMS_OUTPUT.PUT_LINE('Drone ativado: ' || r.id_drone);
    END LOOP;
    COMMIT;
END;
/

-- Relatório de usuários com quantidade de ocorrências
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- RELATÓRIO USUÁRIOS x OCORRÊNCIAS ---');
    FOR r IN (
        SELECT u.id_usuario, u.nome, COUNT(o.id_ocorrencia) AS total
        FROM ARYA_USUARIO u
        LEFT JOIN ARYA_OCORRENCIA o ON u.id_usuario = o.id_usuario
        GROUP BY u.id_usuario, u.nome
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Usuário: ' || r.nome || ' | Total Ocorrências: ' || r.total);
    END LOOP;
END;
/

-- Detectar hubs sem drones
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- HUBs SEM DRONES ASSOCIADOS ---');
    FOR r IN (
        SELECT h.id_hub, h.nome
        FROM ARYA_HUB_OPERACIONAL h
        WHERE NOT EXISTS (
            SELECT 1 FROM ARYA_DRONE d WHERE d.id_hub = h.id_hub
        )
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Hub: ' || r.nome || ' (' || r.id_hub || ')');
    END LOOP;
END;
/
