WITH OcorrenciasCriticasUltimoAno AS (
    -- Seleciona ocorrências críticas do último ano
    SELECT
        oc.id_ocorrencia,
        oc.tipo_ocorrencia,
        oc.nivel_severidade,
        oc.data_ocorrencia,
        oc.id_endereco
    FROM ARYA_OCORRENCIA oc
    WHERE oc.nivel_severidade > 7
      AND oc.data_ocorrencia >= (SYSTIMESTAMP - INTERVAL '1' YEAR)
),
ContagemOcorrenciasPorCidade AS (
    -- Conta ocorrências críticas por cidade
    SELECT
        ed.cidade,
        COUNT(oca.id_ocorrencia) AS total_ocorrencias_criticas,
        DENSE_RANK() OVER (ORDER BY COUNT(oca.id_ocorrencia) DESC) AS rank_cidade
    FROM OcorrenciasCriticasUltimoAno oca
    JOIN ARYA_ENDERECO ed ON oca.id_endereco = ed.id_endereco
    GROUP BY ed.cidade
),
TipoOcorrenciaMaisFrequentePorCidade AS (
    -- Identifica o tipo de ocorrência mais frequente por cidade (entre as críticas)
    SELECT
        ed.cidade,
        oca.tipo_ocorrencia,
        COUNT(oca.id_ocorrencia) AS contagem_tipo,
        ROW_NUMBER() OVER (PARTITION BY ed.cidade ORDER BY COUNT(oca.id_ocorrencia) DESC) AS rn_tipo_frequente
    FROM OcorrenciasCriticasUltimoAno oca
    JOIN ARYA_ENDERECO ed ON oca.id_endereco = ed.id_endereco
    WHERE ed.cidade IN (SELECT cidade FROM ContagemOcorrenciasPorCidade WHERE rank_cidade <= 3) -- Otimização: processar apenas top 3 cidades
    GROUP BY ed.cidade, oca.tipo_ocorrencia
)
SELECT
    cpc.cidade,
    cpc.total_ocorrencias_criticas,
    tmf.tipo_ocorrencia AS tipo_ocorrencia_critica_mais_frequente
FROM ContagemOcorrenciasPorCidade cpc
JOIN TipoOcorrenciaMaisFrequentePorCidade tmf ON cpc.cidade = tmf.cidade
WHERE cpc.rank_cidade <= 3
  AND tmf.rn_tipo_frequente = 1
ORDER BY cpc.rank_cidade ASC, cpc.total_ocorrencias_criticas DESC;


WITH MediaSeveridadePorTipo AS (
    -- Calcula a média de severidade por tipo de ocorrência
    SELECT
        oc.tipo_ocorrencia,
        AVG(oc.nivel_severidade) AS media_nivel_severidade
    FROM ARYA_OCORRENCIA oc
    GROUP BY oc.tipo_ocorrencia
),
ContagemUsuarioPorTipoOcorrencia AS (
    -- Conta quantas vezes cada usuário registrou cada tipo de ocorrência
    SELECT
        oc.tipo_ocorrencia,
        oc.id_usuario,
        COUNT(oc.id_ocorrencia) AS total_registros_usuario_tipo,
        ROW_NUMBER() OVER (PARTITION BY oc.tipo_ocorrencia ORDER BY COUNT(oc.id_ocorrencia) DESC, oc.id_usuario ASC) AS rn_usuario_top
        -- oc.id_usuario ASC é critério de desempate, pega o primeiro em ordem alfabética do ID
    FROM ARYA_OCORRENCIA oc
    GROUP BY oc.tipo_ocorrencia, oc.id_usuario
)
SELECT
    mst.tipo_ocorrencia,
    ROUND(mst.media_nivel_severidade, 2) AS media_severidade,
    usr.nome AS usuario_com_mais_registros_do_tipo,
    cuto.total_registros_usuario_tipo AS qtd_registros_pelo_usuario_top
FROM MediaSeveridadePorTipo mst
JOIN ContagemUsuarioPorTipoOcorrencia cuto ON mst.tipo_ocorrencia = cuto.tipo_ocorrencia
JOIN ARYA_USUARIO usr ON cuto.id_usuario = usr.id_usuario
WHERE cuto.rn_usuario_top = 1
ORDER BY mst.tipo_ocorrencia;

