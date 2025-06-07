-- ARYA_USUARIO
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR001', 'Ana Beatriz Costa', 'ana.costa@email.com', 'senhaABC', TO_DATE('1985-03-22', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR002', 'Carlos Alberto Dias', 'carlos.dias@email.com', 'senhaCAR', TO_DATE('1992-07-10', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR003', 'Fernanda Lima e Silva', 'fernanda.lima@email.com', 'senhaFER', TO_DATE('1988-11-05', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR004', 'Ricardo Souza Mendes', 'ricardo.mendes@email.com', 'senhaRIC', TO_DATE('1995-01-30', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR005', 'Juliana Pereira Alves', 'juliana.alves@email.com', 'senhaJUL', TO_DATE('2000-09-12', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR006', 'Roberto Carlos da Silva', 'roberto.carlos@email.com', 'senhaROB', TO_DATE('1978-05-15', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR007', 'Mariana Santos Oliveira', 'mariana.santos@email.com', 'senhaMAR', TO_DATE('1990-12-20', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR008', 'Paulo Henrique Rocha', 'paulo.henrique@email.com', 'senhaPAU', TO_DATE('1983-08-25', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR009', 'Tatiane Gomes da Costa', 'tatiane.gomes@email.com', 'senhaTAT', TO_DATE('1996-04-18', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR010', 'Eduardo Martins Silva', 'edu.martins@email.com', 'senhaEDU', TO_DATE('1987-10-30', 'YYYY-MM-DD'));
-- ARYA_ENDERECO
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END001', 'Copacabana', 'Rio de Janeiro', 'RJ', 'Brasil', -22.969778, -43.186859);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END002', 'Savassi', 'Belo Horizonte', 'MG', 'Brasil', -19.933001, -43.936100);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END003', 'Boa Viagem', 'Recife', 'PE', 'Brasil', -8.121960, -34.900780);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END004', 'Asa Norte', 'Brasília', 'DF', 'Brasil', -15.769970, -47.880090);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END005', 'Moinhos de Vento', 'Porto Alegre', 'RS', 'Brasil', -30.024990, -51.209850);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END006', 'Jardim Paulista', 'São Paulo', 'SP', 'Brasil', -23.561680, -46.655990);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END007', 'Centro', 'Curitiba', 'PR', 'Brasil', -25.428950, -49.271270);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END008', 'Centro', 'Salvador', 'BA', 'Brasil', -12.971400, -38.501400);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END009', 'Centro', 'Fortaleza', 'CE', 'Brasil', -3.717220, -38.543330);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END010', 'Centro', 'Manaus', 'AM', 'Brasil', -3.101940, -60.025000);

-- ARYA_AREA_OPERACAO
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA001', -22.975000, -43.190000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA002', -19.930000, -43.940000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA003', -8.115000, -34.905000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA004', -15.775000, -47.885000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA005', -30.030000, -51.200000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA006', -23.560000, -46.650000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA007', -25.430000, -49.270000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA008', -12.970000, -38.500000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA009', -3.720000, -38.540000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA010', -3.100000, -60.020000);

-- ARYA_HUB_OPERACIONAL
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB001', 'Hub Rio Sul', 'Ativo', 'END001');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB002', 'Hub Minas Gerais Central', 'Manutenção', 'END002');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB003', 'Hub Nordeste Principal', 'Ativo', 'END003');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB004', 'Hub Capital Federal', 'Inativo', 'END004');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB005', 'Hub Porto Alegre Sul', 'Ativo', 'END005');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB006', 'Hub São Paulo Central', 'Ativo', 'END006');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB007', 'Hub Curitiba Sul', 'Ativo', 'END007');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB008', 'Hub Salvador Leste', 'Ativo', 'END008');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB009', 'Hub Fortaleza Norte', 'Ativo', 'END009');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB010', 'Hub Manaus Amazônia', 'Ativo', 'END010');

