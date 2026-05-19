# Pregnant Tracker - Baby Bump — Navigation Map

## Bottom Navigation (ShellRoute)
- Home (/) — Main dashboard with pregnancy week, mood check-in, quick actions [tab: home icon]
- Browse (/browse) — Discovery hub for cycle tracking and weight management [tab: search icon]
- Library (/library) — Health log, mood wellness, and education resources [tab: bookmark icon]
- Profile (/profile) — Mindfulness, settings, and personal profile [tab: person icon]

## Push Routes (detail screens)
- Cycle Tracking (/cycle-tracking) <- tap from Browse tab
- Weight & Nutrition (/weight-nutrition) <- tap from Browse tab
- Pregnancy Progress (/pregnancy-progress) <- tap from Home tab
- Mindfulness (/mindfulness) <- tap from Profile tab
- Health Log (/health-log) <- tap from Library tab
- Mood & Wellness (/mood-wellness) <- tap from Library tab
- Education (/education) <- tap from Library tab
- Article Reader (/article-reader/:id) <- tap article from Education
- Settings (/settings) <- tap from Profile tab

## Modal Overlays (bottom sheets & dialogs)
- Breathing Exercise (overlay:breathing-exercise) — Full-screen animated breathing exercise
- Stretching Guide (overlay:stretching-guide) — Bottom sheet with step-by-step stretching instructions
- Mode Selector (overlay:mode-selector) — Bottom sheet for mode selection on Home
- Symptom Detail (overlay:symptom-detail) — Bottom sheet for viewing/editing symptom details