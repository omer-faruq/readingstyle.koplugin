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
| Paragraphs | Indentation, space between paragraphs, first paragraph after a heading (no indent / no space above) |
| Chapters | Space before and after the title, title size, alignment, bold / italic / uppercase |
| Text | Line spacing, alignment, letter spacing, word spacing, word expansion |
| Typography | KOReader's typography rules and hyphenation, borrowed whole |
| Page layout | Margin presets, left/right margins, top and bottom margins |
| Header and footer | KOReader's own status bar menu, borrowed whole |
| Images | Width, alignment, overflow protection |
| Advanced | Custom CSS, and a shortcut to this book's own style tweak |

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

KOReader's own settings — line spacing, word spacing, margins — are marked too,
against the default KOReader itself would star: your saved default if you ever
pressed "save as default", otherwise the built-in one. The marker there means
"this does not look default", not "this plugin changed it": the bottom config bar
writes the same settings and its changes show up here as well. They count towards
the style name for the same reason — a book whose line spacing was raised is not
showing publisher defaults, wherever that setting happens to be stored.

## Scopes

Under **Apply to**:

- **All books** — the default style, used by every book with nothing more specific.
- **Books in `<language>`** — a style for one book language. Only offered when
  the book declares one.
- **This book only** — stored with the book, overrides both.

Picking a narrower scope copies what you are looking at down into it, so nothing
changes on screen. Picking a broader one drops the narrower style and asks first
if that would lose settings.

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

## What it cannot do

Some honest limits, all of them inherent rather than unfinished:

- **Chapter settings only reach real headings** (`h1`–`h3`). Books that style a
  paragraph inside a container as their chapter title cannot be targeted by any
  selector without knowing that book's markup.
- **"First paragraph after a heading" needs the paragraph to be a direct
  sibling** of the heading. A wrapper element puts it out of reach.
- **There is no preview.** Showing the change *is* re-rendering, so preview and
  apply are the same operation.
- **No entry in the bottom config bar.** Those options come from
  `frontend/ui/data/creoptions.lua`, which is fixed when the reader starts and
  has no plugin hook. The main menu and a gesture are the ways in.

## Files

| File | Contents |
| --- | --- |
| `main.lua` | The module: the stylesheet hook, scopes, presets, events |
| `readingstyle_settings.lua` | Settings schema, validation, sanitising. Pure Lua |
| `readingstyle_css.lua` | Style table → CSS. Pure Lua |
| `readingstyle_presets.lua` | The built-in profiles |
| `readingstyle_menu.lua` | The menu tree |
| `readingstyle_quick.lua` | The quick style screen |
| `readingstyle_test.lua` | Tests for the three pure modules |
| `readingstyle_gettext.lua` | Drop-in gettext replacement that reads `l10n/` |
| `l10n/<code>.lua` | Translation tables |

The settings, CSS and preset modules have no KOReader dependencies beyond
gettext, so they run outside the reader:

```
luajit plugins/readingstyle.koplugin/readingstyle_test.lua
```

## Translations

KOReader's gettext only loads the core catalog, so a standalone plugin's strings
are never translated by it. `readingstyle_gettext.lua` is a drop-in replacement
that resolves each string against a bundled table first and falls back to the
English source.

Shipped: Turkish, German, French, Spanish, Brazilian Portuguese, Simplified
Chinese. A regional locale falls back to its base language file, so `de_DE` finds
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

The stylesheet hook is installed in `init()`, not in `onReadSettings()`, and that
matters. Plugins are registered at `readerui.lua:464`; the `ReadSettings` event
that builds the first stylesheet is only sent at `:484`. Injecting CSS after that
point changes the document's rendering hash, which starts `ReaderRolling`'s
rerender-and-reload machinery: the book closes and reopens half a minute later,
looking exactly like a crash. Getting in before the first render avoids it
entirely.
