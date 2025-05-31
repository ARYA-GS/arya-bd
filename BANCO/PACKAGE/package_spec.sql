CREATE OR REPLACE PACKAGE pkg_arya_management AS

    -- TYPE para REF CURSOR (pode ser omitido se usar SYS_REFCURSOR diretamente)
    -- TYPE ref_cursor_type IS REF CURSOR; -- Usaremos SYS_REFCURSOR diretamente

    --------------------------------------------------------------------------------
    -- PROCEDURES: ARYA_USUARIO
    --------------------------------------------------------------------------------
    PROCEDURE prc_insert_arya_usuario (
        p_id_usuario    IN ARYA_USUARIO.id_usuario%TYPE,
        p_nome          IN ARYA_USUARIO.nome%TYPE,
        p_email         IN ARYA_USUARIO.email%TYPE,
        p_senha         IN ARYA_USUARIO.senha%TYPE,
        p_data_nasc     IN ARYA_USUARIO.data_nasc%TYPE
    );

    PROCEDURE prc_update_arya_usuario (
        p_id_usuario    IN ARYA_USUARIO.id_usuario%TYPE,
        p_nome          IN ARYA_USUARIO.nome%TYPE,
        p_email         IN ARYA_USUARIO.email%TYPE,
        p_senha         IN ARYA_USUARIO.senha%TYPE,
        p_data_nasc     IN ARYA_USUARIO.data_nasc%TYPE
    );

    PROCEDURE prc_delete_arya_usuario (
        p_id_usuario IN ARYA_USUARIO.id_usuario%TYPE
    );

    --------------------------------------------------------------------------------
    -- PROCEDURES: ARYA_ESPECIFICACAO
    --------------------------------------------------------------------------------
    PROCEDURE prc_insert_arya_especificacao (
        p_id_especificacao IN ARYA_ESPECIFICACAO.id_especificacao%TYPE,
        p_fabricante       IN ARYA_ESPECIFICACAO.fabricante%TYPE,
        p_autonomia        IN ARYA_ESPECIFICACAO.autonomia_minutos%TYPE,
        p_tipo_drone       IN ARYA_ESPECIFICACAO.tipo_drone%TYPE,
        p_modelo           IN ARYA_ESPECIFICACAO.modelo%TYPE
    );

    PROCEDURE prc_update_arya_especificacao (
        p_id_especificacao IN ARYA_ESPECIFICACAO.id_especificacao%TYPE,
        p_fabricante       IN ARYA_ESPECIFICACAO.fabricante%TYPE,
        p_autonomia        IN ARYA_ESPECIFICACAO.autonomia_minutos%TYPE,
        p_tipo_drone       IN ARYA_ESPECIFICACAO.tipo_drone%TYPE,
        p_modelo           IN ARYA_ESPECIFICACAO.modelo%TYPE
    );

    PROCEDURE prc_delete_arya_especificacao (
        p_id_especificacao IN ARYA_ESPECIFICACAO.id_especificacao%TYPE
    );

    --------------------------------------------------------------------------------
    -- PROCEDURES: ARYA_ENDERECO
    --------------------------------------------------------------------------------
    PROCEDURE prc_insert_arya_endereco (
        p_id_endereco IN ARYA_ENDERECO.id_endereco%TYPE,
        p_bairro      IN ARYA_ENDERECO.bairro%TYPE,
        p_cidade      IN ARYA_ENDERECO.cidade%TYPE,
        p_estado      IN ARYA_ENDERECO.estado%TYPE,
        p_pais        IN ARYA_ENDERECO.pais%TYPE,
        p_latitude    IN ARYA_ENDERECO.latitude%TYPE,
        p_longitude   IN ARYA_ENDERECO.longitude%TYPE
    );

    PROCEDURE prc_update_arya_endereco (
        p_id_endereco IN ARYA_ENDERECO.id_endereco%TYPE,
        p_bairro      IN ARYA_ENDERECO.bairro%TYPE,
        p_cidade      IN ARYA_ENDERECO.cidade%TYPE,
        p_estado      IN ARYA_ENDERECO.estado%TYPE,
        p_pais        IN ARYA_ENDERECO.pais%TYPE,
        p_latitude    IN ARYA_ENDERECO.latitude%TYPE,
        p_longitude   IN ARYA_ENDERECO.longitude%TYPE
    );

    PROCEDURE prc_delete_arya_endereco (
        p_id_endereco IN ARYA_ENDERECO.id_endereco%TYPE
    );

    --------------------------------------------------------------------------------
    -- PROCEDURES: ARYA_AREA_OPERACAO
    --------------------------------------------------------------------------------
    PROCEDURE prc_insert_arya_area_operacao (
        p_id_area_operacao  IN ARYA_AREA_OPERACAO.id_area_operacao%TYPE,
        p_latitude_central  IN ARYA_AREA_OPERACAO.latitude_central%TYPE,
        p_longitude_central IN ARYA_AREA_OPERACAO.longitude_central%TYPE
    );

    PROCEDURE prc_update_arya_area_operacao (
        p_id_area_operacao  IN ARYA_AREA_OPERACAO.id_area_operacao%TYPE,
        p_latitude_central  IN ARYA_AREA_OPERACAO.latitude_central%TYPE,
        p_longitude_central IN ARYA_AREA_OPERACAO.longitude_central%TYPE
    );

    PROCEDURE prc_delete_arya_area_operacao (
        p_id_area_operacao IN ARYA_AREA_OPERACAO.id_area_operacao%TYPE
    );

    --------------------------------------------------------------------------------
    -- PROCEDURES: ARYA_HUB_OPERACIONAL
    --------------------------------------------------------------------------------
    PROCEDURE prc_insert_arya_hub_operacional (
        p_id_hub      IN ARYA_HUB_OPERACIONAL.id_hub%TYPE,
        p_nome        IN ARYA_HUB_OPERACIONAL.nome%TYPE,
        p_status      IN ARYA_HUB_OPERACIONAL.status%TYPE,
        p_id_endereco IN ARYA_HUB_OPERACIONAL.id_endereco%TYPE
    );

    PROCEDURE prc_update_arya_hub_operacional (
        p_id_hub      IN ARYA_HUB_OPERACIONAL.id_hub%TYPE,
        p_nome        IN ARYA_HUB_OPERACIONAL.nome%TYPE,
        p_status      IN ARYA_HUB_OPERACIONAL.status%TYPE,
        p_id_endereco IN ARYA_HUB_OPERACIONAL.id_endereco%TYPE
    );

    PROCEDURE prc_delete_arya_hub_operacional (
        p_id_hub IN ARYA_HUB_OPERACIONAL.id_hub%TYPE
    );

    --------------------------------------------------------------------------------
    -- PROCEDURES: ARYA_DRONE
    --------------------------------------------------------------------------------
    PROCEDURE prc_insert_arya_drone (
        p_id_drone         IN ARYA_DRONE.id_drone%TYPE,
        p_id_hub           IN ARYA_DRONE.id_hub%TYPE,
        p_nome             IN ARYA_DRONE.nome%TYPE,
        p_status           IN ARYA_DRONE.status%TYPE,
        p_id_especificacao IN ARYA_DRONE.id_especificacao%TYPE,
        p_carregamento     IN ARYA_DRONE.carregamento%TYPE
    );

    PROCEDURE prc_update_arya_drone (
        p_id_drone         IN ARYA_DRONE.id_drone%TYPE,
        p_id_hub           IN ARYA_DRONE.id_hub%TYPE,
        p_nome             IN ARYA_DRONE.nome%TYPE,
        p_status           IN ARYA_DRONE.status%TYPE,
        p_id_especificacao IN ARYA_DRONE.id_especificacao%TYPE,
        p_carregamento     IN ARYA_DRONE.carregamento%TYPE
    );

    PROCEDURE prc_delete_arya_drone (
        p_id_drone IN ARYA_DRONE.id_drone%TYPE
    );

    --------------------------------------------------------------------------------
    -- PROCEDURES: ARYA_OCORRENCIA
    --------------------------------------------------------------------------------
    PROCEDURE prc_insert_arya_ocorrencia (
        p_id_ocorrencia    IN ARYA_OCORRENCIA.id_ocorrencia%TYPE,
        p_tipo_ocorrencia  IN ARYA_OCORRENCIA.tipo_ocorrencia%TYPE,
        p_nivel_severidade IN ARYA_OCORRENCIA.nivel_severidade%TYPE,
        p_data_ocorrencia  IN ARYA_OCORRENCIA.data_ocorrencia%TYPE,
        p_descricao        IN ARYA_OCORRENCIA.descricao%TYPE,
        p_id_usuario       IN ARYA_OCORRENCIA.id_usuario%TYPE,
        p_id_endereco      IN ARYA_OCORRENCIA.id_endereco%TYPE,
        p_id_area_operacao IN ARYA_OCORRENCIA.id_area_operacao%TYPE
    );

    PROCEDURE prc_update_arya_ocorrencia (
        p_id_ocorrencia    IN ARYA_OCORRENCIA.id_ocorrencia%TYPE,
        p_tipo_ocorrencia  IN ARYA_OCORRENCIA.tipo_ocorrencia%TYPE,
        p_nivel_severidade IN ARYA_OCORRENCIA.nivel_severidade%TYPE,
        p_data_ocorrencia  IN ARYA_OCORRENCIA.data_ocorrencia%TYPE,
        p_descricao        IN ARYA_OCORRENCIA.descricao%TYPE,
        p_id_usuario       IN ARYA_OCORRENCIA.id_usuario%TYPE,
        p_id_endereco      IN ARYA_OCORRENCIA.id_endereco%TYPE,
        p_id_area_operacao IN ARYA_OCORRENCIA.id_area_operacao%TYPE
    );

    PROCEDURE prc_delete_arya_ocorrencia (
        p_id_ocorrencia IN ARYA_OCORRENCIA.id_ocorrencia%TYPE
    );

    --------------------------------------------------------------------------------
    -- FUNCTIONS
    --------------------------------------------------------------------------------
    FUNCTION fnc_pontuacao_severidade (
        p_nivel_severidade IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION fnc_ranking_ocorrencias_hub (
        p_id_hub IN ARYA_HUB_OPERACIONAL.id_hub%TYPE
    ) RETURN NUMBER;

    FUNCTION fnc_calcula_risco (
        p_nivel_severidade IN NUMBER
    ) RETURN NUMBER;

    --------------------------------------------------------------------------------
    -- PROCEDURES FROM ANONYMOUS BLOCKS (for DBMS_OUTPUT listings)
    --------------------------------------------------------------------------------
    PROCEDURE prc_listar_drones_manutencao;

    PROCEDURE prc_listar_ocorrencias_criticas;

    PROCEDURE prc_ativar_drones_hubs_ativos; -- Contains COMMIT

    PROCEDURE prc_rel_usuarios_ocorren_out; -- Renamed for clarity

    PROCEDURE prc_listar_hubs_sem_drones;

    --------------------------------------------------------------------------------
    -- FUNCTIONS FOR REPORTS (returning SYS_REFCURSOR)
    --------------------------------------------------------------------------------
    FUNCTION fnc_rel_contagem_drones_status
        RETURN SYS_REFCURSOR;

    FUNCTION fnc_rel_ocorrencias_tipo_avg_sev
        RETURN SYS_REFCURSOR;

    FUNCTION fnc_rel_drones_por_hub
        RETURN SYS_REFCURSOR;

    FUNCTION fnc_rel_usuarios_rank_ocorrencias
        RETURN SYS_REFCURSOR;

    FUNCTION fnc_rel_ocorrencias_area_avg_sev
        RETURN SYS_REFCURSOR;

END pkg_arya_management;
/