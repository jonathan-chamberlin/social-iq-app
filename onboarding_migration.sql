-- Migration: Add onboarding columns to user_profiles
-- Matches columns expected by OnboardingService.completeOnboarding()
--
-- Existing columns: id, display_name, avatar_url, current_streak,
--   longest_streak, total_xp, onboarding_completed, created_at, updated_at

ALTER TABLE user_profiles
  ADD COLUMN IF NOT EXISTS first_name TEXT,
  ADD COLUMN IF NOT EXISTS age INT,
  ADD COLUMN IF NOT EXISTS quiz1_answer TEXT,
  ADD COLUMN IF NOT EXISTS quiz2_answer TEXT,
  ADD COLUMN IF NOT EXISTS quiz3_answer TEXT,
  ADD COLUMN IF NOT EXISTS selected_goals TEXT[],
  ADD COLUMN IF NOT EXISTS referral_code TEXT;
