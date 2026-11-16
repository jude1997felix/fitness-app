-- Run once in the Supabase SQL editor. One row per user per day; data holds that day's meals and goals.
create table diet_days (
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  day date not null,
  data jsonb not null,
  primary key (user_id, day)
);
alter table diet_days enable row level security;
create policy "own rows only" on diet_days for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
