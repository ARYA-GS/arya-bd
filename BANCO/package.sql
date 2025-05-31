CREATE OR REPLACE PACKAGE PKG_ARYA_OPERATIONS AS

    -- Tipo público para retornar cursores (usado em relatórios)
    TYPE type_ref_cursor IS REF CURSOR;

    -- PROCEDURES
    PROCEDURE insert_arya_usuario (
        p_id_usuario     IN VARCHAR2,
        p_nome           IN VARCHAR2,
        p_email          IN VARCHAR2,
        p_senha          IN VARCHAR2,
        p_data_nasc      IN DATE
    );

    PROCEDURE update_arya_usuario (
        p_id_usuario     IN VARCHAR2,
        p_nome           IN VARCHAR2,
        p_email          IN VARCHAR2,
        p_senha          IN VARCHAR2,
        p_data_nasc      IN DATE
    );

    PROCEDURE delete_arya_usuario (
        p_id_usuario IN VARCHAR2
    );

    PROCEDURE inserir_arya_especificacao (
        p_id_especificacao IN VARCHAR2,
        p_fabricante       IN VARCHAR2,
        p_autonomia        IN NUMBER,
        p_tipo_drone       IN VARCHAR2,
        p_modelo           IN VARCHAR2
    );

    PROCEDURE update_arya_especificacao (
        p_id_especificacao IN VARCHAR2,
        p_fabricante       IN VARCHAR2,
        p_autonomia        IN NUMBER,
        p_tipo_drone       IN VARCHAR2,
        p_modelo           IN VARCHAR2
    );

    PROCEDURE delete_arya_especificacao (
        p_id_especificacao IN VARCHAR2
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
        p_id_especificacao IN VARCHAR2,
        p_carregamento IN VARCHAR2
    );

    PROCEDURE update_arya_drone (
        p_id_drone IN VARCHAR2,
        p_id_hub IN VARCHAR2,
        p_nome IN VARCHAR2,
        p_status IN VARCHAR2,
        p_id_especificacao IN VARCHAR2,
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

    -- FUNÇÕES
    FUNCTION fn_pontuacao_severidade (
        p_nivel_severidade IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION fn_ranking_ocorrencias_hub (
        p_id_hub IN VARCHAR2
    ) RETURN NUMBER;

    FUNCTION fn_calcula_risco (
        p_nivel_severidade IN NUMBER
    ) RETURN NUMBER;

END PKG_ARYA_OPERATIONS;


CREATE OR REPLACE PACKAGE BODY PKG_ARYA_OPERATIONS AS


END PKG_ARYA_OPERATIONS;