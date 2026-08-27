# Reading style

A KOReader plugin that puts the settings which actually decide how a book looks
behind plain controls, instead of behind CSS.

It does not render anything itself. It builds a small stylesheet from your
choices and hands it to crengine through KOReader's existing style tweak
pipeline, and it drives KOReader's own document settings — line spacing, word
spacing, margins — through their normal events.

Found under **Style ▸ Reading style**, next to Style tweaks.

## What it controls

| Section | Settings |
| --- | --- |
| Paragraphs | Indentation, space between paragraphs, first paragraph after a heading, widow and orphan control, block quote style |
| Chapters | Which heading levels count as a chapter, space before and after the title, title size, alignment, bold / italic / uppercase / small capitals, a rule under the title, starting each chapter on a new page |
| Text | Line spacing, alignment, letter spacing, word spacing, word expansion, font weight, emphasis style, smaller sub- and superscript |
| Typography | KOReader's typography rules and hyphenation, borrowed whole |
| Page layout | Margin presets, left/right margins, top and bottom margins |
| Header and footer | KOReader's own status bar menu, borrowed whole |
| Ink and links | Force black text, remove background colours, black links, links without underline |
| Images | Width, alignment, overflow protection, hiding images entirely |
| Advanced | Wrapping long code lines, custom CSS, viewing the generated CSS, exporting it as a style tweak, and a shortcut to this book's own style tweak |

Plus presets, three scopes, and a quick style screen.

## The three-state contract

Every setting is either at **book default** — the plugin emits nothing for it,
and the publisher's styles and your own style tweaks apply untouched — or at a
value you chose. Numeric controls have a *Book default* button; enum controls
have a *Book default* entry at the top of the list.

This is why the plugin can be layered over Style tweaks without fighting it: it
only ever speaks about the settings you asked it about.

Where the two do overlap, this plugin wins — its stylesheet is appended after
the tweak CSS.

Anything you have moved off "book default" is marked with a `*`, and the marker
carries up to the section it lives in, so a changed setting can be found by
scanning the menu instead of opening every submenu. The top entry needs no
marker: it already names the current style rather than a default.

Reset covers exactly what the marker covers: a section's reset clears both the
plugin's own settings and the KOReader ones shown in that section, and **Reset
all reading style settings** puts the whole level back to default, so the style
name reads "Publisher default" afterwards rather than still counting something.

KOReader's own settings — line spacing, word spacing, margins — are marked too,
against the default KOReader itself would star: your saved default if you ever
pressed "save as default", otherwise the built-in one. The marker there means
"this does not look default", not "this plugin changed it": the bottom config bar
writes the same settings and its changes show up here as well. They count towards
the style name for the same reason — a book whose line spacing was raised is not
showing publisher defaults, wherever that setting happens to be stored.

## Scopes

Under **Apply to**:

- **All books** — the style used by every book that has nothing more specific.
- **Books in `<language>`** — a style for one book language, taken from the
  book's own metadata. Only offered when the book declares a language.
- **This book only** — stored with the book.

Which level a book reads from is recorded with the book, not inferred from which
styles happen to exist. Switching between the three only changes which one you
are editing and which one this book uses: **the levels you switch away from keep
their styles**, so a full round trip comes back to exactly where it started. A
level with nothing in it yet is seeded from what is on screen, so choosing a
scope never changes the page by itself.

Two things below the three choices do more than switch:

- **Use these settings for all books in `<language>` / for all books** — copies
  what you are looking at onto that level, overwriting what was there. This is
  how you answer "make this the default for Turkish" when a Turkish style
  already exists.
- **Delete this book's style / Delete the `<language>` style** — the only way to
  lose a style, and it asks first. Editing then moves to the next level up.

Only the settings this plugin owns travel with a language. Line spacing, margins
and word spacing belong to KOReader, which stores them per book and has no notion
of a language.

## Presets

Five built-in profiles — Publisher default, Compact, Traditional, Spacious,
E-reader — plus your own, saved from the current settings.

A preset captures **both halves**: this plugin's style settings and the KOReader
document settings it drives — line spacing, word spacing, word expansion and all
four margins — read straight from the document as they stand. Loading one
replaces the style outright, but only touches the KOReader settings the preset
actually names.

Presets can be bound to gestures through Dispatcher: *Load reading style preset*,
*Cycle reading style presets*, and *Reading style* to open the quick screen.

## Quick style

The four settings people reach for, on one screen, each on a `[−] [value] [+]`
row. Hold or tap the value for the full control, including *Book default*.

Every style change re-renders the book, so taps are batched: the label updates
immediately and the render happens once you stop tapping. **Apply changes
immediately** can be switched off in the menu, which collects changes until you
press *Apply now*.