WITH EstatisticasUsuario AS (
    -- Calcula total de ocorrências e cidades distintas por usuário
    SELECT
        oc.id_usuario,
        COUNT(oc.id_ocorrencia) AS total_ocorrencias_registradas,
        COUNT(DISTINCT ed.cidade) AS numero_cidades_distintas
    FROM ARYA_OCORRENCIA oc
    JOIN ARYA_ENDERECO ed ON oc.id_endereco = ed.id_endereco
    GROUP BY oc.id_usuario
    HAVING COUNT(DISTINCT ed.cidade) >= 3
),
TipoOcorrenciaMaisFrequentePorUsuario AS (
    -- Identifica o tipo de ocorrência mais frequente para cada usuário qualificado
    SELECT
        oc.id_usuario,
        oc.tipo_ocorrencia,
        COUNT(oc.id_ocorrencia) AS contagem_tipo,
        ROW_NUMBER() OVER (PARTITION BY oc.id_usuario ORDER BY COUNT(oc.id_ocorrencia) DESC) AS rn_tipo_frequente
    FROM ARYA_OCORRENCIA oc
    WHERE oc.id_usuario IN (SELECT id_usuario FROM EstatisticasUsuario) -- Processar apenas usuários qualificados
    GROUP BY oc.id_usuario, oc.tipo_ocorrencia
)
SELECT
    usr.nome AS nome_usuario,
    usr.email AS email_usuario,
    eu.total_ocorrencias_registradas,
    eu.numero_cidades_distintas,
    tof.tipo_ocorrencia AS tipo_ocorrencia_mais_reportada
FROM EstatisticasUsuario eu
JOIN ARYA_USUARIO usr ON eu.id_usuario = usr.id_usuario
JOIN TipoOcorrenciaMaisFrequentePorUsuario tof ON eu.id_usuario = tof.id_usuario
WHERE tof.rn_tipo_frequente = 1
ORDER BY eu.total_ocorrencias_registradas DESC, usr.nome;

WITH OcorrenciasNoEnderecoDoHub AS (
    -- Seleciona ocorrências que aconteceram no endereço de um hub
    SELECT
        hub.id_hub,
        hub.nome AS nome_hub,
        ed_hub.cidade AS cidade_hub,
        oc.id_ocorrencia,
        oc.nivel_severidade
    FROM ARYA_OCORRENCIA oc
    JOIN ARYA_HUB_OPERACIONAL hub ON oc.id_endereco = hub.id_endereco -- Ocorrência no endereço do Hub
    JOIN ARYA_ENDERECO ed_hub ON hub.id_endereco = ed_hub.id_endereco
),
ContagemDronesPorHub AS (
    -- Conta o total de drones por hub
    SELECT
        dr.id_hub,
        COUNT(dr.id_drone) AS total_drones_no_hub
    FROM ARYA_DRONE dr
    GROUP BY dr.id_hub
),
EstatisticasHub AS (
    -- Agrega estatísticas de ocorrências por hub
    SELECT
        oeh.id_hub,
        oeh.nome_hub,
        oeh.cidade_hub,
        COUNT(oeh.id_ocorrencia) AS total_ocorrencias_no_hub,
        AVG(oeh.nivel_severidade) AS media_severidade_no_hub,
        DENSE_RANK() OVER (ORDER BY COUNT(oeh.id_ocorrencia) DESC) AS rank_hub
    FROM OcorrenciasNoEnderecoDoHub oeh
    GROUP BY oeh.id_hub, oeh.nome_hub, oeh.cidade_hub
)
SELECT
    eh.nome_hub,
    eh.cidade_hub,
    eh.total_ocorrencias_no_hub,
    ROUND(eh.media_severidade_no_hub, 2) AS media_severidade_no_hub,
    COALESCE(cdh.total_drones_no_hub, 0) AS total_drones_alocados_ao_hub -- COALESCE para hubs sem drones
FROM EstatisticasHub eh
LEFT JOIN ContagemDronesPorHub cdh ON eh.id_hub = cdh.id_hub
WHERE eh.rank_hub <= 3
ORDER BY eh.rank_hub ASC, eh.total_ocorrencias_no_hub DESC;

