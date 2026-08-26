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
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nUnavailable when the book does not declare a language."] =
        "Ein eigener Stil für Bücher in dieser Sprache — nützlich, wenn sich eine Sprache mit anderen Absatzkonventionen besser liest.\n\nNicht verfügbar, wenn das Buch keine Sprache angibt.",
    ["A style stored with this book alone. It overrides both of the above."] =
        "Ein Stil, der nur bei diesem Buch gespeichert wird. Er hat Vorrang vor beiden obigen.",
    ["About reading style and style tweaks"] =
        "Über Lesestil und Stil-Anpassungen",
    ["Advanced"] =
        "Erweitert",
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
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Leerzeile zwischen Absätzen, kein Einzug, großzügiger Zeilenabstand und breite Ränder. Schont müde Augen.",
    ["Bold"] =
        "Fett",
    ["Book default"] =
        "Buchvorgabe",
    ["Books in %1"] =
        "Bücher auf %1",
    ["Books in this language"] =
        "Bücher in dieser Sprache",
    ["Bottom margin"] =
        "Unterer Rand",
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
    ["Close"] =
        "Schließen",
    ["Compact"] =
        "Kompakt",
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
    ["Discard"] =
        "Verwerfen",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "Rückt die erste Zeile des Absatzes nach einer Überschrift nicht ein, wie es typografisch üblich ist.\n\nErreicht nur Absätze, die unmittelbar auf die Überschrift folgen. Bücher, die den Kapitelanfang in einen Container packen, sind nicht erreichbar.",
    ["E-reader"] =
        "E-Reader",
    ["Edit this book's own tweak"] =
        "Buchspezifische Anpassung bearbeiten",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Zusätzlicher Abstand zwischen einzelnen Buchstaben. Kleine Werte können die Lesbarkeit verbessern; über etwa 0,1 em wirkt der Text gedehnt.",
    ["First paragraph after a heading"] =
        "Erster Absatz nach einer Überschrift",
    ["Fit to page width"] =
        "An Seitenbreite anpassen",
    ["Fit to text width"] =
        "An Textbreite anpassen",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "Von Hand geschriebenes CSS, das hinter allem angehängt wird, was die Regler oben erzeugen, und deshalb immer gewinnt. Es folgt dem Bereich, den Sie gerade bearbeiten, genau wie die anderen Einstellungen.",
    ["Header and footer"] =
        "Kopf- und Fußzeile",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Höhe jeder Zeile in Prozent. Das ist KOReaders eigene Zeilenabstands-Einstellung, dieselbe wie im unteren Menü.",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Waagerechte Seitenränder. Sie bestimmen die Breite der Textspalte: breitere Ränder ergeben eine schmalere, leichter zu erfassende Zeile.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "Wie weit die erste Zeile jedes Absatzes eingerückt wird. Entfernt außerdem den Einzug, der von Containern, Überschriften, Listenpunkten und Tabellenzellen geerbt wird — daher kommen doppelte Einzüge.",
    ["Image alignment"] =
        "Bildausrichtung",
    ["Image width"] =
        "Bildbreite",
    ["Images"] =
        "Bilder",
    ["Indent"] =
        "Einzug",
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
    ["Letter spacing"] =
        "Buchstabenabstand",
    ["Line"] =
        "Zeile",
    ["Line spacing"] =
        "Zeilenabstand",
    ["Load reading style preset"] =
        "Lesestil-Voreinstellung laden",
    ["Margin presets"] =
        "Randvoreinstellungen",
    ["Narrow"] =
        "Schmal",
    ["No indentation"] =
        "Kein Einzug",
    ["No space above"] =
        "Kein Abstand darüber",
    ["Normal"] =
        "Normal",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "Erlaubt es, bei Blocksatzzeilen mit sehr großen Lücken den Überschuss stattdessen als Buchstabenabstand in die Wörter zu verteilen. Angabe in Prozent der Schriftgröße.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "An: Änderungen erscheinen sofort. Aus: Sie werden gesammelt und erst angewendet, wenn Sie \"Jetzt anwenden\" wählen.\n\nJede Anwendung rendert das Buch neu — das Ausschalten lohnt sich also, wenn Sie mehrere Einstellungen auf einmal ändern.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "Öffnet KOReaders Editor für buchspezifische Stil-Anpassungen samt CSS-Vorschlägen und Formatierer. Diese Anpassung wird von KOReader getrennt von diesem Plugin gespeichert und vor diesen Einstellungen angewendet.",
    ["Original size"] =
        "Originalgröße",
    ["Page layout"] =
        "Seitenlayout",
    ["Paragraph indentation"] =
        "Absatzeinzug",
    ["Paragraphs"] =
        "Absätze",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "Schlichte Regler für die Einstellungen, die bestimmen, wie ein Buch aussieht — Absatzeinzug und -abstand, Platz um Kapitelüberschriften, Ausrichtung, Ränder, Bilder — mit Voreinstellungen und Stilen je Buch oder je Sprache.\n\nBaut auf KOReaders Stil-Anpassungen auf, statt sie zu ersetzen: Alles, was auf \"Buchvorgabe\" steht, lässt Ihre Anpassungen und die Stile des Verlags unberührt.",
    ["Presets"] =
        "Voreinstellungen",
    ["Prettify"] =
        "Formatieren",
    ["Prevent images from overflowing the page"] =
        "Verhindern, dass Bilder über die Seite hinausragen",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "Typografie gedruckter Bücher: eingerückte Absätze ohne Lücke dazwischen, zentrierte Kapitelüberschriften mit Platz darüber.",
    ["Publisher default"] =
        "Verlagsvorgabe",
    ["Quick style"] =
        "Schnellstil",
    ["Reading style"] =
        "Lesestil",
    ["Reading style: %1"] =
        "Lesestil: %1",
    ["Reduction"] =
        "Verringerung",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Entfernt den Absatzabstand über dem ersten Absatz nach einer Überschrift, sodass er direkt unter der Kapitelüberschrift steht.",
    ["Reset"] =
        "Zurücksetzen",
    ["Reset all reading style settings"] =
        "Alle Lesestil-Einstellungen zurücksetzen",
    ["Reset chapter settings"] =
        "Kapiteleinstellungen zurücksetzen",
    ["Reset image settings"] =
        "Bildeinstellungen zurücksetzen",
    ["Reset paragraph settings"] =
        "Absatzeinstellungen zurücksetzen",
    ["Reset text settings"] =
        "Texteinstellungen zurücksetzen",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "Einstellungen der Kapitelüberschriften auf die Verlagsvorgaben zurücksetzen?",
    ["Reset the image settings to the publisher's defaults?"] =
        "Bildeinstellungen auf die Verlagsvorgaben zurücksetzen?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "Absatzeinstellungen auf die Verlagsvorgaben zurücksetzen?",
    ["Reset the text settings this plugin controls to the publisher's defaults?\n\nLine spacing and word spacing belong to KOReader and are left alone."] =
        "Die von diesem Plugin verwalteten Texteinstellungen auf die Verlagsvorgaben zurücksetzen?\n\nZeilenabstand und Wortabstand gehören KOReader und bleiben unberührt.",
    ["Right"] =
        "Rechts",
    ["Save current reading style as preset"] =
        "Aktuellen Lesestil als Voreinstellung speichern",
    ["Scaling"] =
        "Skalierung",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Größe der Kapitelüberschriften in Prozent des umgebenden Textes.\n\n",
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
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "Zum Durchschalten tippen: Buchvorgabe, an, aus.\n\n\"Aus\" ist nicht dasselbe wie \"Buchvorgabe\": Es nimmt Überschriften aktiv die Fettschrift, die der Verlag gesetzt hat.",
    ["Text"] =
        "Text",
    ["Text alignment"] =
        "Textausrichtung",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "Das vertraute E-Reader-Bild: kein Einzug, eine kleine Lücke zwischen Absätzen, durchgehend maßvolle Abstände.",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "Die am häufigsten benutzten Einstellungen auf einem Bildschirm. Lässt sich auch per Geste öffnen.",
    ["The settings you made for the narrower scope will be discarded, and the broader style takes over.\n\nContinue?"] =
        "Die Einstellungen des engeren Bereichs werden verworfen, und der weitere Stil übernimmt.\n\nFortfahren?",
    ["The style you edit here is used for every book that has no style of its own."] =
        "Der hier bearbeitete Stil gilt für jedes Buch, das keinen eigenen Stil hat.",
    ["This book"] =
        "Dieses Buch",
    ["This book only"] =
        "Nur dieses Buch",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "Dieses Plugin schreibt ein kleines Stylesheet und hängt es hinter Ihre Stil-Anpassungen, sodass seine Einstellungen überall dort gewinnen, wo sich beide überschneiden.\n\nAlles, was auf \"Buchvorgabe\" steht, erzeugt überhaupt nichts und lässt Ihre Anpassungen und die Stile des Verlags unberührt.\n\nJede Änderung rendert das Buch neu. Das ist normal und macht KOReader bei jeder Stiländerung so.",
    ["This restores every reading style setting in the current scope to the publisher's defaults.\n\nKOReader's own settings — line spacing, margins, word spacing — are left alone."] =
        "Dies setzt alle Lesestil-Einstellungen im aktuellen Bereich auf die Verlagsvorgaben zurück.\n\nKOReaders eigene Einstellungen — Zeilenabstand, Ränder, Wortabstand — bleiben unberührt.",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "Enge Zeilen und schmale Ränder, kein Abstand zwischen Absätzen. Bringt den meisten Text auf eine Seite.",
    ["Top margin"] =
        "Oberer Rand",
    ["Traditional"] =
        "Traditionell",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "Zwei Zahlen, und nur die erste rückt Wörter auseinander.\n\nSkalierung ist die Breite jedes Leerzeichens, in Prozent des Leerzeichens der Schrift selbst. 100 % ist die natürliche Breite, KOReaders Vorgabe liegt bei 95 % — also etwas schmaler. Für größere Abstände über 100 % hinausgehen.\n\nVerringerung gibt an, wie weit der Blocksatz diese Leerzeichen wieder stauchen darf, um ein weiteres Wort in die Zeile zu bekommen. 100 % verbietet das Stauchen; erhöhen Sie den Wert also mit, sonst halten die größeren Abstände nicht.",
    ["Typography and hyphenation: %1"] =
        "Typografie und Silbentrennung: %1",
    ["Uppercase"] =
        "Großbuchstaben",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Senkrechter Abstand zwischen Absätzen. Die Absatzabstände des Verlags werden zuerst entfernt, damit der gewählte Wert genau so wirkt und nicht obendrauf addiert wird.",
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
}