## Playground

*Playground* (in the menu, and the *Try* button on the quick screen) opens the
page you are on, drawn with the settings you have made, before anything happens
to the book. It is a workbench rather than a confirmation dialog:

- **Keep changing settings.** *Settings* opens this plugin's whole menu on top
  of the preview. Everything you change there — including the quick screen, the
  presets and the scope — is held, and the preview redraws itself with it. The
  book is not touched.
- **Turn pages.** ◀ ▶ (or a swipe, or the page-turn keys) move through the
  book inside the preview, so you can check how the change lands around an
  image or a chapter heading rather than only where you happen to be sitting.
- **Then decide.** *Apply* puts everything you chose into the book in one go.
  *Cancel* leaves it exactly as it was — the book was never re-rendered, so
  there is nothing to undo.

Two ways to look at the page you opened it from:

- **Full page** (the default) flips between before and after in the same
  pixels. Side by side halves the width, and at half width a change in line
  spacing, word spacing or indentation is no longer legible — which is most of
  what this plugin does.
- **Side by side** is there for the questions the flip is bad at: margins,
  paragraph spacing, the room a chapter heading takes, whether an image still
  fits its page. Tap a half to bring it up to full size.

The other pages in the window are drawn with the new style only. *Show before*
and *Side by side* still work there: either one draws that page as it is now
first, which takes a moment and needs no rendering at all — the subprocess
inherits the book exactly as it stands. Turning a page while you are looking at
*before*, or at both halves, keeps you there: the page you turn to is drawn
that way too, rather than quietly reverting to the new style and labelling it
as though nothing had changed.

Drawing every page both ways up front is what a preview cannot afford, since it
doubles both the wait and the memory for a comparison that is mostly wanted
where you are standing. One fetched image is kept at a time.

Both views draw a thin frame around the page. The image is scaled down to leave
room for the title and the buttons, so without a line at its edge there is no
telling where the page stops and the screen starts — and that is exactly what
you are looking at when you are judging margins.

The **⤢ button in the title bar**, or a long press on the page, hides the title
and the buttons and shows the page at its real size. That is not just more
room: with nothing else on the screen the image is displayed at exactly 1:1, so
what you are looking at is what the book will be, pixel for pixel. A long press
brings the controls back, and so does the back key.

### How it can be safe

The page is rendered by a short-lived forked subprocess, the same thing
KOReader does for Book Map and Page Browser thumbnails. That process inherits
the book already rendered with the style in force, so the "before" image costs
it nothing — it draws that one first, then applies the candidate style,
re-renders, and draws the pages of the window at the same positions in the
text. Then it dies, having touched nothing: not the rendering hash, not the
book's saved settings, not crengine's cache.

One fork covers a window of pages either side of where you are, which is why
turning a page inside the preview is instant. Walking off the end of that
window, or changing a setting, starts another one.

Meanwhile the plugin itself is in a sandbox: style changes are not applied, and
KOReader's own document settings are remembered instead of being driven into
the document. That is the whole trick behind "change anything, nothing
happens": there is nothing to undo on cancel, because nothing was ever set.

### What it costs, and when it is refused

Rendering is not the wait. On an EPUB with multiple fragments the subprocess
takes the same shortcut the reader itself takes when you apply a change —
rendering only the chapter you are in — and that is measured in milliseconds.
What costs time is drawing each page and moving it across: a page image is one
to three megabytes and there are as many of them as the window is wide. So the
page you are on is drawn and sent first, and it is the only one drawn twice.

Memory is the other half of it, and the reason the playground counts before it
spends: KOReader's own background renderer measures a second render of a big
book at around 60 MB, and every page image on top of that is another one to
three megabytes.

So the preview counts before it spends. It reads what the device has free,
reserves room for the render, and sizes its window of pages from what is left —
between one and four pages. If there is not even room for one, it says so
instead of trying: a device that refuses a preview still works normally, and
that is a much better outcome than taking the reader down with it.

Two things follow from the same arithmetic:

- **The window is small on small devices.** One render covers a window of
  pages — one behind and up to four ahead, fewer when memory is tight or the
  screen is large. Turning inside that window is instant; turning past its edge
  starts another render, and costs that wait again.
- **Pixels never become Lua strings.** Each image is written straight out of
  one blitbuffer and read straight into another. Serializing them instead
  costs four copies of every image, all of them garbage-collected — which on a
  small device is exactly what runs it out of memory.

Cancelling during the render kills the subprocess.

### What it cannot hold

Three settings in the menu are borrowed whole from other KOReader modules —
**typography and hyphenation**, **header and footer**, and **this book's own
style tweak**. They drive the live book directly and cannot be held back, so
they are not offered from inside a preview.

