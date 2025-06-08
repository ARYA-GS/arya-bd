-- Substituir todo o conteúdo do arquivo: 06_TRIGGERS/triggers.sql

CREATE OR REPLACE TRIGGER trg_arya_usuario_validacao
BEFORE INSERT OR UPDATE ON ARYA_USUARIO
FOR EACH ROW
BEGIN
    pkg_arya_management.prc_valida_usuario(
        p_email     => :NEW.email,
        p_data_nasc => :NEW.data_nasc
    );
END;
/

CREATE OR REPLACE TRIGGER trg_arya_endereco_validacao
BEFORE INSERT OR UPDATE ON ARYA_ENDERECO
FOR EACH ROW
BEGIN
    pkg_arya_management.prc_valida_endereco(
        p_latitude  => :NEW.latitude,
        p_longitude => :NEW.longitude
    );
END;
/

CREATE OR REPLACE TRIGGER trg_arya_area_operacao_validacao
BEFORE INSERT OR UPDATE ON ARYA_AREA_OPERACAO
FOR EACH ROW
BEGIN
    pkg_arya_management.prc_valida_area_operacao(
        p_latitude_central  => :NEW.latitude_central,
        p_longitude_central => :NEW.longitude_central
    );
END;
/

CREATE OR REPLACE TRIGGER trg_arya_hub_operacional_validacao
BEFORE INSERT OR UPDATE ON ARYA_HUB_OPERACIONAL
FOR EACH ROW
BEGIN
    pkg_arya_management.prc_valida_hub_operacional(p_status => :NEW.status);
END;
/

CREATE OR REPLACE TRIGGER trg_arya_drone_validacao
BEFORE INSERT OR UPDATE ON ARYA_DRONE
FOR EACH ROW
BEGIN
    pkg_arya_management.prc_valida_drone(
        p_nome      => :NEW.nome,
        p_status    => :NEW.status,
        p_modelo    => :NEW.modelo,
        p_alcanceKM => :NEW.alcanceKM,
        p_cargaKg   => :NEW.cargaKg
    );
END;
/

CREATE OR REPLACE TRIGGER trg_arya_missao_drone_validacao
BEFORE INSERT OR UPDATE ON ARYA_MISSAO_DRONE
FOR EACH ROW
BEGIN
    pkg_arya_management.prc_valida_missao_drone(
        p_dataInicio => :NEW.dataInicio,
        p_dataFim    => :NEW.dataFim,
        p_status     => :NEW.status
    );
END;
