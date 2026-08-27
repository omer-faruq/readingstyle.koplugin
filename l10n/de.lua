--[[--
German translations for the Reading style plugin.

Keys are the English msgids exactly as they appear in the source; anything not
listed here falls back to the English text through readingstyle_gettext.

Regenerate the key list with:
    luajit l10n/tools/extract.lua *.lua > l10n/template.lua
and check this file against it with:
    luajit l10n/tools/validate.lua l10n/template.lua l10n/de.lua
--]]

return {
    ["\"Fit to text width\" only shrinks images that are too wide. \"Fit to page width\" also enlarges smaller ones, which can stretch images that carry explicit pixel dimensions."] =
        "\"An Textbreite anpassen\" verkleinert nur zu breite Bilder. \"An Seitenbreite anpassen\" vergrößert auch kleinere, was Bilder mit fest angegebenen Pixelmaßen verzerren kann.",
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nThe language comes from the book's own metadata. When a book declares none this is greyed out, but you can give it one yourself: Book information, hold the language field, and set it. Reopen the book afterwards."] =
        "Ein eigener Stil für Bücher in dieser Sprache — nützlich, wenn sich eine Sprache mit anderen Absatzkonventionen besser liest.\n\nDie Sprache stammt aus den Metadaten des Buches. Gibt ein Buch keine an, ist dies ausgegraut; Sie können aber selbst eine setzen: Buchinformationen, das Sprachfeld gedrückt halten und eintragen. Danach das Buch neu öffnen.",
    ["A style stored with this book alone.\n\nSwitching between these three only changes which one you are editing and which one this book uses. The others keep their settings."] =
        "Ein Stil, der nur bei diesem Buch gespeichert wird.\n\nDas Umschalten zwischen diesen dreien ändert nur, welchen Sie gerade bearbeiten und welchen dieses Buch verwendet. Die anderen behalten ihre Einstellungen.",
    ["A thin line under chapter titles, in the manner of an older printed book."] =
        "Eine dünne Linie unter Kapitelüberschriften, wie in einem älteren gedruckten Buch.",
    ["About reading style and style tweaks"] =
        "Über Lesestil und Stil-Anpassungen",
    ["Advanced"] =
        "Erweitert",
    ["After"] =
        "Nachher",
    ["Align"] =
        "Ausricht.",
    ["Aligning images turns them into blocks, which pulls inline images — drop caps, small icons inside a line of text — out of their line. Leave at book default unless you need it."] =
        "Bilder auszurichten macht sie zu Blöcken, wodurch Bilder im Textfluss — Initialen, kleine Symbole innerhalb einer Zeile — aus ihrer Zeile gerissen werden. Auf Buchvorgabe lassen, sofern nicht benötigt.",
    ["Alignment of body text, paragraphs and list items. Headings keep their own alignment setting."] =
        "Ausrichtung von Fließtext, Absätzen und Listenpunkten. Überschriften behalten ihre eigene Ausrichtung.",
    ["Alignment of headings. Applies to all six heading levels, so a centred chapter title does not sit above left-aligned sub-headings."] =
        "Ausrichtung der Überschriften. Gilt für alle sechs Überschriftenebenen, damit eine zentrierte Kapitelüberschrift nicht über linksbündigen Zwischenüberschriften steht.",
    ["All books"] =
        "Alle Bücher",
    ["Applies to h1, h2 and h3 headings.\n\nBooks that do not mark their chapter titles as real headings — a styled paragraph inside a container, say — cannot be reached by any of these settings."] =
        "Gilt für Überschriften h1, h2 und h3.\n\nBücher, die ihre Kapitelüberschriften nicht als echte Überschriften auszeichnen — etwa als formatierten Absatz in einem Container —, lassen sich mit keiner dieser Einstellungen erreichen.",
    ["Apply"] =
        "Anwenden",
    ["Apply changes immediately"] =
        "Änderungen sofort anwenden",
    ["Apply now"] =
        "Jetzt anwenden",
    ["Apply to: %1"] =
        "Anwenden auf: %1",
    ["Applying this will reload the book."] =
        "Beim Anwenden wird das Buch neu geladen.",
    ["Avoid widows and orphans"] =
        "Hurenkinder und Schusterjungen vermeiden",
    ["Before"] =
        "Vorher",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Leerzeile zwischen Absätzen, kein Einzug, großzügiger Zeilenabstand und breite Ränder. Schont müde Augen.",
    ["Block quotes"] =
        "Blockzitate",
    ["Bold"] =
        "Fett",
    ["Bold instead of italic"] =
        "Fett statt kursiv",
    ["Book default"] =
        "Buchvorgabe",
    ["Books in %1"] =
        "Bücher auf %1",
    ["Books in this language"] =
        "Bücher in dieser Sprache",
    ["Bottom margin"] =
        "Unterer Rand",
    ["Cancel"] =
        "Abbrechen",
    ["Caps every image at the width and height of the page, so oversized images no longer spill past the margins."] =
        "Begrenzt jedes Bild auf Breite und Höhe der Seite, sodass übergroße Bilder nicht mehr über die Ränder hinauslaufen.",
    ["Centered"] =
        "Zentriert",
    ["Chapter"] =
        "Kapitel",
    ["Chapter title alignment"] =
        "Ausrichtung der Kapitelüberschrift",
    ["Chapter title size"] =
        "Größe der Kapitelüberschrift",
    ["Chapter title style"] =
        "Stil der Kapitelüberschrift",
    ["Chapters"] =
        "Kapitel",
    ["Clears every reading style setting and lets the book look the way its publisher intended."] =
        "Löscht alle Lesestil-Einstellungen und lässt das Buch so aussehen, wie es der Verlag vorgesehen hat.",
    ["Clears tinted boxes and page backgrounds. On a greyscale screen these become flat grey blocks that make the text on them harder to read."] =
        "Entfernt farbige Kästen und Seitenhintergründe. Auf einem Graustufenbildschirm werden daraus flache graue Flächen, die den Text darauf schlechter lesbar machen.",
    ["Close"] =
        "Schließen",
    ["Compact"] =
        "Kompakt",
    ["Could not write the file: %1"] =
        "Datei konnte nicht geschrieben werden: %1",
    ["Current style: %1"] =
        "Aktueller Stil: %1",
    ["Custom (%1)"] =
        "Angepasst (%1)",
    ["Custom CSS"] =
        "Eigenes CSS",
    ["Custom CSS (%1 characters)"] =
        "Eigenes CSS (%1 Zeichen)",
    ["Custom CSS applied"] =
        "Eigenes CSS angewendet",
    ["Cycle reading style presets"] =
        "Lesestil-Voreinstellungen durchschalten",
    ["Delete"] =
        "Löschen",
    ["Delete the %1 style"] =
        "Stil für %1 löschen",
    ["Delete the style for this language"] =
        "Stil für diese Sprache löschen",
    ["Delete the style stored at that level?"] =
        "Den auf dieser Ebene gespeicherten Stil löschen?",
    ["Delete this book's style"] =
        "Stil dieses Buches löschen",
    ["Deletes the style stored at that level. Editing moves to the next level up, and its style takes over."] =
        "Löscht den auf dieser Ebene gespeicherten Stil. Bearbeitet wird dann eine Ebene höher, deren Stil übernimmt.",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "Rückt die erste Zeile des Absatzes nach einer Überschrift nicht ein, wie es typografisch üblich ist.\n\nErreicht nur Absätze, die unmittelbar auf die Überschrift folgen. Bücher, die den Kapitelanfang in einen Container packen, sind nicht erreichbar.",
    ["Draws the page you are on with these settings in a separate process, and shows it to you before anything happens to the book.\n\nThe book itself is not re-rendered and nothing is saved unless you choose \"Apply\" there, so looking costs nothing."] =
        "Zeichnet die aktuelle Seite mit diesen Einstellungen in einem eigenen Prozess und zeigt sie Ihnen, bevor am Buch etwas geschieht.\n\nDas Buch selbst wird nicht neu gerendert und nichts wird gespeichert, solange Sie dort nicht »Anwenden« wählen; Hinschauen kostet also nichts.",
    ["E-reader"] =
        "E-Reader",
    ["Edit this book's own tweak"] =
        "Buchspezifische Anpassung bearbeiten",
    ["Emphasis"] =
        "Hervorhebung",
    ["Exactly what this plugin is appending to your stylesheet right now. Worth pasting into a bug report."] =
        "Genau das, was dieses Plugin gerade an Ihr Stylesheet anhängt. Gehört in einen Fehlerbericht.",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Zusätzlicher Abstand zwischen einzelnen Buchstaben. Kleine Werte können die Lesbarkeit verbessern; über etwa 0,1 em wirkt der Text gedehnt.",
    ["First paragraph after a heading"] =
        "Erster Absatz nach einer Überschrift",
    ["Fit to page width"] =
        "An Seitenbreite anpassen",
    ["Fit to text width"] =
        "An Textbreite anpassen",
    ["Font weight"] =
        "Schriftstärke",
    ["Footnote markers and cross-references are usually blue, which renders as a mid grey."] =
        "Fußnotenzeichen und Querverweise sind meist blau, was als mittleres Grau erscheint.",
    ["Force a page break before each chapter title, the way a printed book does.\n\nChoosing H1 and H2 also keeps a subtitle from starting a second page of its own."] =
        "Erzwingt vor jeder Kapitelüberschrift einen Seitenumbruch, so wie es ein gedrucktes Buch macht.\n\nMit H1 und H2 beginnt außerdem ein Untertitel keine eigene zweite Seite.",
    ["Force black text"] =
        "Schwarzen Text erzwingen",
    ["Full page"] =
        "Ganze Seite",
    ["H1 and H2"] =
        "H1 und H2",
    ["H1 only"] =
        "Nur H1",
    ["H1, H2 and H3"] =
        "H1, H2 und H3",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "Von Hand geschriebenes CSS, das hinter allem angehängt wird, was die Regler oben erzeugen, und deshalb immer gewinnt. Es folgt dem Bereich, den Sie gerade bearbeiten, genau wie die anderen Einstellungen.",
    ["Header and footer"] =
        "Kopf- und Fußzeile",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Höhe jeder Zeile in Prozent. Das ist KOReaders eigene Zeilenabstands-Einstellung, dieselbe wie im unteren Menü.",
    ["Hide images"] =
        "Bilder ausblenden",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Waagerechte Seitenränder. Sie bestimmen die Breite der Textspalte: breitere Ränder ergeben eine schmalere, leichter zu erfassende Zeile.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "Wie weit die erste Zeile jedes Absatzes eingerückt wird. Entfernt außerdem den Einzug, der von Containern, Überschriften, Listenpunkten und Tabellenzellen geerbt wird — daher kommen doppelte Einzüge.",
    ["How quoted passages are set apart from the body text. \"No special treatment\" clears the publisher's own indentation and italics instead of adding to them."] =
        "Wie zitierte Passagen vom Fließtext abgesetzt werden. \"Keine Sonderbehandlung\" entfernt Einzug und Kursivsatz des Verlags, statt etwas hinzuzufügen.",
    ["Image alignment"] =
        "Bildausrichtung",
    ["Image width"] =
        "Bildbreite",
    ["Images"] =
        "Bilder",
    ["Indent"] =
        "Einzug",
    ["Indented"] =
        "Eingerückt",
    ["Indented and italic"] =
        "Eingerückt und kursiv",
    ["Ink and links"] =
        "Farbe und Links",
    ["Inside the preview you can go on changing settings and turning pages: everything you change there is held until you apply it."] =
        "In der Vorschau können Sie weiter Einstellungen ändern und Seiten umblättern: Alles, was Sie dort ändern, wird zurückgehalten, bis Sie es anwenden.",
    ["Italic"] =
        "Kursiv",
    ["Justified"] =
        "Blocksatz",
    ["KOReader's own typography rules, including hyphenation. The language chosen here decides which hyphenation dictionary is used, which is why it lives with the language setting rather than on its own."] =
        "KOReaders eigene Typografieregeln, einschließlich Silbentrennung. Die hier gewählte Sprache bestimmt, welches Trennwörterbuch verwendet wird — deshalb steht die Silbentrennung bei der Spracheinstellung und nicht für sich allein.",
    ["Lang: %1"] =
        "Sprache: %1",
    ["Left"] =
        "Links",
    ["Left and right margins"] =
        "Linker und rechter Rand",
    ["Lets preformatted blocks — code listings, terminal output — wrap instead of running off the edge of the page."] =
        "Lässt vorformatierte Blöcke — Codelistings, Terminalausgaben — umbrechen, statt über den Seitenrand hinauszulaufen.",
    ["Letter spacing"] =
        "Buchstabenabstand",
    ["Line"] =
        "Zeile",
    ["Line spacing"] =
        "Zeilenabstand",
    ["Links in black"] =
        "Links in Schwarz",
    ["Links without underline"] =
        "Links ohne Unterstreichung",
    ["Load reading style preset"] =
        "Lesestil-Voreinstellung laden",
    ["Makes the text heavier or lighter than the font's own weight. A small increase is the most effective answer to a font that prints faintly on e-ink.\n\nThis is KOReader's own font weight setting."] =
        "Macht den Text stärker oder feiner als die Schrift von sich aus ist. Eine kleine Erhöhung ist das wirksamste Mittel gegen eine Schrift, die auf E-Ink blass wirkt.\n\nDas ist KOReaders eigene Schriftstärken-Einstellung.",
    ["Margin presets"] =
        "Randvoreinstellungen",
    ["Narrow"] =
        "Schmal",
    ["Needs a font that can produce small capitals, or the reader's font will synthesise them and the result can look uneven."] =
        "Braucht eine Schrift mit echten Kapitälchen, sonst erzeugt die Schrift sie künstlich und das Ergebnis wirkt ungleichmäßig.",
    ["No indentation"] =
        "Kein Einzug",
    ["No space above"] =
        "Kein Abstand darüber",
    ["No special treatment"] =
        "Keine Sonderbehandlung",
    ["Normal"] =
        "Normal",
    ["Not available from inside a preview: that editor writes to the book itself, which a preview must not do."] =
        "In der Vorschau nicht verfügbar: Dieser Editor schreibt direkt in das Buch, was eine Vorschau nicht tun darf.",
    ["Nothing is being generated: every setting is at book default."] =
        "Es wird nichts erzeugt: alle Einstellungen stehen auf Buchvorgabe.",
    ["On H1"] =
        "Bei H1",
    ["On H1 and H2"] =
        "Bei H1 und H2",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "Erlaubt es, bei Blocksatzzeilen mit sehr großen Lücken den Überschuss stattdessen als Buchstabenabstand in die Wörter zu verteilen. Angabe in Prozent der Schriftgröße.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "An: Änderungen erscheinen sofort. Aus: Sie werden gesammelt und erst angewendet, wenn Sie \"Jetzt anwenden\" wählen.\n\nJede Anwendung rendert das Buch neu — das Ausschalten lohnt sich also, wenn Sie mehrere Einstellungen auf einmal ändern.",
    ["Only the settings this plugin owns travel with a language: indentation, spacing, alignment, chapter titles, images, custom CSS.\n\nLine spacing, margins and word spacing belong to KOReader, which stores them per book and has no notion of a language, so they stay where they are."] =
        "Mit einer Sprache wandern nur die Einstellungen, die diesem Plugin gehören: Einzug, Abstände, Ausrichtung, Kapitelüberschriften, Bilder, eigenes CSS.\n\nZeilenabstand, Ränder und Wortabstand gehören KOReader, das sie pro Buch speichert und keine Sprachen kennt — sie bleiben, wo sie sind.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "Öffnet KOReaders Editor für buchspezifische Stil-Anpassungen samt CSS-Vorschlägen und Formatierer. Diese Anpassung wird von KOReader getrennt von diesem Plugin gespeichert und vor diesen Einstellungen angewendet.",
    ["Original size"] =
        "Originalgröße",
    ["Overrides every colour the publisher chose, including the greys used for asides and captions, which print faintly on e-ink.\n\nAlso blackens borders."] =
        "Überschreibt jede Farbe, die der Verlag gewählt hat, auch die Grautöne für Randbemerkungen und Bildunterschriften, die auf E-Ink blass erscheinen.\n\nSchwärzt außerdem Rahmen.",
    ["Page layout"] =
        "Seitenlayout",
    ["Paragraph indentation"] =
        "Absatzeinzug",
    ["Paragraphs"] =
        "Absätze",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "Schlichte Regler für die Einstellungen, die bestimmen, wie ein Buch aussieht — Absatzeinzug und -abstand, Platz um Kapitelüberschriften, Ausrichtung, Ränder, Bilder — mit Voreinstellungen und Stilen je Buch oder je Sprache.\n\nBaut auf KOReaders Stil-Anpassungen auf, statt sie zu ersetzen: Alles, was auf \"Buchvorgabe\" steht, lässt Ihre Anpassungen und die Stile des Verlags unberührt.",
    ["Playground"] =
        "Spielwiese",
    ["Presets"] =
        "Voreinstellungen",
    ["Prettify"] =
        "Formatieren",
    ["Prevent images from overflowing the page"] =
        "Verhindern, dass Bilder über die Seite hinausragen",
    ["Preview is not available for this book."] =
        "Für dieses Buch ist keine Vorschau verfügbar.",
    ["Preview is not available on this device."] =
        "Auf diesem Gerät ist keine Vorschau verfügbar.",
    ["Preview: after"] =
        "Vorschau: nachher",
    ["Preview: before"] =
        "Vorschau: vorher",
    ["Preview: before | after"] =
        "Vorschau: vorher | nachher",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "Typografie gedruckter Bücher: eingerückte Absätze ohne Lücke dazwischen, zentrierte Kapitelüberschriften mit Platz darüber.",
    ["Publisher default"] =
        "Verlagsvorgabe",
    ["Puts everything this menu marks as changed back to default, at the level you are editing: this plugin's settings return to book default, and KOReader's own — line spacing, word spacing, font weight, margins — return to theirs.\n\nStyles stored at the other levels are not touched; deleting those is a separate action."] =
        "Setzt alles, was dieses Menü als geändert markiert, auf der Ebene zurück, die Sie gerade bearbeiten: die Einstellungen dieses Plugins auf Buchvorgabe, KOReaders eigene — Zeilenabstand, Wortabstand, Schriftstärke, Ränder — auf ihre Vorgaben.\n\nAuf anderen Ebenen gespeicherte Stile bleiben unberührt; die zu löschen ist eine eigene Aktion.",
    ["Quick style"] =
        "Schnellstil",
    ["Reading style"] =
        "Lesestil",
    ["Reading style: %1"] =
        "Lesestil: %1",
    ["Reduction"] =
        "Verringerung",
    ["Remove background colours"] =
        "Hintergrundfarben entfernen",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Entfernt den Absatzabstand über dem ersten Absatz nach einer Überschrift, sodass er direkt unter der Kapitelüberschrift steht.",
    ["Removes every image from the page, for reading a heavily illustrated book as plain text.\n\nCaptions stay, since they are ordinary text."] =
        "Entfernt jedes Bild von der Seite, um ein reich bebildertes Buch als reinen Text zu lesen.\n\nBildunterschriften bleiben, denn sie sind gewöhnlicher Text.",
    ["Rendering the book with the new style…\n\nThe book on screen is not being changed. This takes about as long as applying the style would."] =
        "Das Buch wird mit dem neuen Stil gerendert …\n\nDas Buch auf dem Bildschirm wird dabei nicht verändert. Es dauert etwa so lange wie das Anwenden des Stils.",
    ["Replace"] =
        "Ersetzen",
    ["Replaces italics with something else. Worth it when a book's italic face is thin or hard to read on screen."] =
        "Ersetzt Kursivsatz durch etwas anderes. Lohnt sich, wenn die kursive Schnittstelle eines Buches dünn oder am Bildschirm schwer lesbar ist.",
    ["Reset"] =
        "Zurücksetzen",
    ["Reset all four margins to their defaults?"] =
        "Alle vier Ränder auf ihre Vorgaben zurücksetzen?",
    ["Reset all reading style settings"] =
        "Alle Lesestil-Einstellungen zurücksetzen",
    ["Reset chapter settings"] =
        "Kapiteleinstellungen zurücksetzen",
    ["Reset every text setting in this section, including KOReader's own line spacing, word spacing, word expansion and font weight?"] =
        "Alle Texteinstellungen dieses Abschnitts zurücksetzen, einschließlich KOReaders eigenem Zeilenabstand, Wortabstand, Wortdehnung und Schriftstärke?",
    ["Reset image settings"] =
        "Bildeinstellungen zurücksetzen",
    ["Reset ink settings"] =
        "Farbeinstellungen zurücksetzen",
    ["Reset margins"] =
        "Ränder zurücksetzen",
    ["Reset paragraph settings"] =
        "Absatzeinstellungen zurücksetzen",
    ["Reset text settings"] =
        "Texteinstellungen zurücksetzen",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "Einstellungen der Kapitelüberschriften auf die Verlagsvorgaben zurücksetzen?",
    ["Reset the colour and link settings to the publisher's defaults?"] =
        "Farb- und Link-Einstellungen auf die Verlagsvorgaben zurücksetzen?",
    ["Reset the image settings to the publisher's defaults?"] =
        "Bildeinstellungen auf die Verlagsvorgaben zurücksetzen?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "Absatzeinstellungen auf die Verlagsvorgaben zurücksetzen?",
    ["Right"] =
        "Rechts",
    ["Rule under the title"] =
        "Linie unter der Überschrift",
    ["Save as a style tweak"] =
        "Als Stil-Anpassung speichern",
    ["Save current reading style as preset"] =
        "Aktuellen Lesestil als Voreinstellung speichern",
    ["Saved to %1\n\nIt appears under Style tweaks, in User style tweaks, once KOReader is restarted."] =
        "Gespeichert unter %1\n\nErscheint nach einem Neustart von KOReader unter Stil-Anpassungen bei den eigenen Stil-Anpassungen.",
    ["Scaling"] =
        "Skalierung",
    ["Settings"] =
        "Einstellungen",
    ["Show after"] =
        "Nachher zeigen",
    ["Show before"] =
        "Vorher zeigen",
    ["Shrinks footnote markers and the like, and stops them from stretching the line they sit on."] =
        "Verkleinert Fußnotenzeichen und Ähnliches und verhindert, dass sie die Zeile auseinanderziehen, in der sie stehen.",
    ["Side by side"] =
        "Nebeneinander",
    ["Side margins"] =
        "Seitenränder",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Größe der Kapitelüberschriften in Prozent des umgebenden Textes.\n\n",
    ["Small capitals"] =
        "Kapitälchen",
    ["Smaller sub- and superscript"] =
        "Kleinere Tief- und Hochstellung",
    ["Space after chapter title"] =
        "Abstand nach der Kapitelüberschrift",
    ["Space before chapter title"] =
        "Abstand vor der Kapitelüberschrift",
    ["Space below the text. The status bar, when shown at the bottom, takes its height from here."] =
        "Abstand unter dem Text. Die Statusleiste bezieht ihre Höhe von hier, wenn sie unten angezeigt wird.",
    ["Space between paragraphs"] =
        "Abstand zwischen Absätzen",
    ["Spacing"] =
        "Abstand",
    ["Spacious"] =
        "Großzügig",
    ["Start chapters on a new page"] =
        "Kapitel auf neuer Seite beginnen",
    ["Stop a paragraph from leaving a single line stranded at the top or bottom of a page.\n\nPages end less evenly as a result, and the page count shifts."] =
        "Verhindert, dass ein Absatz eine einzelne Zeile oben oder unten auf einer Seite zurücklässt.\n\nDadurch enden Seiten weniger gleichmäßig, und die Seitenzahl verschiebt sich.",
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "Zum Durchschalten tippen: Buchvorgabe, an, aus.\n\n\"Aus\" ist nicht dasselbe wie \"Buchvorgabe\": Es nimmt Überschriften aktiv die Fettschrift, die der Verlag gesetzt hat.",
    ["Text"] =
        "Text",
    ["Text alignment"] =
        "Textausrichtung",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "Das vertraute E-Reader-Bild: kein Einzug, eine kleine Lücke zwischen Absätzen, durchgehend maßvolle Abstände.",
    ["The preview could not be rendered on this device."] =
        "Die Vorschau konnte auf diesem Gerät nicht gerendert werden.",
    ["The preview did not produce a page."] =
        "Die Vorschau hat keine Seite geliefert.",
    ["The preview failed."] =
        "Die Vorschau ist fehlgeschlagen.",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "Die am häufigsten benutzten Einstellungen auf einem Bildschirm. Lässt sich auch per Geste öffnen.",
    ["The style you edit here is used for every book that has no style of its own."] =
        "Der hier bearbeitete Stil gilt für jedes Buch, das keinen eigenen Stil hat.",
    ["There is not enough free memory for a preview right now.\n\nA preview renders a second copy of the book in a separate process, which needs room. Closing other things, or reopening the book, usually frees enough."] =
        "Derzeit ist nicht genug freier Speicher für eine Vorschau vorhanden.\n\nEine Vorschau rendert eine zweite Kopie des Buches in einem eigenen Prozess und braucht dafür Platz. Anderes zu schließen oder das Buch neu zu öffnen schafft meist genug davon.",
    ["This book"] =
        "Dieses Buch",
    ["This book only"] =
        "Nur dieses Buch",
    ["This page has not been rendered yet."] =
        "Diese Seite wurde noch nicht gerendert.",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "Dieses Plugin schreibt ein kleines Stylesheet und hängt es hinter Ihre Stil-Anpassungen, sodass seine Einstellungen überall dort gewinnen, wo sich beide überschneiden.\n\nAlles, was auf \"Buchvorgabe\" steht, erzeugt überhaupt nichts und lässt Ihre Anpassungen und die Stile des Verlags unberührt.\n\nJede Änderung rendert das Buch neu. Das ist normal und macht KOReader bei jeder Stiländerung so.",
    ["This replaces the style already stored at that level with the settings you are looking at now.\n\nContinue?"] =
        "Dies ersetzt den auf dieser Ebene bereits gespeicherten Stil durch die Einstellungen, die Sie gerade sehen.\n\nFortfahren?",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "Enge Zeilen und schmale Ränder, kein Abstand zwischen Absätzen. Bringt den meisten Text auf eine Seite.",
    ["Top margin"] =
        "Oberer Rand",
    ["Traditional"] =
        "Traditionell",
    ["Try"] =
        "Testen",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "Zwei Zahlen, und nur die erste rückt Wörter auseinander.\n\nSkalierung ist die Breite jedes Leerzeichens, in Prozent des Leerzeichens der Schrift selbst. 100 % ist die natürliche Breite, KOReaders Vorgabe liegt bei 95 % — also etwas schmaler. Für größere Abstände über 100 % hinausgehen.\n\nVerringerung gibt an, wie weit der Blocksatz diese Leerzeichen wieder stauchen darf, um ein weiteres Wort in die Zeile zu bekommen. 100 % verbietet das Stauchen; erhöhen Sie den Wert also mit, sonst halten die größeren Abstände nicht.",
    ["Typography and hyphenation: %1"] =
        "Typografie und Silbentrennung: %1",
    ["Underlined instead of italic"] =
        "Unterstrichen statt kursiv",
    ["Uppercase"] =
        "Großbuchstaben",
    ["Use these settings for all books"] =
        "Diese Einstellungen für alle Bücher verwenden",
    ["Use these settings for all books in %1"] =
        "Diese Einstellungen für alle Bücher auf %1 verwenden",
    ["Use these settings for all books in this language"] =
        "Diese Einstellungen für alle Bücher in dieser Sprache verwenden",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Senkrechter Abstand zwischen Absätzen. Die Absatzabstände des Verlags werden zuerst entfernt, damit der gewählte Wert genau so wirkt und nicht obendrauf addiert wird.",
    ["View generated CSS"] =
        "Erzeugtes CSS ansehen",
    ["What counts as a chapter"] =
        "Was als Kapitel gilt",
    ["Which heading levels the settings below apply to.\n\nMost books mark chapters as H1, many use H2, and a few use H3. Including H3 in a book full of sub-headings will space out things that are not chapters at all.\n\nAlignment is deliberately left out of this: it always applies to every heading level."] =
        "Auf welche Überschriftenebenen die Einstellungen darunter wirken.\n\nDie meisten Bücher zeichnen Kapitel als H1 aus, viele nutzen H2, einige wenige H3. H3 mitzunehmen zieht in einem Buch voller Zwischenüberschriften Dinge auseinander, die gar keine Kapitel sind.\n\nDie Ausrichtung ist bewusst ausgenommen: sie gilt immer für alle Überschriftenebenen.",
    ["Whitespace above chapter and section titles, so a chapter does not start flush against the top of the page.\n\n"] =
        "Freiraum über Kapitel- und Abschnittsüberschriften, damit ein Kapitel nicht bündig am oberen Seitenrand beginnt.\n\n",
    ["Whitespace between a chapter title and the text that follows it.\n\n"] =
        "Freiraum zwischen einer Kapitelüberschrift und dem folgenden Text.\n\n",
    ["Wide"] =
        "Breit",
    ["Word expansion"] =
        "Wortdehnung",
    ["Word spacing"] =
        "Wortabstand",
    ["Wrap long code lines"] =
        "Lange Codezeilen umbrechen",
    ["Writes the generated CSS into KOReader's own user style tweaks folder, where it works without this plugin. A way out that does not cost you your settings."] =
        "Schreibt das erzeugte CSS in KOReaders eigenen Ordner für Stil-Anpassungen, wo es auch ohne dieses Plugin funktioniert. Ein Ausweg, der Sie Ihre Einstellungen nicht kostet.",
    ["book default"] =
        "Buchvorgabe",
    ["hyphenation off"] =
        "Silbentrennung aus",
    ["hyphenation on"] =
        "Silbentrennung an",
    ["off"] =
        "aus",
    ["on"] =
        "an",
    ["page %1 of %2"] =
        "Seite %1 von %2",
    ["style changes"] =
        "Stiländerungen",
}