If the fork fails — or the book is not a crengine document — the menu item is
simply not offered.

## What it cannot do

Some honest limits, all of them inherent rather than unfinished:

- **Chapter settings only reach real headings** (`h1`–`h3`). Books that style a
  paragraph inside a container as their chapter title cannot be targeted by any
  selector without knowing that book's markup.
- **"First paragraph after a heading" needs the paragraph to be a direct
  sibling** of the heading. A wrapper element puts it out of reach.
- **The live page cannot show a change without applying it.** In the open
  document, showing the change *is* re-rendering it. The preview below gets
  around this by drawing the page in a separate process, not by finding a way
  to do it here.
- **No entry in the bottom config bar.** Those options come from
  `frontend/ui/data/creoptions.lua`, which is fixed when the reader starts and
  has no plugin hook. The main menu and a gesture are the ways in.
- **No contrast setting.** KOReader stores font gamma as an index into a gamma
  table rather than a value, which the engine-setting model here cannot express.
  It stays in KOReader's own menu.
- **Small capitals depend on the font.** A font without real small capitals will
  have them synthesised, and the result can look uneven.

If you want to see exactly what the plugin is doing to a book, **Advanced ▸ View
generated CSS** prints it. **Save as a style tweak** writes it into KOReader's own
user style tweaks folder, where it keeps working without the plugin.

## Files

| File | Contents |
| --- | --- |
| `main.lua` | The module: the stylesheet hook, scopes, presets, events |
| `readingstyle_settings.lua` | Settings schema, validation, sanitising. Pure Lua |
| `readingstyle_css.lua` | Style table → CSS. Pure Lua |
| `readingstyle_presets.lua` | The built-in profiles |
| `readingstyle_menu.lua` | The menu tree |
| `readingstyle_quick.lua` | The quick style screen |
| `readingstyle_sandbox.lua` | What a preview holds back, and what cancelling restores. Pure Lua |
| `readingstyle_preview.lua` | The preview: the fork, and the pipe it talks over |
| `readingstyle_preview_protocol.lua` | Record framing and preview arithmetic. Pure Lua |
| `readingstyle_preview_view.lua` | The preview screen |
| `readingstyle_test.lua` | Tests for the pure modules |
| `readingstyle_gettext.lua` | Drop-in gettext replacement that reads `l10n/` |
| `l10n/<code>.lua` | Translation tables |

The settings, CSS, preset, sandbox and preview-protocol modules have no
KOReader dependencies beyond gettext, so they run outside the reader:

```
luajit plugins/readingstyle.koplugin/readingstyle_test.lua
```

## Translations

KOReader's gettext only loads the core catalog, so a standalone plugin's strings
are never translated by it. `readingstyle_gettext.lua` is a drop-in replacement
that resolves each string against a bundled table first and falls back to the
English source.

Shipped: Turkish, German, French, Spanish, Brazilian Portuguese, Simplified
Chinese — 194 strings each, checked by `validate.lua`. A regional locale falls back to its base language file, so `de_DE` finds
`de.lua`.

To add one, drop `l10n/<code>.lua` next to the others — the code matches
KOReader's locale directories. To refresh the key list after changing any string:

```
luajit l10n/tools/extract.lua *.lua > l10n/template.lua
luajit l10n/tools/validate.lua l10n/template.lua l10n/tr.lua
```

`validate.lua` reports missing keys, stale ones and any translation whose
placeholders do not match the source.

## A note on timing

Two orderings in `readerui.lua` decide where this plugin's code has to live, and
they pull in opposite directions.

**The stylesheet hook goes in `init()`**, not in `onReadSettings()`. Plugins are registered at `readerui.lua:464`; the `ReadSettings` event
that builds the first stylesheet is only sent at `:484`. Injecting CSS after that
point changes the document's rendering hash, which starts `ReaderRolling`'s
rerender-and-reload machinery: the book closes and reopens half a minute later,
looking exactly like a crash. Getting in before the first render avoids it
entirely.

**The book's language cannot be read there.** `loadDocument()` is deferred into a
postInitCallback (`readerui.lua:331-333`) that only runs at `:486` — after the
plugins and after `ReadSettings`. At `init()` the crengine document exists but has
not been parsed, so its metadata is empty and every book looks as though it
declares no language. So `init()` uses the metadata KOReader cached on the
previous open, and `onPreRenderDocument` — documented at `:338-340` as the place
for settings that need the loaded document — asks the document itself. That is
also the last moment the stylesheet can change for free, since `ReaderRolling`
records the rendering hash in a later callback.
