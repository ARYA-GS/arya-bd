CREATE OR REPLACE TRIGGER arya_usuario_validacao
BEFORE INSERT OR UPDATE ON ARYA_USUARIO
FOR EACH ROW
DECLARE
    v_email_pattern CONSTANT VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
BEGIN
    -- Validar email com regex simples
    IF NOT REGEXP_LIKE(:NEW.email, v_email_pattern) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email inválido.');
    END IF;
    -- Validar data de nascimento não ser futura
    IF :NEW.data_nasc IS NOT NULL AND :NEW.data_nasc > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'Data de nascimento não pode ser futura.');
    END IF;
END;

CREATE OR REPLACE TRIGGER arya_especificacao_validacao
BEFORE INSERT OR UPDATE ON ARYA_ESPECIFICACAO
FOR EACH ROW
BEGIN
    IF :NEW.autonomia_minutos IS NOT NULL AND :NEW.autonomia_minutos <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Autonomia deve ser maior que zero.');
    END IF;
    IF :NEW.fabricante IS NULL OR TRIM(:NEW.fabricante) = '' THEN
        RAISE_APPLICATION_ERROR(-20004, 'Fabricante é obrigatório.');
    END IF;
    IF :NEW.tipo_drone IS NULL OR TRIM(:NEW.tipo_drone) = '' THEN
        RAISE_APPLICATION_ERROR(-20005, 'Tipo de drone é obrigatório.');
    END IF;
END;

CREATE OR REPLACE TRIGGER arya_endereco_validacao
BEFORE INSERT OR UPDATE ON ARYA_ENDERECO
FOR EACH ROW
BEGIN
    IF :NEW.latitude IS NOT NULL AND (:NEW.latitude < -90 OR :NEW.latitude > 90) THEN
        RAISE_APPLICATION_ERROR(-20006, 'Latitude inválida. Deve estar entre -90 e 90.');
    END IF;
    IF :NEW.longitude IS NOT NULL AND (:NEW.longitude < -180 OR :NEW.longitude > 180) THEN
        RAISE_APPLICATION_ERROR(-20007, 'Longitude inválida. Deve estar entre -180 e 180.');
    END IF;
END;

CREATE OR REPLACE TRIGGER arya_area_operacao_validacao
BEFORE INSERT OR UPDATE ON ARYA_AREA_OPERACAO
FOR EACH ROW
BEGIN
    IF :NEW.latitude_central < -90 OR :NEW.latitude_central > 90 THEN
        RAISE_APPLICATION_ERROR(-20008, 'Latitude central inválida. Deve estar entre -90 e 90.');
    END IF;
    IF :NEW.longitude_central < -180 OR :NEW.longitude_central > 180 THEN
        RAISE_APPLICATION_ERROR(-20009, 'Longitude central inválida. Deve estar entre -180 e 180.');
    END IF;
END;

CREATE OR REPLACE TRIGGER arya_hub_operacional_validacao
BEFORE INSERT OR UPDATE ON ARYA_HUB_OPERACIONAL
FOR EACH ROW
BEGIN
    IF :NEW.status IS NOT NULL AND LOWER(:NEW.status) NOT IN ('ativo', 'inativo', 'manutencao') THEN
        RAISE_APPLICATION_ERROR(-20010, 'Status inválido para Hub Operacional.');
    END IF;
END;

CREATE OR REPLACE TRIGGER arya_drone_validacao
BEFORE INSERT OR UPDATE ON ARYA_DRONE
FOR EACH ROW
BEGIN
    IF :NEW.nome IS NULL OR TRIM(:NEW.nome) = '' THEN
        RAISE_APPLICATION_ERROR(-20011, 'Nome do drone é obrigatório.');
    END IF;

    IF :NEW.status IS NOT NULL AND LOWER(:NEW.status) NOT IN ('ativo', 'inativo', 'em voo', 'manutencao') THEN
        RAISE_APPLICATION_ERROR(-20012, 'Status inválido para Drone.');
    END IF;
END;

CREATE OR REPLACE TRIGGER arya_ocorrencia_validacao
BEFORE INSERT OR UPDATE ON ARYA_OCORRENCIA
FOR EACH ROW
BEGIN
    IF :NEW.nivel_severidade < 1 OR :NEW.nivel_severidade > 10 THEN
        RAISE_APPLICATION_ERROR(-20013, 'Nível de severidade deve estar entre 1 e 10.');
    END IF;

    IF :NEW.data_ocorrencia > SYSTIMESTAMP THEN
        RAISE_APPLICATION_ERROR(-20014, 'Data de ocorrência não pode ser no futuro.');
    END IF;

    IF LOWER(:NEW.tipo_ocorrencia) NOT IN ('falha', 'acidente', 'manutencao', 'outros') THEN
        RAISE_APPLICATION_ERROR(-20015, 'Tipo de ocorrência inválido.');
    END IF;
END;
