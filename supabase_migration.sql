-- Social IQ MVP Migration
-- Tables: user_profiles, lesson_progress

-- User profiles (extends Supabase auth.users)
CREATE TABLE public.user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  avatar_url TEXT,
  current_streak INT DEFAULT 0,
  longest_streak INT DEFAULT 0,
  total_xp INT DEFAULT 0,
  onboarding_completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Lesson progress tracking
CREATE TABLE public.lesson_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
  lesson_id TEXT NOT NULL,
  score INT,
  completed BOOLEAN DEFAULT FALSE,
  started_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  UNIQUE(user_id, lesson_id)
);

-- Enable Row Level Security
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lesson_progress ENABLE ROW LEVEL SECURITY;

-- RLS Policies: users can only read/write their own data
CREATE POLICY "Users can view own profile"
  ON public.user_profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON public.user_profiles FOR UPDATE
  USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
  ON public.user_profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can view own progress"
  ON public.lesson_progress FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own progress"
  ON public.lesson_progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own progress"
  ON public.lesson_progress FOR UPDATE
  USING (auth.uid() = user_id);

-- Auto-create profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id)
  VALUES (NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Updated_at trigger
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_user_profiles_updated_at
  BEFORE UPDATE ON public.user_profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- Attempt tracking: how far a user got before exiting, and how many times they returned.
-- Applied via migration lesson_progress_attempt_tracking.
ALTER TABLE public.lesson_progress
  ADD COLUMN attempt_count INT NOT NULL DEFAULT 0,
  ADD COLUMN last_reached_question INT,
  ADD COLUMN last_visited_at TIMESTAMPTZ;

-- Atomic increment on lesson open. SECURITY INVOKER so existing RLS policies apply.
CREATE OR REPLACE FUNCTION public.record_lesson_start(
  p_user_id UUID,
  p_lesson_id TEXT
) RETURNS INT
LANGUAGE SQL
SECURITY INVOKER
AS $$
  INSERT INTO public.lesson_progress (user_id, lesson_id, attempt_count, last_visited_at, started_at)
  VALUES (p_user_id, p_lesson_id, 1, NOW(), NOW())
  ON CONFLICT (user_id, lesson_id) DO UPDATE
    SET attempt_count = lesson_progress.attempt_count + 1,
        last_visited_at = NOW()
  RETURNING attempt_count;
$$;

GRANT EXECUTE ON FUNCTION public.record_lesson_start(UUID, TEXT) TO authenticated;
