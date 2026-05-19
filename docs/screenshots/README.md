# Screenshots

All 13 screens, captured from the generated Flutter app running in Chrome at viewport **430×2400** logical pixels (× DPR 2 → 860×4800 PNG before trim). The viewport width matches iPhone 16 Pro Max so Material 3 breakpoints render the mobile layout; the height is exaggerated so scrollable Flutter content (Home's Quick Actions, the article reader, the pregnancy progress detail) fits in one shot without clipping.

After capture, [`scripts/trim-screenshots.mjs`](../../scripts/trim-screenshots.mjs) trims the trailing whitespace and (for screens with a sticky bottom navigation bar that floats at viewport-end with empty space between it and the body) stitches body + nav together with a 24px band. That's why some PNGs are short (Browse: 860×504) and others long (Article reader: 860×2988) — the height reflects actual content, not the capture viewport.

| Order | Route | Screen | File |
| ---: | :--- | :--- | :--- |
| 01 | `/`                       | Home — week tracker + mood + checklist | [`01-home.png`](./01-home.png) |
| 02 | `/browse`                 | Browse — feature index               | [`02-browse.png`](./02-browse.png) |
| 03 | `/library`                | Library — saved articles             | [`03-library.png`](./03-library.png) |
| 04 | `/profile`                | Profile                              | [`04-profile.png`](./04-profile.png) |
| 05 | `/cycle-tracking`         | Cycle tracking                       | [`05-cycle-tracking.png`](./05-cycle-tracking.png) |
| 06 | `/weight-nutrition`       | Weight & nutrition (chart)           | [`06-weight-nutrition.png`](./06-weight-nutrition.png) |
| 07 | `/pregnancy-progress`     | Pregnancy progress (week N detail)   | [`07-pregnancy-progress.png`](./07-pregnancy-progress.png) |
| 08 | `/mindfulness`            | Mindfulness — exercises              | [`08-mindfulness.png`](./08-mindfulness.png) |
| 09 | `/health-log`             | Health log                           | [`09-health-log.png`](./09-health-log.png) |
| 10 | `/mood-wellness`          | Mood & wellness                      | [`10-mood-wellness.png`](./10-mood-wellness.png) |
| 11 | `/education`              | Education — article cards            | [`11-education.png`](./11-education.png) |
| 12 | `/article-reader/sample`  | Article reader                       | [`12-article-reader.png`](./12-article-reader.png) |
| 13 | `/settings`               | Settings                             | [`13-settings.png`](./13-settings.png) |

## How these were taken

```bash
flutter build web --release
./scripts/capture-screenshots.sh    # builds web, serves on :8765, walks each go_router URL hash via headless Chrome
```

### Why web, not the iOS simulator?

Xcode 26 (the current stable) ships expecting iOS 26.x simulator runtimes, but most dev machines still have iOS 18.x runtimes pre-installed. `flutter run -d ios` fails on the version mismatch without manually downloading the matching runtime via Xcode → Settings → Components.

Flutter's web renderer uses the same widget tree and the same layout engine as the mobile renderers — the screenshots fairly represent what the app looks like on a phone.

If you have a working iOS or Android emulator, you can render those instead — every route is reachable via the bottom nav and the cards on each screen.
