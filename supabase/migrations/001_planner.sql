-- Run once in the selected FREE Supabase project's SQL Editor.
-- No extensions, storage buckets, realtime publications or paid services required.
begin;
create table if not exists public.planner_settings (
 user_id uuid primary key references auth.users(id) on delete cascade,
 categories jsonb not null default '[]'::jsonb,
 updated_at timestamptz not null default now(),
 constraint categories_array check (jsonb_typeof(categories) = 'array'),
 constraint categories_size check (octet_length(categories::text) <= 262144)
);
create table if not exists public.planner_days (
 user_id uuid not null references auth.users(id) on delete cascade,
 day date not null,
 entries jsonb not null default '[]'::jsonb,
 updated_at timestamptz not null default now(),
 primary key (user_id, day),
 constraint entries_array check (jsonb_typeof(entries) = 'array'),
 constraint entries_size check (octet_length(entries::text) <= 262144)
);
alter table public.planner_settings enable row level security;
alter table public.planner_days enable row level security;
revoke all on public.planner_settings, public.planner_days from anon, authenticated;
grant select, insert, update, delete on public.planner_settings, public.planner_days to authenticated;
drop policy if exists owner_only on public.planner_settings;
create policy owner_only on public.planner_settings for all to authenticated
 using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists owner_only on public.planner_days;
create policy owner_only on public.planner_days for all to authenticated
 using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create or replace function public.planner_set_updated_at() returns trigger
language plpgsql set search_path = '' as $$
begin new.updated_at = now(); return new; end;
$$;
revoke all on function public.planner_set_updated_at() from public;
drop trigger if exists planner_settings_timestamp on public.planner_settings;
create trigger planner_settings_timestamp before update on public.planner_settings
for each row execute function public.planner_set_updated_at();
drop trigger if exists planner_days_timestamp on public.planner_days;
create trigger planner_days_timestamp before update on public.planner_days
for each row execute function public.planner_set_updated_at();
commit;
