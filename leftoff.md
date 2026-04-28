# Left Off

**Last updated:** 2026-04-27 (late session)

## Binding constraint
**Zero users. Content/videos is the proven distribution lever. Ship videos, not lessons.**

App launched 2026-04-20. Within 3 days, one data point from Chloe (romantic interest, used Jonathan's phone mid-date, skipped onboarding, clicked out at Q2) was about to anchor a multi-day lesson overhaul before a single reel shipped. Jonathan named the pattern himself: "more and more stuff has been happening before I make videos." That's the diagnostic — trust it.

**The "no right answer" signal IS real** (3/3 ICP-female, structural not noise). But you can't fix retention on a cohort that doesn't exist. Content produces ICP-female users whose actual install/engage/churn behavior will confirm or disconfirm this better than 20 more research sessions. Park the lesson overhaul. Revisit at monthly review, or sooner only if a live paying ICP-female churns citing this reason specifically.

**Positioning = scripting.** Chloe asked who the app is for; Jonathan couldn't answer cleanly. The fix is not a positioning doc written in advance — it's writing 10 reel hooks and watching which framing survives contact with the feed.

**Next action: write and shoot reels.** Start with `content/reel-scripts/2026-04-21-batch.md` (5 scripts queued). Batch-shoot same-day.

## Unfinished
- **Uncommitted edits in repo from /update-skill run** — `.claude/skills/mixpanel-taxonomy/SKILL.md` (added Run-Query filter shape reference) and `.claude/skills/superwall-campaigns/SKILL.md` (added "ALWAYS pair identify() with restorePurchases()" gotcha in Identity Management section, line 116). The Superwall fix itself (AuthViewModel + HomeView) is already shipped as `0e59bf3` and pushed to main. CLAUDE.md is intentionally NOT touched — the rule was re-routed from CLAUDE.md to superwall-campaigns SKILL.md so it only loads when relevant (avoids the DS2500 routing antipattern).
- **Ship 1.0.2 to App Store** — build 34 (1.0.2 + restorePurchases fix + Lesson 6/7) needs to be uploaded to ASC and submitted. Build 33 was the prior in-flight 1.0.2; with the new restorePurchases fix and HomeView re-render, build 34 supersedes it. Run `/ship-store` once edits are committed. Blocks: mom's missing-lesson resolution and Test-Mode-era pro users' regression fix from rolling out.
- **`/ship-store` Phase 3 device smoke test** — verify on iPhone 16 Pro: onboarding → lesson 1 → paywall → new Raves lesson at position 3 → Climbing Flirt at position 7 → Raves SPEAK step C triggers Explain. ALSO verify the new restorePurchases path: sign in fresh, confirm pro state appears within ~2s without manual restore tap. Notion task: `349afe0dcf038050a308ef447b3c6733`.

## Today's resolved diagnoses (closed in Notion)
- **Terri Chamberlin's pro regression** — root cause identified, fix shipped (`0e59bf3`), manual entitlement granted. Pro restored. Notion: `34eafe0d-cf03-807c-afcb-d40b7db8147d` (closed).
- **Matt Chamberlin (dad) same regression** — same diagnosis + manual grant. Pro restored.
- **Mom's missing lessons** — confirmed expected (Lesson 6/7 added Apr 23, after build 32 uploaded Apr 21). Resolves on 1.0.2 ship. Notion: `34eafe0d-cf03-80f9-8001-d3b1b9092bed` (closed).
- **Verification task** — closed; entry in `~/.claude/skills/anti-patterns.md` "superwall-subscription-inactive-after-update". Notion: `34fafe0d-cf03-8142-aa90-c04f08a8598a` (closed).

## Context for next session
- 1.0.1 (build 32) still **READY_FOR_SALE** on App Store. 1.0.2 still PREPARE_FOR_SUBMISSION (no build attached yet via ASC API).
- Local HEAD = `0e59bf3` on `main`, pushed.
- Still uncommitted: `CLAUDE.md`, `.claude/skills/mixpanel-taxonomy/SKILL.md` (this session's /update-skill output).
- Marketing version 1.0.2 / build 34 is in pbxproj. Next ship needs to bump build to 35 (App Store Connect requires unique build numbers per upload).
- **Creator positioning locked** — `references/creator-positioning.md`. Use the 4-question decision filter before posting reels.

## Passive monitoring
- **First real subscription webhook** — `SELECT app_user_id, event_type, received_at FROM user_subscription_events ORDER BY received_at DESC LIMIT 10;` — plain UUID = fix live; `$SuperwallAlias:*` = regression.
- **`lesson_write_skipped` event volume** — phantom UUID monitoring still in place.

## Next Up
- **Commit + push** the two uncommitted edits with intent line.
- **Ship 1.0.2 build 34 (or 35)** to App Store via `/ship-store`.
- **Write + shoot 5 reels** — `content/reel-scripts/2026-04-21-batch.md`. Scripting IS the positioning work.
- Read Notion: `https://www.notion.so/jchamberlin/Post-content-fixes-funnel-retention-improvements-revisit-after-first-content-driven-install-wav-34cafe0dcf0380328120d5dff8c0b506`
- **Once 1.0.2 is approved + released:** update on phone → verify new lessons render → monitor Mixpanel for `lesson_started` on lesson-6 and lesson-7.
- **Mixpanel internal-user filter — manual follow-up:** add annotation "App Store 1.0.2 launch — restorePurchases fix + new lessons"; wait for Lexicon to index `is_internal` / `build_type`, then create "Real users" cohort.
- **Lesson UX: sticky "See why" button** — pin to bottom of screen after correct answer.
- **Reddit Seeding Launch** — Notion task `33dafe0d-cf03-8108-9c31-d3cdfea75a23`.
- **AI UGC Tool Test** — Notion task `33dafe0d-cf03-8162-826b-ddced947353e`.
- **Push notifications — GATED on >20 premium users.** Notion task `34bafe0d-cf03-8025-953d-f766b78054e2`.

## Parked
- **Chloe (Session 19) / lesson overhaul** — `user-research/transcripts/19_inperson_chloe.md`. "No single right answer" (3/3 ICP-female). Trigger to revisit: monthly review, OR a paying ICP-female churns citing this.
- **Phantom UUID auth investigation** — defensive guard live in `LessonProgressService`. Trigger: `lesson_write_skipped` >5/day sustained, paying user reports broken progress, or monthly review.

## Blockers
- None. Ship 1.0.2 is the next non-content critical-path action; reels are the binding-constraint action.
