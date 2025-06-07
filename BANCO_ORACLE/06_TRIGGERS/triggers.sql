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
    -- Nome obrigatório
    IF :NEW.nome IS NULL OR TRIM(:NEW.nome) = '' THEN
        RAISE_APPLICATION_ERROR(-20011, 'Nome do drone é obrigatório.');
    END IF;

    -- Status válido
    IF :NEW.status IS NOT NULL AND LOWER(:NEW.status) NOT IN ('ativo', 'inativo', 'em voo', 'manutencao') THEN
        RAISE_APPLICATION_ERROR(-20012, 'Status inválido para Drone.');
    END IF;

    -- Modelo obrigatório
    IF :NEW.modelo IS NULL OR TRIM(:NEW.modelo) = '' THEN
        RAISE_APPLICATION_ERROR(-20016, 'Modelo do drone é obrigatório.');
    END IF;

    -- AlcanceKM deve ser maior que zero
    IF :NEW.alcanceKM IS NULL OR :NEW.alcanceKM <= 0 THEN
        RAISE_APPLICATION_ERROR(-20017, 'Alcance (KM) deve ser maior que zero.');
    END IF;

    -- cargaKg deve ser maior ou igual a zero (pode ser zero)
    IF :NEW.cargaKg IS NULL OR :NEW.cargaKg < 0 THEN
        RAISE_APPLICATION_ERROR(-20018, 'Carga (Kg) não pode ser negativa.');
    END IF;
END;

CREATE OR REPLACE TRIGGER arya_missao_drone_validacao
BEFORE INSERT OR UPDATE ON ARYA_MISSAO_DRONE
FOR EACH ROW
BEGIN
    -- Data início não pode ser nula
    IF :NEW.dataInicio IS NULL THEN
        RAISE_APPLICATION_ERROR(-20019, 'Data de início da missão é obrigatória.');
    END IF;

    -- Data fim não pode ser anterior à data início (se informada)
    IF :NEW.dataFim IS NOT NULL AND :NEW.dataFim < :NEW.dataInicio THEN
        RAISE_APPLICATION_ERROR(-20020, 'Data de fim da missão não pode ser anterior à data de início.');
    END IF;

    -- Status válido
    IF :NEW.status IS NOT NULL AND LOWER(:NEW.status) NOT IN ('concluída', 'em andamento', 'cancelada') THEN
     RAISE_APPLICATION_ERROR(-20021, 'Status inválido para Missão do drone.');
END IF;
END;
