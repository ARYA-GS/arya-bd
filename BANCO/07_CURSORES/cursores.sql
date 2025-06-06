-- Listar Drones em Manutenção
-- Listar Drones em Manutenção
DECLARE
    -- A declaração do cursor continua a mesma
    CURSOR c_drones_manutencao IS
        SELECT id_drone, nome, status FROM ARYA_DRONE WHERE LOWER(status) = 'manutencao';
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- DRONES EM MANUTENÇÃO ---');
    
    -- CORREÇÃO: Usando um FOR LOOP para simplificar o código
    FOR rec IN c_drones_manutencao LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id_drone || ' | Nome: ' || rec.nome || ' | Status: ' || rec.status);
    END LOOP;
    -- Não é mais necessário declarar variáveis, nem usar OPEN, FETCH, EXIT WHEN ou CLOSE.
END;


-- Ocorrências com severidade alta
DECLARE
    CURSOR c_ocorrencias_severas IS
        SELECT id_ocorrencia, tipo_ocorrencia, nivel_severidade FROM ARYA_OCORRENCIA WHERE nivel_severidade > 7;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- OCORRÊNCIAS CRÍTICAS ---');
    
    -- CORREÇÃO: Usando FOR LOOP
    FOR rec IN c_ocorrencias_severas LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id_ocorrencia || ' | Tipo: ' || rec.tipo_ocorrencia || ' | Severidade: ' || rec.nivel_severidade);
    END LOOP;
END;


-- Ativar drones com hubs ativos
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
