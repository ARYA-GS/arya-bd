-- Função 1: Retorna a pontuação categorizada da severidade de uma ocorrência
CREATE OR REPLACE FUNCTION fn_pontuacao_severidade (
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

-- Função 2: Retorna a quantidade de ocorrências relacionadas a um hub específico
CREATE OR REPLACE FUNCTION fn_ranking_ocorrencias_hub (
    p_id_hub IN VARCHAR2
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(o.id_ocorrencia)
    INTO v_total
    FROM ARYA_OCORRENCIA o
    JOIN ARYA_AREA_OPERACAO ao ON o.id_area_operacao = ao.id_area_operacao
    JOIN ARYA_HUB_OPERACIONAL h ON h.id_endereco = ao.id_area_operacao -- Ajuste necessário no relacionamento real
    WHERE h.id_hub = p_id_hub;
    
    RETURN NVL(v_total, 0);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;

-- Função 3: Calcula um índice numérico de risco baseado no nível de severidade
CREATE OR REPLACE FUNCTION fn_calcula_risco (
    p_nivel_severidade IN NUMBER
) RETURN NUMBER IS
    v_risco NUMBER;
BEGIN
    v_risco := p_nivel_severidade * 1.5;
    RETURN v_risco;
END;
