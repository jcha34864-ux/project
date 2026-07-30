-- Cubivora Studio auto-generated schema
-- Supabase SQL Editor 에 붙여넣고 Run 하세요.

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS public.screen (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  status text NOT NULL,
  description text,
  label text NOT NULL
);

CREATE TABLE IF NOT EXISTS public.screen (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  status text NOT NULL,
  description text,
  label text NOT NULL
);

CREATE TABLE IF NOT EXISTS public.screen (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  status text NOT NULL,
  description text,
  label text NOT NULL
);

CREATE TABLE IF NOT EXISTS public.screen (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  status text NOT NULL,
  description text,
  label text NOT NULL
);
