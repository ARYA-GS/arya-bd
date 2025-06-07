-- ARYA_USUARIO
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR001', 'Ana Beatriz Costa', 'ana.costa@email.com', 'senhaABC', TO_DATE('1985-03-22', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR002', 'Carlos Alberto Dias', 'carlos.dias@email.com', 'senhaCAR', TO_DATE('1992-07-10', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR003', 'Fernanda Lima e Silva', 'fernanda.lima@email.com', 'senhaFER', TO_DATE('1988-11-05', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR004', 'Ricardo Souza Mendes', 'ricardo.mendes@email.com', 'senhaRIC', TO_DATE('1995-01-30', 'YYYY-MM-DD'));
INSERT INTO ARYA_USUARIO (id_usuario, nome, email, senha, data_nasc) VALUES ('USR005', 'Juliana Pereira Alves', 'juliana.alves@email.com', 'senhaJUL', TO_DATE('2000-09-12', 'YYYY-MM-DD'));

-- ARYA_ENDERECO
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END001', 'Copacabana', 'Rio de Janeiro', 'RJ', 'Brasil', -22.969778, -43.186859);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END002', 'Savassi', 'Belo Horizonte', 'MG', 'Brasil', -19.933001, -43.936100);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END003', 'Boa Viagem', 'Recife', 'PE', 'Brasil', -8.121960, -34.900780);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END004', 'Asa Norte', 'Brasília', 'DF', 'Brasil', -15.769970, -47.880090);
INSERT INTO ARYA_ENDERECO (id_endereco, bairro, cidade, estado, pais, latitude, longitude) VALUES ('END005', 'Moinhos de Vento', 'Porto Alegre', 'RS', 'Brasil', -30.024990, -51.209850);

-- ARYA_AREA_OPERACAO
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA001', -22.975000, -43.190000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA002', -19.930000, -43.940000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA003', -8.115000, -34.905000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA004', -15.775000, -47.885000);
INSERT INTO ARYA_AREA_OPERACAO (id_area_operacao, latitude_central, longitude_central) VALUES ('AREA005', -30.030000, -51.200000);

-- ARYA_HUB_OPERACIONAL
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB001', 'Hub Rio Sul', 'Ativo', 'END001');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB002', 'Hub Minas Gerais Central', 'Manutenção', 'END002');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB003', 'Hub Nordeste Principal', 'Ativo', 'END003');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB004', 'Hub Capital Federal', 'Inativo', 'END004');
INSERT INTO ARYA_HUB_OPERACIONAL (id_hub, nome, status, id_endereco) VALUES ('HUB005', 'Hub Porto Alegre Sul', 'Ativo', 'END005');

-- ARYA_DRONE
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN001', 'HUB001', 'Drone Alpha', 'Ativo', 'X-200', 50, 10, 'Carregando bateria');
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN002', 'HUB001', 'Drone Beta', 'Manutenção', 'Y-150', 40, 8, NULL);
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN003', 'HUB002', 'Drone Gamma', 'Ativo', 'Z-300', 70, 12, 'Carregando bateria');
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN004', NULL, 'Drone Delta', 'Inativo', 'X-100', 30, 6, NULL);
INSERT INTO ARYA_DRONE (id_drone, id_hub, nome, status, modelo, alcanceKM, cargaKg, carregamento) VALUES ('DRN005', 'HUB003', 'Drone Epsilon', 'Ativo', 'Y-200', 60, 9, 'Carregando bateria');

-- ARYA_OCORRENCIA
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO001', 'Queimada Florestal', 4, TO_TIMESTAMP('2025-01-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Foco de incêndio detectado em área de vegetação densa, necessitando monitoramento aéreo urgente.', 'USR001', 'END001', 'AREA001');
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO002', 'Enchente Urbana', 5, TO_TIMESTAMP('2025-02-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Inundação severa em bairro residencial após chuvas intensas, vias interditadas.', 'USR002', 'END002', 'AREA002');
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO003', 'Onda de Calor Extremo', 3, TO_TIMESTAMP('2025-03-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Temperaturas elevadas persistentes acima de 40°C, risco à saúde pública e aumento de focos de incêndio.', 'USR003', 'END003', 'AREA003');
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO004', 'Deslizamento de Terra', 5, TO_TIMESTAMP('2025-04-05 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deslocamento de grande volume de terra em encosta próxima a área habitada, risco de soterramento.', 'USR001', 'END005', 'AREA005');
INSERT INTO ARYA_OCORRENCIA (id_ocorrencia, tipo_ocorrencia, nivel_severidade, data_ocorrencia, descricao, id_usuario, id_endereco, id_area_operacao) VALUES ('OCO005', 'Vendaval Destrutivo', 4, TO_TIMESTAMP('2025-05-29 23:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ventos com velocidade superior a 90km/h causando destelhamentos e queda de árvores.', 'USR004', 'END004', NULL); -- id_area_operacao NULO se a ocorrência for muito generalizada ou não mapeada a uma área específica.

-- ARYA_MISSAO_DRONE
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN001', 'DRN001', 'OCO001', TO_TIMESTAMP('2025-06-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Concluída');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN002', 'DRN002', 'OCO002', TO_TIMESTAMP('2025-06-02 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Em andamento');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN003', 'DRN003', 'OCO003', TO_TIMESTAMP('2025-06-03 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-03 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Concluída');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN004', 'DRN004', 'OCO004', TO_TIMESTAMP('2025-06-04 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');
INSERT INTO ARYA_MISSAO_DRONE (id_missao, id_drone, id_ocorrencia, dataInicio, dataFim, status) VALUES ('MSN005', 'DRN001', 'OCO005', TO_TIMESTAMP('2025-06-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL, 'Pendente');
