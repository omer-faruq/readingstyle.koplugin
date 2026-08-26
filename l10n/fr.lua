--[[--
French translations for the Reading style plugin.

Keys are the English msgids exactly as they appear in the source; anything not
listed here falls back to the English text through readingstyle_gettext.

Regenerate the key list with:
    luajit l10n/tools/extract.lua *.lua > l10n/template.lua
and check this file against it with:
    luajit l10n/tools/validate.lua l10n/template.lua l10n/fr.lua
--]]

return {
    ["\"Fit to text width\" only shrinks images that are too wide. \"Fit to page width\" also enlarges smaller ones, which can stretch images that carry explicit pixel dimensions."] =
        "« Ajuster à la largeur du texte » ne réduit que les images trop larges. « Ajuster à la largeur de la page » agrandit aussi les plus petites, ce qui peut déformer les images ayant des dimensions en pixels explicites.",
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nUnavailable when the book does not declare a language."] =
        "Un style distinct pour les livres dans cette langue, utile lorsqu'une langue se lit mieux avec d'autres conventions de paragraphe.\n\nIndisponible lorsque le livre ne déclare pas de langue.",
    ["A style stored with this book alone. It overrides both of the above."] =
        "Un style enregistré avec ce seul livre. Il l'emporte sur les deux précédents.",
    ["About reading style and style tweaks"] =
        "À propos du style de lecture et des ajustements de style",
    ["Advanced"] =
        "Avancé",
    ["Align"] =
        "Align.",
    ["Aligning images turns them into blocks, which pulls inline images — drop caps, small icons inside a line of text — out of their line. Leave at book default unless you need it."] =
        "Aligner les images les transforme en blocs, ce qui extrait de leur ligne les images en ligne — lettrines, petites icônes au sein d'une ligne de texte. À laisser sur le réglage du livre sauf nécessité.",
    ["Alignment of body text, paragraphs and list items. Headings keep their own alignment setting."] =
        "Alignement du corps de texte, des paragraphes et des éléments de liste. Les titres conservent leur propre alignement.",
    ["Alignment of headings. Applies to all six heading levels, so a centred chapter title does not sit above left-aligned sub-headings."] =
        "Alignement des titres. S'applique aux six niveaux de titre, afin qu'un titre de chapitre centré ne surplombe pas des sous-titres alignés à gauche.",
    ["All books"] =
        "Tous les livres",
    ["Applies to h1, h2 and h3 headings.\n\nBooks that do not mark their chapter titles as real headings — a styled paragraph inside a container, say — cannot be reached by any of these settings."] =
        "S'applique aux titres h1, h2 et h3.\n\nLes livres qui ne balisent pas leurs titres de chapitre comme de vrais titres — un paragraphe mis en forme dans un conteneur, par exemple — ne peuvent être atteints par aucun de ces réglages.",
    ["Apply"] =
        "Appliquer",
    ["Apply changes immediately"] =
        "Appliquer les changements immédiatement",
    ["Apply now"] =
        "Appliquer maintenant",
    ["Apply to: %1"] =
        "Appliquer à : %1",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Ligne vide entre les paragraphes, aucun retrait, interligne et marges généreux. Reposant pour les yeux fatigués.",
    ["Bold"] =
        "Gras",
    ["Book default"] =
        "Par défaut du livre",
    ["Books in %1"] =
        "Livres en %1",
    ["Books in this language"] =
        "Livres dans cette langue",
    ["Bottom margin"] =
        "Marge inférieure",
    ["Caps every image at the width and height of the page, so oversized images no longer spill past the margins."] =
        "Limite chaque image à la largeur et à la hauteur de la page, afin que les images trop grandes ne débordent plus des marges.",
    ["Centered"] =
        "Centré",
    ["Chapter"] =
        "Chapitre",
    ["Chapter title alignment"] =
        "Alignement du titre de chapitre",
    ["Chapter title size"] =
        "Taille du titre de chapitre",
    ["Chapter title style"] =
        "Style du titre de chapitre",
    ["Chapters"] =
        "Chapitres",
    ["Clears every reading style setting and lets the book look the way its publisher intended."] =
        "Efface tous les réglages de style de lecture et laisse le livre tel que son éditeur l'a voulu.",
    ["Close"] =
        "Fermer",
    ["Compact"] =
        "Compact",
    ["Current style: %1"] =
        "Style actuel : %1",
    ["Custom (%1)"] =
        "Personnalisé (%1)",
    ["Custom CSS"] =
        "CSS personnalisé",
    ["Custom CSS (%1 characters)"] =
        "CSS personnalisé (%1 caractères)",
    ["Custom CSS applied"] =
        "CSS personnalisé appliqué",
    ["Cycle reading style presets"] =
        "Faire défiler les préréglages de style de lecture",
    ["Discard"] =
        "Abandonner",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "Ne pas renfoncer la première ligne du paragraphe qui suit un titre, comme le veut l'usage typographique.\n\nN'atteint que les paragraphes suivant directement le titre. Les livres qui enferment le début de chapitre dans un conteneur restent hors de portée.",
    ["E-reader"] =
        "Liseuse",
    ["Edit this book's own tweak"] =
        "Modifier l'ajustement propre à ce livre",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Espace supplémentaire entre les lettres. De petites valeurs peuvent aider la lisibilité ; au-delà d'environ 0,1 em, le texte paraît étiré.",
    ["First paragraph after a heading"] =
        "Premier paragraphe après un titre",
    ["Fit to page width"] =
        "Ajuster à la largeur de la page",
    ["Fit to text width"] =
        "Ajuster à la largeur du texte",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "CSS écrit à la main, ajouté après tout ce que produisent les réglages ci-dessus, et qui l'emporte donc toujours. Il suit la portée que vous modifiez, exactement comme les autres réglages.",
    ["Header and footer"] =
        "En-tête et pied de page",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Hauteur de chaque ligne, en pourcentage. Il s'agit du réglage d'interligne propre à KOReader, le même que celui du menu du bas.",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Marges horizontales de la page. Ce sont elles qui fixent la largeur de la colonne de texte : des marges plus larges donnent une ligne plus étroite, plus facile à parcourir.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "De combien la première ligne de chaque paragraphe est renfoncée. Supprime aussi le retrait hérité des conteneurs, des titres, des éléments de liste et des cellules de tableau, d'où viennent les retraits doublés.",
    ["Image alignment"] =
        "Alignement des images",
    ["Image width"] =
        "Largeur des images",
    ["Images"] =
        "Images",
    ["Indent"] =
        "Retrait",
    ["Italic"] =
        "Italique",
    ["Justified"] =
        "Justifié",
    ["KOReader's own typography rules, including hyphenation. The language chosen here decides which hyphenation dictionary is used, which is why it lives with the language setting rather than on its own."] =
        "Les règles typographiques propres à KOReader, césure comprise. La langue choisie ici détermine le dictionnaire de césure utilisé : c'est pourquoi la césure se trouve avec le réglage de langue plutôt que seule.",
    ["Lang: %1"] =
        "Langue : %1",
    ["Left"] =
        "À gauche",
    ["Left and right margins"] =
        "Marges gauche et droite",
    ["Letter spacing"] =
        "Espacement des lettres",
    ["Line"] =
        "Ligne",
    ["Line spacing"] =
        "Interligne",
    ["Load reading style preset"] =
        "Charger un préréglage de style de lecture",
    ["Margin presets"] =
        "Préréglages de marges",
    ["Narrow"] =
        "Étroites",
    ["No indentation"] =
        "Aucun retrait",
    ["No space above"] =
        "Aucun espace au-dessus",
    ["Normal"] =
        "Normales",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "Sur les lignes justifiées présentant de très grands blancs, permet de répartir l'excédent à l'intérieur des mots sous forme d'espacement des lettres. Exprimé en pourcentage de la taille de police.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "Activé, les changements apparaissent dès que vous les faites. Désactivé, ils sont accumulés et appliqués seulement lorsque vous choisissez « Appliquer maintenant ».\n\nChaque application provoque un nouveau rendu du livre : désactiver l'option vaut donc la peine lorsque vous modifiez plusieurs réglages à la suite.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "Ouvre l'éditeur d'ajustement de style propre au livre de KOReader, avec ses suggestions CSS et sa mise en forme. Cet ajustement est enregistré par KOReader, séparément de cette extension, et s'applique avant ces réglages.",
    ["Original size"] =
        "Taille d'origine",
    ["Page layout"] =
        "Mise en page",
    ["Paragraph indentation"] =
        "Retrait de paragraphe",
    ["Paragraphs"] =
        "Paragraphes",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "Des réglages simples pour ce qui décide de l'aspect d'un livre — retrait et espacement des paragraphes, espace autour des titres de chapitre, alignement, marges, images — avec des préréglages et des styles par livre ou par langue.\n\nS'appuie sur les ajustements de style de KOReader au lieu de les remplacer : tout ce qui reste sur « par défaut du livre » laisse intacts vos ajustements et les styles de l'éditeur.",
    ["Presets"] =
        "Préréglages",
    ["Prettify"] =
        "Mettre en forme",
    ["Prevent images from overflowing the page"] =
        "Empêcher les images de déborder de la page",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "Typographie du livre imprimé : paragraphes renfoncés sans blanc entre eux, titres de chapitre centrés avec de l'espace au-dessus.",
    ["Publisher default"] =
        "Par défaut de l'éditeur",
    ["Quick style"] =
        "Style rapide",
    ["Reading style"] =
        "Style de lecture",
    ["Reading style: %1"] =
        "Style de lecture : %1",
    ["Reduction"] =
        "Réduction",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Supprime l'espace au-dessus du premier paragraphe suivant un titre, afin qu'il se place juste sous le titre de chapitre.",
    ["Reset"] =
        "Réinitialiser",
    ["Reset all reading style settings"] =
        "Réinitialiser tous les réglages de style de lecture",
    ["Reset chapter settings"] =
        "Réinitialiser les réglages de chapitre",
    ["Reset image settings"] =
        "Réinitialiser les réglages d'image",
    ["Reset paragraph settings"] =
        "Réinitialiser les réglages de paragraphe",
    ["Reset text settings"] =
        "Réinitialiser les réglages de texte",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "Réinitialiser les réglages de titre de chapitre aux valeurs de l'éditeur ?",
    ["Reset the image settings to the publisher's defaults?"] =
        "Réinitialiser les réglages d'image aux valeurs de l'éditeur ?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "Réinitialiser les réglages de paragraphe aux valeurs de l'éditeur ?",
    ["Reset the text settings this plugin controls to the publisher's defaults?\n\nLine spacing and word spacing belong to KOReader and are left alone."] =
        "Réinitialiser aux valeurs de l'éditeur les réglages de texte gérés par cette extension ?\n\nL'interligne et l'espacement des mots appartiennent à KOReader et ne sont pas touchés.",
    ["Right"] =
        "À droite",
    ["Save current reading style as preset"] =
        "Enregistrer le style actuel comme préréglage",
    ["Scaling"] =
        "Mise à l'échelle",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Taille des titres de chapitre, en pourcentage du texte environnant.\n\n",
    ["Space after chapter title"] =
        "Espace après le titre de chapitre",
    ["Space before chapter title"] =
        "Espace avant le titre de chapitre",
    ["Space below the text. The status bar, when shown at the bottom, takes its height from here."] =
        "Espace sous le texte. La barre d'état, lorsqu'elle est affichée en bas, y prend sa hauteur.",
    ["Space between paragraphs"] =
        "Espace entre les paragraphes",
    ["Spacing"] =
        "Espace",
    ["Spacious"] =
        "Aéré",
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "Toucher pour faire défiler : par défaut du livre, activé, désactivé.\n\n« Désactivé » n'est pas la même chose que « par défaut du livre » : cela retire activement le gras aux titres que l'éditeur avait mis en gras.",
    ["Text"] =
        "Texte",
    ["Text alignment"] =
        "Alignement du texte",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "L'aspect familier des liseuses : aucun retrait, un petit blanc entre les paragraphes, des espacements modérés partout.",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "Les réglages les plus utilisés, sur un seul écran. Peut aussi s'ouvrir par un geste.",
    ["The settings you made for the narrower scope will be discarded, and the broader style takes over.\n\nContinue?"] =
        "Les réglages faits pour la portée la plus étroite seront abandonnés, et le style de la portée plus large prendra le relais.\n\nContinuer ?",
    ["The style you edit here is used for every book that has no style of its own."] =
        "Le style modifié ici s'applique à tout livre qui n'a pas de style propre.",
    ["This book"] =
        "Ce livre",
    ["This book only"] =
        "Ce livre uniquement",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "Cette extension écrit une petite feuille de style et l'ajoute après vos ajustements de style : ses réglages l'emportent donc partout où les deux se recoupent.\n\nTout ce qui reste sur « par défaut du livre » ne produit rien du tout et laisse intacts vos ajustements et les styles de l'éditeur.\n\nChaque changement provoque un nouveau rendu du livre. C'est normal : KOReader fait de même pour tout changement de style.",
    ["This restores every reading style setting in the current scope to the publisher's defaults.\n\nKOReader's own settings — line spacing, margins, word spacing — are left alone."] =
        "Ceci remet tous les réglages de style de lecture de la portée actuelle aux valeurs de l'éditeur.\n\nLes réglages propres à KOReader — interligne, marges, espacement des mots — ne sont pas touchés.",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "Lignes serrées et marges réduites, aucun espace entre les paragraphes. Fait tenir le plus de texte possible sur une page.",
    ["Top margin"] =
        "Marge supérieure",
    ["Traditional"] =
        "Traditionnel",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "Deux nombres, et seul le premier écarte les mots.\n\nLa mise à l'échelle est la largeur de chaque espace, en pourcentage de l'espace propre à la police. 100 % correspond à la largeur naturelle, et la valeur par défaut de KOReader est 95 % — un peu plus étroite. Dépassez 100 % pour des blancs plus larges.\n\nLa réduction indique jusqu'où la justification peut resserrer ces espaces pour faire tenir un mot de plus sur la ligne. 100 % interdit tout resserrement : augmentez-la aussi, sinon les blancs élargis ne tiendront pas.",
    ["Typography and hyphenation: %1"] =
        "Typographie et césure : %1",
    ["Uppercase"] =
        "Majuscules",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Espace vertical entre les paragraphes. Les marges de paragraphe de l'éditeur sont d'abord supprimées, afin que la valeur choisie soit exactement celle obtenue, au lieu de s'y ajouter.",
    ["Whitespace above chapter and section titles, so a chapter does not start flush against the top of the page.\n\n"] =
        "Blanc au-dessus des titres de chapitre et de section, pour qu'un chapitre ne commence pas collé au haut de la page.\n\n",
    ["Whitespace between a chapter title and the text that follows it.\n\n"] =
        "Blanc entre un titre de chapitre et le texte qui le suit.\n\n",
    ["Wide"] =
        "Larges",
    ["Word expansion"] =
        "Extension des mots",
    ["Word spacing"] =
        "Espacement des mots",
    ["book default"] =
        "par défaut du livre",
    ["hyphenation off"] =
        "césure désactivée",
    ["hyphenation on"] =
        "césure activée",
    ["off"] =
        "désactivé",
    ["on"] =
        "activé",
}
