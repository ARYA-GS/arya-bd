CREATE OR REPLACE PACKAGE pkg_arya_management AS
    PROCEDURE insert_arya_usuario (
        p_id_usuario    IN VARCHAR2,
        p_nome          IN VARCHAR2,
        p_email         IN VARCHAR2,
        p_senha         IN VARCHAR2,
        p_data_nasc     IN DATE
    );

    PROCEDURE update_arya_usuario (
        p_id_usuario    IN VARCHAR2,
        p_nome          IN VARCHAR2,
        p_email         IN VARCHAR2,
        p_senha         IN VARCHAR2,
        p_data_nasc     IN DATE
    );

    PROCEDURE delete_arya_usuario (
        p_id_usuario IN VARCHAR2
    );
    PROCEDURE insert_arya_endereco (
        p_id_endereco IN VARCHAR2,
        p_bairro      IN VARCHAR2,
        p_cidade      IN VARCHAR2,
        p_estado      IN VARCHAR2,
        p_pais        IN VARCHAR2,
        p_latitude    IN NUMBER,
        p_longitude   IN NUMBER
    );

    PROCEDURE update_arya_endereco (
        p_id_endereco IN VARCHAR2,
        p_bairro      IN VARCHAR2,
        p_cidade      IN VARCHAR2,
        p_estado      IN VARCHAR2,
        p_pais        IN VARCHAR2,
        p_latitude    IN NUMBER,
        p_longitude   IN NUMBER
    );

    PROCEDURE delete_arya_endereco (
        p_id_endereco IN VARCHAR2
    );
    PROCEDURE insert_arya_area_operacao (
        p_id_area_operacao IN VARCHAR2,
        p_latitude_central IN NUMBER,
        p_longitude_central IN NUMBER
    );

    PROCEDURE update_arya_area_operacao (
        p_id_area_operacao IN VARCHAR2,
        p_latitude_central IN NUMBER,
        p_longitude_central IN NUMBER
    );

    PROCEDURE delete_arya_area_operacao (
        p_id_area_operacao IN VARCHAR2
    );
    PROCEDURE insert_arya_hub_operacional (
        p_id_hub IN VARCHAR2,
        p_nome IN VARCHAR2,
        p_status IN VARCHAR2,
        p_id_endereco IN VARCHAR2
    );

    PROCEDURE update_arya_hub_operacional (
        p_id_hub IN VARCHAR2,
        p_nome IN VARCHAR2,
        p_status IN VARCHAR2,
        p_id_endereco IN VARCHAR2
    );

    PROCEDURE delete_arya_hub_operacional (
        p_id_hub IN VARCHAR2
    );
    PROCEDURE insert_arya_drone (
        p_id_drone IN VARCHAR2,
        p_id_hub IN VARCHAR2,
        p_nome IN VARCHAR2,
        p_status IN VARCHAR2,
        p_modelo IN VARCHAR2,
        p_alcanceKM IN NUMBER,
        p_cargaKg IN NUMBER,
        p_carregamento IN VARCHAR2
    );

    PROCEDURE update_arya_drone (
        p_id_drone IN VARCHAR2,
        p_id_hub IN VARCHAR2,
        p_nome IN VARCHAR2,
        p_status IN VARCHAR2,
        p_modelo IN VARCHAR2,
        p_alcanceKM IN NUMBER,
        p_cargaKg IN NUMBER,
        p_carregamento IN VARCHAR2
    );

    PROCEDURE delete_arya_drone (
        p_id_drone IN VARCHAR2
    );
    PROCEDURE insert_arya_ocorrencia (
        p_id_ocorrencia IN VARCHAR2,
        p_tipo_ocorrencia IN VARCHAR2,
        p_nivel_severidade IN NUMBER,
        p_data_ocorrencia IN TIMESTAMP,
        p_descricao IN CLOB,
        p_id_usuario IN VARCHAR2,
        p_id_endereco IN VARCHAR2,
        p_id_area_operacao IN VARCHAR2
    );

    PROCEDURE update_arya_ocorrencia (
        p_id_ocorrencia       IN VARCHAR2,
        p_tipo_ocorrencia     IN VARCHAR2,
        p_nivel_severidade    IN NUMBER,
        p_data_ocorrencia     IN TIMESTAMP,
        p_descricao           IN CLOB,
        p_id_usuario          IN VARCHAR2,
        p_id_endereco         IN VARCHAR2,
        p_id_area_operacao    IN VARCHAR2
    );

    PROCEDURE delete_arya_ocorrencia (
        p_id_ocorrencia IN VARCHAR2
    );

    PROCEDURE insert_arya_missao_drone (
        p_id_missao IN VARCHAR2,
        p_id_drone IN VARCHAR2,
        p_id_ocorrencia IN VARCHAR2,
        p_dataInicio IN TIMESTAMP,
        p_dataFim IN TIMESTAMP,
        p_status IN VARCHAR2
    );

    PROCEDURE update_arya_missao_drone (
        p_id_missao IN VARCHAR2,
        p_id_drone IN VARCHAR2,
        p_id_ocorrencia IN VARCHAR2,
        p_dataInicio IN TIMESTAMP,
        p_dataFim IN TIMESTAMP,
        p_status IN VARCHAR2
    );

    PROCEDURE delete_arya_missao_drone (
        p_id_missao IN VARCHAR2
    );

    FUNCTION fnc_pontuacao_severidade (
        p_nivel_severidade IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION fnc_ranking_ocorrencias_hub (
        p_id_hub IN ARYA_HUB_OPERACIONAL.id_hub%TYPE
    ) RETURN NUMBER;

    FUNCTION fnc_calcula_risco (
        p_nivel_severidade IN NUMBER
    ) RETURN NUMBER;

    PROCEDURE prc_listar_drones_manutencao;

    PROCEDURE prc_listar_ocorrencias_criticas;

    PROCEDURE prc_ativar_drones_hubs_ativos; 

    PROCEDURE prc_rel_usuarios_ocorren_out; 
    PROCEDURE prc_listar_hubs_sem_drones;

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
