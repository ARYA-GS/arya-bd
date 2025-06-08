CREATE OR REPLACE PACKAGE pkg_arya_management AS

    /******************************************************************************
       PROCEDURES DE CRUD (INSERT, UPDATE, DELETE)
    ******************************************************************************/
    PROCEDURE insert_arya_usuario (p_id_usuario IN VARCHAR2, p_nome IN VARCHAR2, p_email IN VARCHAR2, p_senha IN VARCHAR2, p_data_nasc IN DATE);
    PROCEDURE update_arya_usuario (p_id_usuario IN VARCHAR2, p_nome IN VARCHAR2, p_email IN VARCHAR2, p_senha IN VARCHAR2, p_data_nasc IN DATE);
    PROCEDURE delete_arya_usuario (p_id_usuario IN VARCHAR2);
    
    PROCEDURE insert_arya_endereco (p_id_endereco IN VARCHAR2, p_bairro IN VARCHAR2, p_cidade IN VARCHAR2, p_estado IN VARCHAR2, p_pais IN VARCHAR2, p_latitude IN NUMBER, p_longitude IN NUMBER);
    PROCEDURE update_arya_endereco (p_id_endereco IN VARCHAR2, p_bairro IN VARCHAR2, p_cidade IN VARCHAR2, p_estado IN VARCHAR2, p_pais IN VARCHAR2, p_latitude IN NUMBER, p_longitude IN NUMBER);
    PROCEDURE delete_arya_endereco (p_id_endereco IN VARCHAR2);

    PROCEDURE insert_arya_area_operacao (p_id_area_operacao IN VARCHAR2, p_latitude_central IN NUMBER, p_longitude_central IN NUMBER);
    PROCEDURE update_arya_area_operacao (p_id_area_operacao IN VARCHAR2, p_latitude_central IN NUMBER, p_longitude_central IN NUMBER);
    PROCEDURE delete_arya_area_operacao (p_id_area_operacao IN VARCHAR2);

    PROCEDURE insert_arya_hub_operacional (p_id_hub IN VARCHAR2, p_nome IN VARCHAR2, p_status IN VARCHAR2, p_id_endereco IN VARCHAR2);
    PROCEDURE update_arya_hub_operacional (p_id_hub IN VARCHAR2, p_nome IN VARCHAR2, p_status IN VARCHAR2, p_id_endereco IN VARCHAR2);
    PROCEDURE delete_arya_hub_operacional (p_id_hub IN VARCHAR2);

    PROCEDURE insert_arya_drone (p_id_drone IN VARCHAR2, p_id_hub IN VARCHAR2, p_nome IN VARCHAR2, p_status IN VARCHAR2, p_modelo IN VARCHAR2, p_alcanceKM IN NUMBER, p_cargaKg IN NUMBER, p_carregamento IN VARCHAR2);
    PROCEDURE update_arya_drone (p_id_drone IN VARCHAR2, p_id_hub IN VARCHAR2, p_nome IN VARCHAR2, p_status IN VARCHAR2, p_modelo IN VARCHAR2, p_alcanceKM IN NUMBER, p_cargaKg IN NUMBER, p_carregamento IN VARCHAR2);
    PROCEDURE delete_arya_drone (p_id_drone IN VARCHAR2);

    PROCEDURE insert_arya_ocorrencia (p_id_ocorrencia IN VARCHAR2, p_tipo_ocorrencia IN VARCHAR2, p_nivel_severidade IN NUMBER, p_data_ocorrencia IN TIMESTAMP, p_descricao IN CLOB, p_id_usuario IN VARCHAR2, p_id_endereco IN VARCHAR2, p_id_area_operacao IN VARCHAR2);
    PROCEDURE update_arya_ocorrencia (p_id_ocorrencia IN VARCHAR2, p_tipo_ocorrencia IN VARCHAR2, p_nivel_severidade IN NUMBER, p_data_ocorrencia IN TIMESTAMP, p_descricao IN CLOB, p_id_usuario IN VARCHAR2, p_id_endereco IN VARCHAR2, p_id_area_operacao IN VARCHAR2);
    PROCEDURE delete_arya_ocorrencia (p_id_ocorrencia IN VARCHAR2);

    PROCEDURE insert_arya_missao_drone (p_id_missao IN VARCHAR2, p_id_drone IN VARCHAR2, p_id_ocorrencia IN VARCHAR2, p_dataInicio IN TIMESTAMP, p_dataFim IN TIMESTAMP, p_status IN VARCHAR2);
    PROCEDURE update_arya_missao_drone (p_id_missao IN VARCHAR2, p_id_drone IN VARCHAR2, p_id_ocorrencia IN VARCHAR2, p_dataInicio IN TIMESTAMP, p_dataFim IN TIMESTAMP, p_status IN VARCHAR2);
    PROCEDURE delete_arya_missao_drone (p_id_missao IN VARCHAR2);

    /******************************************************************************
       FUNCTIONS DE NEGÓCIO
    ******************************************************************************/
    FUNCTION fnc_pontuacao_severidade (p_nivel_severidade IN NUMBER) RETURN VARCHAR2;
    FUNCTION fnc_ranking_ocorrencias_hub (p_id_hub IN ARYA_HUB_OPERACIONAL.id_hub%TYPE) RETURN NUMBER;
    FUNCTION fnc_calcula_risco (p_nivel_severidade IN NUMBER) RETURN NUMBER;

    /******************************************************************************
       PROCEDURES DE LÓGICA (ANTIGOS BLOCOS ANÔNIMOS E CURSORES)
    ******************************************************************************/
    PROCEDURE prc_verificar_e_ativar_drone(p_id_drone IN ARYA_DRONE.id_drone%TYPE);
    PROCEDURE prc_avaliar_severidade(p_severidade IN NUMBER);
    PROCEDURE prc_contar_drones_status;
    PROCEDURE prc_analisar_ocorrencias_usuario(p_id_usuario IN ARYA_USUARIO.id_usuario%TYPE);
    PROCEDURE prc_listar_drones_manutencao;
    PROCEDURE prc_listar_ocorrencias_criticas;
    PROCEDURE prc_ativar_drones_em_hubs_ativos;
    PROCEDURE prc_relatorio_detalhado_ocorrencias;
    PROCEDURE prc_listar_hubs_sem_drones;
    
    /******************************************************************************
       FUNCTIONS DE RELATÓRIO (COM SYS_REFCURSOR)
    ******************************************************************************/
    FUNCTION fnc_rel_contagem_drones_status RETURN SYS_REFCURSOR;
    FUNCTION fnc_rel_ocorrencias_tipo_avg_sev RETURN SYS_REFCURSOR;
    FUNCTION fnc_rel_drones_por_hub RETURN SYS_REFCURSOR;
    FUNCTION fnc_rel_usuarios_rank_ocorrencias RETURN SYS_REFCURSOR;
    FUNCTION fnc_rel_ocorrencias_area_avg_sev RETURN SYS_REFCURSOR;

    /******************************************************************************
       PROCEDURES DE VALIDAÇÃO (PARA SEREM CHAMADAS PELOS TRIGGERS)
    ******************************************************************************/
    PROCEDURE prc_valida_usuario (p_email IN ARYA_USUARIO.email%TYPE, p_data_nasc IN ARYA_USUARIO.data_nasc%TYPE);
    PROCEDURE prc_valida_endereco (p_latitude IN ARYA_ENDERECO.latitude%TYPE, p_longitude IN ARYA_ENDERECO.longitude%TYPE);
    PROCEDURE prc_valida_area_operacao (p_latitude_central IN ARYA_AREA_OPERACAO.latitude_central%TYPE, p_longitude_central IN ARYA_AREA_OPERACAO.longitude_central%TYPE);
    PROCEDURE prc_valida_hub_operacional (p_status IN ARYA_HUB_OPERACIONAL.status%TYPE);
    PROCEDURE prc_valida_drone (p_nome IN ARYA_DRONE.nome%TYPE, p_status IN ARYA_DRONE.status%TYPE, p_modelo IN ARYA_DRONE.modelo%TYPE, p_alcanceKM IN ARYA_DRONE.alcanceKM%TYPE, p_cargaKg IN ARYA_DRONE.cargaKg%TYPE);
    PROCEDURE prc_valida_missao_drone (p_dataInicio IN ARYA_MISSAO_DRONE.dataInicio%TYPE, p_dataFim IN ARYA_MISSAO_DRONE.dataFim%TYPE, p_status IN ARYA_MISSAO_DRONE.status%TYPE);

END pkg_arya_management;