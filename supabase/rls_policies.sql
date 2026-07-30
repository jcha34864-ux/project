-- Cubivora Studio auto-generated RLS policies (SaaS / 회원 데이터 격리)
-- Supabase SQL Editor 에 붙여넣고 Run 하세요.

ALTER TABLE public.screen ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "screen_select_own" ON public.screen;
CREATE POLICY "screen_select_own" ON public.screen
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "screen_insert_own" ON public.screen;
CREATE POLICY "screen_insert_own" ON public.screen
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "screen_update_own" ON public.screen;
CREATE POLICY "screen_update_own" ON public.screen
  FOR UPDATE USING (auth.uid() = user_id);

ALTER TABLE public.screen ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "screen_select_own" ON public.screen;
CREATE POLICY "screen_select_own" ON public.screen
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "screen_insert_own" ON public.screen;
CREATE POLICY "screen_insert_own" ON public.screen
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "screen_update_own" ON public.screen;
CREATE POLICY "screen_update_own" ON public.screen
  FOR UPDATE USING (auth.uid() = user_id);

ALTER TABLE public.screen ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "screen_select_own" ON public.screen;
CREATE POLICY "screen_select_own" ON public.screen
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "screen_insert_own" ON public.screen;
CREATE POLICY "screen_insert_own" ON public.screen
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "screen_update_own" ON public.screen;
CREATE POLICY "screen_update_own" ON public.screen
  FOR UPDATE USING (auth.uid() = user_id);

ALTER TABLE public.screen ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "screen_select_own" ON public.screen;
CREATE POLICY "screen_select_own" ON public.screen
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "screen_insert_own" ON public.screen;
CREATE POLICY "screen_insert_own" ON public.screen
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "screen_update_own" ON public.screen;
CREATE POLICY "screen_update_own" ON public.screen
  FOR UPDATE USING (auth.uid() = user_id);
