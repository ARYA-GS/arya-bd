set serveroutput on
set verify off

DECLARE
    CURSOR c_drones_manutencao IS
        SELECT id_drone, nome, status FROM ARYA_DRONE WHERE LOWER(status) = 'manutencao';
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- DRONES EM MANUTENÇÃO ---');
    FOR rec IN c_drones_manutencao LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id_drone || ' | Nome: ' || rec.nome || ' | Status: ' || rec.status);
    END LOOP;
END;

DECLARE
    CURSOR c_ocorrencias_severas IS
        SELECT id_ocorrencia, tipo_ocorrencia, nivel_severidade FROM ARYA_OCORRENCIA WHERE nivel_severidade > 7;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- OCORRÊNCIAS CRÍTICAS ---');
    FOR rec IN c_ocorrencias_severas LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id_ocorrencia || ' | Tipo: ' || rec.tipo_ocorrencia || ' | Severidade: ' || rec.nivel_severidade);
    END LOOP;
END;


DECLARE
    v_drones_ativados NUMBER;
BEGIN
    UPDATE ARYA_DRONE
    SET status = 'ativo'
    WHERE status = 'inativo'
      AND id_hub IN (SELECT id_hub FROM ARYA_HUB_OPERACIONAL WHERE status = 'ativo');

    v_drones_ativados := SQL%ROWCOUNT; 
    DBMS_OUTPUT.PUT_LINE('Operação concluída. Total de drones ativados: ' || v_drones_ativados);
    COMMIT; 
END;


BEGIN
    DBMS_OUTPUT.PUT_LINE('--- RELATÓRIO USUÁRIOS x OCORRÊNCIAS ---');
    FOR r IN (
        SELECT u.id_usuario, u.nome, COUNT(o.id_ocorrencia) AS total
        FROM ARYA_USUARIO u
        LEFT JOIN ARYA_OCORRENCIA o ON u.id_usuario = o.id_usuario
        GROUP BY u.id_usuario, u.nome
        ORDER BY total DESC 
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Usuário: ' || r.nome || ' | Total Ocorrências: ' || r.total);
    END LOOP;
END;



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
