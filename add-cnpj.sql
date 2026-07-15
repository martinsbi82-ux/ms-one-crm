-- Adiciona o campo CNPJ na tabela de oportunidades (Prospecção)
alter table oportunidades add column if not exists cnpj text;