-- ARYA_DRONE
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN001', 'HUB001', 'Drone Alpha', 'Ativo', 'X-200', 50, 10, 'Carregando bateria');
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN002', 'HUB001', 'Drone Beta', 'Manutenção', 'Y-150', 40, 8, NULL);
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN003', 'HUB002', 'Drone Gamma', 'Ativo', 'Z-300', 70, 12, 'Carregando bateria');
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN004', NULL, 'Drone Delta', 'Inativo', 'X-100', 30, 6, NULL);
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN005', 'HUB003', 'Drone Epsilon', 'Ativo', 'Y-200', 60, 9, 'Carregando bateria');
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN006', 'HUB004', 'Drone Zeta', 'Ativo', 'Z-400', 80, 15, NULL);
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN007', 'HUB005', 'Drone Eta', 'Ativo', 'X-150', 55, 11, 'Carregando bateria');
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN008', 'HUB006', 'Drone Theta', 'Ativo', 'Y-250', 65, 10, NULL);
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN009', 'HUB007', 'Drone Iota', 'Ativo', 'Z-500', 90, 20, 'Carregando bateria');
INSET INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN010', 'HUB008', 'Drone Kappa', 'Ativo', 'X-300', 75, 14, NULL);

-- ARYA_OCORRENCIA
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO001', 'Queimada Florestal', 4, TO_TIMESTAMP('2025-01-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Foco de incêndio detectado em área de vegetação densa, necessitando monitoramento aéreo urgente.', 'USR001', 'END001', 'AREA001');
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO002', 'Enchente Urbana', 5, TO_TIMESTAMP('2025-02-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Inundação severa em bairro residencial após chuvas intensas, vias interditadas.', 'USR002', 'END002', 'AREA002');
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO003', 'Onda de Calor Extremo', 3, TO_TIMESTAMP('2025-03-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Temperaturas elevadas persistentes acima de 40°C, risco à saúde pública e aumento de focos de incêndio.', 'USR003', 'END003', 'AREA003');
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO004', 'Deslizamento de Terra', 5, TO_TIMESTAMP('2025-04-05 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deslocamento de grande volume de terra em encosta próxima a área habitada, risco de soterramento.', 'USR001', 'END005', 'AREA005');
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO005', 'Vendaval Destrutivo', 4, TO_TIMESTAMP('2025-05-29 23:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ventos com velocidade superior a 90km/h causando destelhamentos e queda de árvores.', 'USR004', 'END004', NULL); -- id_area_operacao NULO se a ocorrência for muito generalizada ou não mapeada a uma área específica.
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO006', 'Tsunami', 5, TO_TIMESTAMP('2025-06-15 03:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Onda gigante atingindo a costa após terremoto no oceano, causando destruição em massa.', 'USR005', 'END006', NULL); -- id_area_operacao NULO se a ocorrência for muito generalizada ou não mapeada a uma área específica.
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO007', 'Terremoto', 5, TO_TIMESTAMP('2025-07-20 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Terremoto de magnitude 7.5 causando danos estruturais em várias cidades.', 'USR006', 'END007', NULL); -- id_area_operacao NULO se a ocorrência for muito generalizada ou não mapeada a uma área específica.
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO008', 'Tornado', 5, TO_TIMESTAMP('2025-08-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tornado devastador atingindo área urbana, causando destruição generalizada.', 'USR007', 'END008', NULL); -- id_area_operacao NULO se a ocorrência for muito generalizada ou não mapeada a uma área específica.
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO009', 'Incêndio Urbano', 4, TO_TIMESTAMP('2025-09-30 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Incêndio em prédio comercial causando evacuação e risco de propagação.', 'USR008', 'END009', NULL); -- id_area_operacao NULO se a ocorrência for muito generalizada ou não mapeada a uma área específica.
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO010', 'Alagamento', 3, TO_TIMESTAMP('2025-10-05 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Alagamento em área comercial devido a chuvas intensas, causando transtornos.', 'USR009', 'END010', NULL); -- id_area_operacao NULO se a ocorrência for muito generalizada ou não mapeada a uma área específica.
-- ARYA_MISSAO_DRONE
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN001', 'DRN001', 'OCO001', TO_TIMESTAMP('2025-06-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Concluída');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN002', 'DRN002', 'OCO002', TO_TIMESTAMP('2025-06-02 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Em andamento');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN003', 'DRN003', 'OCO003', TO_TIMESTAMP('2025-06-03 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-03 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Concluída');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN004', 'DRN004', 'OCO004', TO_TIMESTAMP('2025-06-04 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN005', 'DRN001', 'OCO005', TO_TIMESTAMP('2025-06-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN006', 'DRN002', 'OCO006', TO_TIMESTAMP('2025-06-06 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN007', 'DRN003', 'OCO007', TO_TIMESTAMP('2025-06-07 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN008', 'DRN004', 'OCO008', TO_TIMESTAMP('2025-06-08 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN009', 'DRN005', 'OCO009', TO_TIMESTAMP('2025-06-09 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN010', 'DRN006', 'OCO010', TO_TIMESTAMP('2025-06-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');