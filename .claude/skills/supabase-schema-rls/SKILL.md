---
name: supabase-schema-rls
description: Design and manage Supabase schemas, RLS policies, and migrations for Social IQ. Trigger on: "create table", "add RLS", "migration", "supabase schema", "database design".
---

# Supabase Schema & RLS for Social IQ

## Stack
- Supabase (PostgreSQL 15+)
- supabase-swift SDK (async/await)
- All tables snake_case, all Swift types PascalCase

## Core Tables

### profiles (extends auth.users)
```sql
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  avatar_url TEXT,
  subscription_status TEXT DEFAULT 'free' CHECK (subscription_status IN ('free', 'trial', 'premium')),
  streak_count INTEGER DEFAULT 0,
  longest_streak INTEGER DEFAULT 0,
  total_lessons_completed INTEGER DEFAULT 0,
  onboarding_completed BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own profile"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
  ON public.profiles FOR INSERT
  WITH CHECK (auth.uid() = id);
```

### lessons
```sql
CREATE TABLE public.lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  difficulty INTEGER DEFAULT 1 CHECK (difficulty BETWEEN 1 AND 5),
  order_index INTEGER NOT NULL,
  content JSONB NOT NULL,
  is_premium BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Lessons are readable by all authenticated users"
  ON public.lessons FOR SELECT
  TO authenticated
  USING (true);
```

### user_progress
```sql
CREATE TABLE public.user_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID NOT NULL REFERENCES public.lessons(id) ON DELETE CASCADE,
  started_at TIMESTAMPTZ DEFAULT now(),
  completed_at TIMESTAMPTZ,
  score INTEGER,
  time_spent_seconds INTEGER,
  UNIQUE(user_id, lesson_id)
);

ALTER TABLE public.user_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own progress"
  ON public.user_progress FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own progress"
  ON public.user_progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own progress"
  ON public.user_progress FOR UPDATE
  USING (auth.uid() = user_id);
```

### practice_sessions
```sql
CREATE TABLE public.practice_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES public.lessons(id),
  session_type TEXT NOT NULL CHECK (session_type IN ('lesson', 'review', 'challenge')),
  started_at TIMESTAMPTZ DEFAULT now(),
  completed_at TIMESTAMPTZ,
  score INTEGER,
  answers JSONB
);

ALTER TABLE public.practice_sessions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own sessions"
  ON public.practice_sessions FOR ALL
  USING (auth.uid() = user_id);
```

### achievements
```sql
CREATE TABLE public.achievements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  icon_name TEXT,
  requirement_type TEXT NOT NULL,
  requirement_value INTEGER NOT NULL
);

ALTER TABLE public.achievements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Achievements readable by all authenticated"
  ON public.achievements FOR SELECT
  TO authenticated
  USING (true);
```

### user_achievements
```sql
CREATE TABLE public.user_achievements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  achievement_id UUID NOT NULL REFERENCES public.achievements(id),
  earned_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, achievement_id)
);

ALTER TABLE public.user_achievements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own achievements"
  ON public.user_achievements FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own achievements"
  ON public.user_achievements FOR INSERT
  WITH CHECK (auth.uid() = user_id);
```

### subscriptions
```sql
CREATE TABLE public.subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  product_id TEXT NOT NULL,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'expired', 'cancelled', 'trial')),
  started_at TIMESTAMPTZ DEFAULT now(),
  expires_at TIMESTAMPTZ,
  transaction_id TEXT
);

ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own subscriptions"
  ON public.subscriptions FOR SELECT
  USING (auth.uid() = user_id);
```

## Indexes
```sql
CREATE INDEX idx_user_progress_user ON public.user_progress(user_id);
CREATE INDEX idx_user_progress_lesson ON public.user_progress(lesson_id);
CREATE INDEX idx_practice_sessions_user ON public.practice_sessions(user_id);
CREATE INDEX idx_lessons_category ON public.lessons(category);
CREATE INDEX idx_lessons_order ON public.lessons(order_index);
CREATE INDEX idx_subscriptions_user ON public.subscriptions(user_id);
```

## Migration workflow
```bash
# Generate migration from local changes
supabase db diff --schema public -f [migration_name]

# Apply migration
supabase db push

# Reset local (destructive)
supabase db reset
```

## Swift patterns (async/await + supabase-swift)
```swift
// Fetch user profile
let profile: Profile = try await supabase
  .from("profiles")
  .select()
  .eq("id", value: userId)
  .single()
  .execute()
  .value

// Insert progress
try await supabase
  .from("user_progress")
  .insert(UserProgress(userId: userId, lessonId: lessonId))
  .execute()

// Update with returning
let updated: Profile = try await supabase
  .from("profiles")
  .update(["streak_count": newStreak])
  .eq("id", value: userId)
  .select()
  .single()
  .execute()
  .value
```

## RLS pattern
Every table with user data: `auth.uid() = user_id` for SELECT, INSERT (WITH CHECK), UPDATE, DELETE.
Shared content tables (lessons, achievements): `TO authenticated USING (true)` for SELECT only.

## Post-task reflection (run after every completed task)

Before marking the Notion task Done, answer these four questions:
1. Did I do anything differently from what this skill instructed?
2. Did I encounter an error this skill didn't anticipate?
3. Did I find a faster or better method?
4. Did the human override my approach at any decision point?

If YES to any: format a skill update proposal:
  SKILL UPDATE PROPOSED — supabase-schema-rls
  Change: [what to add/modify/remove]
  Reason: [why this would have helped]
  Diff: [exact before/after lines]

Send via ccgram as a decision card (same format as Layer 1).
Wait for approval before modifying the skill file.
If approved: apply the diff. Commit: "skill: supabase-schema-rls update — [one-line reason] [agent]"
If rejected: log the reasoning in DECISIONS.md and do not retry.
