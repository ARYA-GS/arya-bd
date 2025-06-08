-- Contagem de drones por status
SELECT status, COUNT(*) AS total_drones
FROM ARYA_DRONE
GROUP BY status
ORDER BY total_drones DESC;

-- Ocorrências por tipo e severidade média
SELECT tipo_ocorrencia, COUNT(*) AS total_ocorrencias, AVG(nivel_severidade) AS severidade_media
FROM ARYA_OCORRENCIA
GROUP BY tipo_ocorrencia
ORDER BY total_ocorrencias DESC;

-- Drones por hub operacional e status do hub
SELECT h.id_hub, h.nome AS nome_hub, h.status AS status_hub, COUNT(d.id_drone) AS total_drones
FROM ARYA_HUB_OPERACIONAL h
LEFT JOIN ARYA_DRONE d ON h.id_hub = d.id_hub
GROUP BY h.id_hub, h.nome, h.status
ORDER BY total_drones DESC;

-- Usuários com mais ocorrências registradas
SELECT u.id_usuario, u.nome, COUNT(o.id_ocorrencia) AS total_ocorrencias
FROM ARYA_USUARIO u
LEFT JOIN ARYA_OCORRENCIA o ON u.id_usuario = o.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY total_ocorrencias DESC;

-- Análise de ocorrências por área de operação com severidade média
SELECT a.id_area_operacao, COUNT(o.id_ocorrencia) AS total_ocorrencias, AVG(o.nivel_severidade) AS severidade_media
FROM ARYA_AREA_OPERACAO a
LEFT JOIN ARYA_OCORRENCIA o ON a.id_area_operacao = o.id_area_operacao
GROUP BY a.id_area_operacao
ORDER BY severidade_media DESC;
