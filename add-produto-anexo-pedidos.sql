-- Adiciona campos de produto e anexo na tabela de pedidos
alter table pedidos add column if not exists produto text;
alter table pedidos add column if not exists anexo_url text;
alter table pedidos add column if not exists anexo_nome text;

-- Cria o espaço de armazenamento para os anexos dos pedidos
insert into storage.buckets (id, name, public)
values ('anexos-pedidos', 'anexos-pedidos', true)
on conflict (id) do nothing;

-- Permite que qualquer usuário logado envie e veja os anexos
create policy "anexos_pedidos_upload" on storage.objects for insert
  with check (bucket_id = 'anexos-pedidos' and auth.role() = 'authenticated');

create policy "anexos_pedidos_leitura" on storage.objects for select
  using (bucket_id = 'anexos-pedidos');
