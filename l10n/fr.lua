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
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nThe language comes from the book's own metadata. When a book declares none this is greyed out, but you can give it one yourself: Book information, hold the language field, and set it. Reopen the book afterwards."] =
        "Un style distinct pour les livres dans cette langue, utile lorsqu'une langue se lit mieux avec d'autres conventions de paragraphe.\n\nLa langue provient des métadonnées du livre. Quand un livre n'en déclare aucune, l'option est grisée ; vous pouvez toutefois en indiquer une : Informations sur le livre, appui long sur le champ de langue, puis renseignez-la. Rouvrez ensuite le livre.",
    ["A style stored with this book alone.\n\nSwitching between these three only changes which one you are editing and which one this book uses. The others keep their settings."] =
        "Un style enregistré avec ce seul livre.\n\nBasculer entre ces trois niveaux change seulement celui que vous modifiez et celui qu'utilise ce livre. Les autres conservent leurs réglages.",
    ["A thin line under chapter titles, in the manner of an older printed book."] =
        "Un filet sous les titres de chapitre, à la manière d'un livre imprimé ancien.",
    ["About reading style and style tweaks"] =
        "À propos du style de lecture et des ajustements de style",
    ["Advanced"] =
        "Avancé",
    ["After"] =
        "Après",
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
    ["Applying this will reload the book."] =
        "Appliquer ceci rechargera le livre.",
    ["Avoid widows and orphans"] =
        "Éviter les veuves et les orphelines",
    ["Before"] =
        "Avant",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Ligne vide entre les paragraphes, aucun retrait, interligne et marges généreux. Reposant pour les yeux fatigués.",
    ["Block quotes"] =
        "Citations en bloc",
    ["Bold"] =
        "Gras",
    ["Bold instead of italic"] =
        "Gras au lieu de l'italique",
    ["Book default"] =
        "Par défaut du livre",
    ["Books in %1"] =
        "Livres en %1",
    ["Books in this language"] =
        "Livres dans cette langue",
    ["Bottom margin"] =
        "Marge inférieure",
    ["Cancel"] =
        "Annuler",
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
    ["Clears tinted boxes and page backgrounds. On a greyscale screen these become flat grey blocks that make the text on them harder to read."] =
        "Supprime les encadrés colorés et les fonds de page. Sur un écran en niveaux de gris, ils deviennent des aplats gris qui rendent le texte moins lisible.",
    ["Close"] =
        "Fermer",
    ["Compact"] =
        "Compact",
    ["Could not write the file: %1"] =
        "Impossible d'écrire le fichier : %1",
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
    ["Delete"] =
        "Supprimer",
    ["Delete the %1 style"] =
        "Supprimer le style %1",
    ["Delete the style for this language"] =
        "Supprimer le style de cette langue",
    ["Delete the style stored at that level?"] =
        "Supprimer le style enregistré à ce niveau ?",
    ["Delete this book's style"] =
        "Supprimer le style de ce livre",
    ["Deletes the style stored at that level. Editing moves to the next level up, and its style takes over."] =
        "Supprime le style enregistré à ce niveau. La modification passe au niveau supérieur, dont le style prend le relais.",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "Ne pas renfoncer la première ligne du paragraphe qui suit un titre, comme le veut l'usage typographique.\n\nN'atteint que les paragraphes suivant directement le titre. Les livres qui enferment le début de chapitre dans un conteneur restent hors de portée.",
    ["Draws the page you are on with these settings in a separate process, and shows it to you before anything happens to the book.\n\nThe book itself is not re-rendered and nothing is saved unless you choose \"Apply\" there, so looking costs nothing."] =
        "Dessine la page où vous êtes avec ces réglages dans un processus séparé, et vous la montre avant que quoi que ce soit n'arrive au livre.\n\nLe livre lui-même n'est pas recalculé et rien n'est enregistré tant que vous ne choisissez pas « Appliquer » ; regarder ne coûte donc rien.",
    ["E-reader"] =
        "Liseuse",
    ["Edit this book's own tweak"] =
        "Modifier l'ajustement propre à ce livre",
    ["Emphasis"] =
        "Mise en valeur",
    ["Exactly what this plugin is appending to your stylesheet right now. Worth pasting into a bug report."] =
        "Exactement ce que cette extension ajoute à votre feuille de style en ce moment. À coller dans un rapport de bogue.",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Espace supplémentaire entre les lettres. De petites valeurs peuvent aider la lisibilité ; au-delà d'environ 0,1 em, le texte paraît étiré.",
    ["First paragraph after a heading"] =
        "Premier paragraphe après un titre",
    ["Fit to page width"] =
        "Ajuster à la largeur de la page",
    ["Fit to text width"] =
        "Ajuster à la largeur du texte",
    ["Font weight"] =
        "Graisse de la police",
    ["Footnote markers and cross-references are usually blue, which renders as a mid grey."] =
        "Les appels de note et les renvois sont généralement bleus, ce qui donne un gris moyen.",
    ["Force a page break before each chapter title, the way a printed book does.\n\nChoosing H1 and H2 also keeps a subtitle from starting a second page of its own."] =
        "Force un saut de page avant chaque titre de chapitre, comme dans un livre imprimé.\n\nAvec H1 et H2, un sous-titre ne commence pas non plus une deuxième page à lui seul.",
    ["Force black text"] =
        "Forcer le texte en noir",
    ["Full page"] =
        "Page entière",
    ["H1 and H2"] =
        "H1 et H2",
    ["H1 only"] =
        "H1 uniquement",
    ["H1, H2 and H3"] =
        "H1, H2 et H3",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "CSS écrit à la main, ajouté après tout ce que produisent les réglages ci-dessus, et qui l'emporte donc toujours. Il suit la portée que vous modifiez, exactement comme les autres réglages.",
    ["Header and footer"] =
        "En-tête et pied de page",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Hauteur de chaque ligne, en pourcentage. Il s'agit du réglage d'interligne propre à KOReader, le même que celui du menu du bas.",
    ["Hide images"] =
        "Masquer les images",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Marges horizontales de la page. Ce sont elles qui fixent la largeur de la colonne de texte : des marges plus larges donnent une ligne plus étroite, plus facile à parcourir.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "De combien la première ligne de chaque paragraphe est renfoncée. Supprime aussi le retrait hérité des conteneurs, des titres, des éléments de liste et des cellules de tableau, d'où viennent les retraits doublés.",
    ["How quoted passages are set apart from the body text. \"No special treatment\" clears the publisher's own indentation and italics instead of adding to them."] =
        "Comment les passages cités se distinguent du corps du texte. « Aucun traitement particulier » supprime le retrait et l'italique de l'éditeur au lieu de s'y ajouter.",
    ["Image alignment"] =
        "Alignement des images",
    ["Image width"] =
        "Largeur des images",
    ["Images"] =
        "Images",
    ["Indent"] =
        "Retrait",
    ["Indented"] =
        "En retrait",
    ["Indented and italic"] =
        "En retrait et en italique",
    ["Ink and links"] =
        "Encre et liens",
    ["Inside the preview you can go on changing settings and turning pages: everything you change there is held until you apply it."] =
        "Dans l'aperçu, vous pouvez continuer à modifier les réglages et à tourner les pages : tout ce que vous y changez est retenu jusqu'à ce que vous l'appliquiez.",
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
    ["Lets preformatted blocks — code listings, terminal output — wrap instead of running off the edge of the page."] =
        "Permet aux blocs préformatés — listings de code, sorties de terminal — de passer à la ligne au lieu de déborder de la page.",
    ["Letter spacing"] =
        "Espacement des lettres",
    ["Line"] =
        "Ligne",
    ["Line spacing"] =
        "Interligne",
    ["Links in black"] =
        "Liens en noir",
    ["Links without underline"] =
        "Liens sans soulignement",
    ["Load reading style preset"] =
        "Charger un préréglage de style de lecture",
    ["Makes the text heavier or lighter than the font's own weight. A small increase is the most effective answer to a font that prints faintly on e-ink.\n\nThis is KOReader's own font weight setting."] =
        "Rend le texte plus gras ou plus maigre que la graisse propre à la police. Une légère augmentation est la réponse la plus efficace à une police qui rend pâle sur e-ink.\n\nIl s'agit du réglage de graisse propre à KOReader.",
    ["Margin presets"] =
        "Préréglages de marges",
    ["Narrow"] =
        "Étroites",
    ["Needs a font that can produce small capitals, or the reader's font will synthesise them and the result can look uneven."] =
        "Nécessite une police disposant de vraies petites capitales ; sinon la police les simule et le résultat peut paraître irrégulier.",
    ["No indentation"] =
        "Aucun retrait",
    ["No space above"] =
        "Aucun espace au-dessus",
    ["No special treatment"] =
        "Aucun traitement particulier",
    ["Normal"] =
        "Normales",
    ["Not available from inside a preview: that editor writes to the book itself, which a preview must not do."] =
        "Non disponible depuis un aperçu : cet éditeur écrit dans le livre lui-même, ce qu'un aperçu ne doit pas faire.",
    ["Nothing is being generated: every setting is at book default."] =
        "Rien n'est généré : tous les réglages sont sur la valeur par défaut du livre.",
    ["On H1"] =
        "Sur H1",
    ["On H1 and H2"] =
        "Sur H1 et H2",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "Sur les lignes justifiées présentant de très grands blancs, permet de répartir l'excédent à l'intérieur des mots sous forme d'espacement des lettres. Exprimé en pourcentage de la taille de police.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "Activé, les changements apparaissent dès que vous les faites. Désactivé, ils sont accumulés et appliqués seulement lorsque vous choisissez « Appliquer maintenant ».\n\nChaque application provoque un nouveau rendu du livre : désactiver l'option vaut donc la peine lorsque vous modifiez plusieurs réglages à la suite.",
    ["Only the settings this plugin owns travel with a language: indentation, spacing, alignment, chapter titles, images, custom CSS.\n\nLine spacing, margins and word spacing belong to KOReader, which stores them per book and has no notion of a language, so they stay where they are."] =
        "Seuls les réglages appartenant à cette extension suivent une langue : retrait, espacement, alignement, titres de chapitre, images, CSS personnalisé.\n\nL'interligne, les marges et l'espacement des mots appartiennent à KOReader, qui les enregistre par livre et ne connaît pas les langues : ils restent où ils sont.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "Ouvre l'éditeur d'ajustement de style propre au livre de KOReader, avec ses suggestions CSS et sa mise en forme. Cet ajustement est enregistré par KOReader, séparément de cette extension, et s'applique avant ces réglages.",
    ["Original size"] =
        "Taille d'origine",
    ["Overrides every colour the publisher chose, including the greys used for asides and captions, which print faintly on e-ink.\n\nAlso blackens borders."] =
        "Remplace toutes les couleurs choisies par l'éditeur, y compris les gris employés pour les apartés et les légendes, qui rendent pâle sur e-ink.\n\nNoircit aussi les bordures.",
    ["Page layout"] =
        "Mise en page",
    ["Paragraph indentation"] =
        "Retrait de paragraphe",
    ["Paragraphs"] =
        "Paragraphes",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "Des réglages simples pour ce qui décide de l'aspect d'un livre — retrait et espacement des paragraphes, espace autour des titres de chapitre, alignement, marges, images — avec des préréglages et des styles par livre ou par langue.\n\nS'appuie sur les ajustements de style de KOReader au lieu de les remplacer : tout ce qui reste sur « par défaut du livre » laisse intacts vos ajustements et les styles de l'éditeur.",
    ["Playground"] =
        "Bac à sable",
    ["Presets"] =
        "Préréglages",
    ["Prettify"] =
        "Mettre en forme",
    ["Prevent images from overflowing the page"] =
        "Empêcher les images de déborder de la page",
    ["Preview is not available for this book."] =
        "L'aperçu n'est pas disponible pour ce livre.",
    ["Preview is not available on this device."] =
        "L'aperçu n'est pas disponible sur cet appareil.",
    ["Preview: after"] =
        "Aperçu : après",
    ["Preview: before"] =
        "Aperçu : avant",
    ["Preview: before | after"] =
        "Aperçu : avant | après",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "Typographie du livre imprimé : paragraphes renfoncés sans blanc entre eux, titres de chapitre centrés avec de l'espace au-dessus.",
    ["Publisher default"] =
        "Par défaut de l'éditeur",
    ["Puts everything this menu marks as changed back to default, at the level you are editing: this plugin's settings return to book default, and KOReader's own — line spacing, word spacing, font weight, margins — return to theirs.\n\nStyles stored at the other levels are not touched; deleting those is a separate action."] =
        "Remet tout ce que ce menu signale comme modifié à sa valeur par défaut, au niveau que vous modifiez : les réglages de cette extension reviennent au défaut du livre, ceux de KOReader — interligne, espacement des mots, graisse, marges — aux leurs.\n\nLes styles enregistrés aux autres niveaux ne sont pas touchés ; les supprimer est une action distincte.",
    ["Quick style"] =
        "Style rapide",
    ["Reading style"] =
        "Style de lecture",
    ["Reading style: %1"] =
        "Style de lecture : %1",
    ["Reduction"] =
        "Réduction",
    ["Remove background colours"] =
        "Supprimer les couleurs de fond",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Supprime l'espace au-dessus du premier paragraphe suivant un titre, afin qu'il se place juste sous le titre de chapitre.",
    ["Removes every image from the page, for reading a heavily illustrated book as plain text.\n\nCaptions stay, since they are ordinary text."] =
        "Retire toutes les images de la page, pour lire un livre très illustré comme du texte seul.\n\nLes légendes restent, puisque ce sont des textes ordinaires.",
    ["Rendering the book with the new style…\n\nThe book on screen is not being changed. This takes about as long as applying the style would."] =
        "Rendu du livre avec le nouveau style…\n\nLe livre affiché n'est pas modifié. Cela prend à peu près le même temps que d'appliquer le style.",
    ["Replace"] =
        "Remplacer",
    ["Replaces italics with something else. Worth it when a book's italic face is thin or hard to read on screen."] =
        "Remplace l'italique par autre chose. Utile quand l'italique d'un livre est maigre ou difficile à lire à l'écran.",
    ["Reset"] =
        "Réinitialiser",
    ["Reset all four margins to their defaults?"] =
        "Réinitialiser les quatre marges à leurs valeurs par défaut ?",
    ["Reset all reading style settings"] =
        "Réinitialiser tous les réglages de style de lecture",
    ["Reset chapter settings"] =
        "Réinitialiser les réglages de chapitre",
    ["Reset every text setting in this section, including KOReader's own line spacing, word spacing, word expansion and font weight?"] =
        "Réinitialiser tous les réglages de texte de cette section, y compris l'interligne, l'espacement des mots, l'extension des mots et la graisse propres à KOReader ?",
    ["Reset image settings"] =
        "Réinitialiser les réglages d'image",
    ["Reset ink settings"] =
        "Réinitialiser les réglages d'encre",
    ["Reset margins"] =
        "Réinitialiser les marges",
    ["Reset paragraph settings"] =
        "Réinitialiser les réglages de paragraphe",
    ["Reset text settings"] =
        "Réinitialiser les réglages de texte",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "Réinitialiser les réglages de titre de chapitre aux valeurs de l'éditeur ?",
    ["Reset the colour and link settings to the publisher's defaults?"] =
        "Réinitialiser les réglages de couleur et de liens aux valeurs de l'éditeur ?",
    ["Reset the image settings to the publisher's defaults?"] =
        "Réinitialiser les réglages d'image aux valeurs de l'éditeur ?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "Réinitialiser les réglages de paragraphe aux valeurs de l'éditeur ?",
    ["Right"] =
        "À droite",
    ["Rule under the title"] =
        "Filet sous le titre",
    ["Save as a style tweak"] =
        "Enregistrer comme ajustement de style",
    ["Save current reading style as preset"] =
        "Enregistrer le style actuel comme préréglage",
    ["Saved to %1\n\nIt appears under Style tweaks, in User style tweaks, once KOReader is restarted."] =
        "Enregistré dans %1\n\nApparaît sous Ajustements de style, dans les ajustements de l'utilisateur, après un redémarrage de KOReader.",
    ["Scaling"] =
        "Mise à l'échelle",
    ["Settings"] =
        "Réglages",
    ["Show after"] =
        "Afficher après",
    ["Show before"] =
        "Afficher avant",
    ["Shrinks footnote markers and the like, and stops them from stretching the line they sit on."] =
        "Réduit les appels de note et similaires, et les empêche d'étirer la ligne où ils se trouvent.",
    ["Side by side"] =
        "Côte à côte",
    ["Side margins"] =
        "Marges latérales",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Taille des titres de chapitre, en pourcentage du texte environnant.\n\n",
    ["Small capitals"] =
        "Petites capitales",
    ["Smaller sub- and superscript"] =
        "Indices et exposants plus petits",
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
    ["Start chapters on a new page"] =
        "Commencer les chapitres sur une nouvelle page",
    ["Stop a paragraph from leaving a single line stranded at the top or bottom of a page.\n\nPages end less evenly as a result, and the page count shifts."] =
        "Empêche un paragraphe de laisser une ligne isolée en haut ou en bas d'une page.\n\nLes pages se terminent de façon moins régulière et la pagination se décale.",
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "Toucher pour faire défiler : par défaut du livre, activé, désactivé.\n\n« Désactivé » n'est pas la même chose que « par défaut du livre » : cela retire activement le gras aux titres que l'éditeur avait mis en gras.",
    ["Text"] =
        "Texte",
    ["Text alignment"] =
        "Alignement du texte",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "L'aspect familier des liseuses : aucun retrait, un petit blanc entre les paragraphes, des espacements modérés partout.",
    ["The preview could not be rendered on this device."] =
        "L'aperçu n'a pas pu être rendu sur cet appareil.",
    ["The preview did not produce a page."] =
        "L'aperçu n'a produit aucune page.",
    ["The preview failed."] =
        "L'aperçu a échoué.",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "Les réglages les plus utilisés, sur un seul écran. Peut aussi s'ouvrir par un geste.",
    ["The style you edit here is used for every book that has no style of its own."] =
        "Le style modifié ici s'applique à tout livre qui n'a pas de style propre.",
    ["There is not enough free memory for a preview right now.\n\nA preview renders a second copy of the book in a separate process, which needs room. Closing other things, or reopening the book, usually frees enough."] =
        "Il n'y a pas assez de mémoire libre pour un aperçu en ce moment.\n\nUn aperçu effectue le rendu d'une deuxième copie du livre dans un processus séparé, ce qui demande de la place. Fermer d'autres choses, ou rouvrir le livre, en libère généralement assez.",
    ["This book"] =
        "Ce livre",
    ["This book only"] =
        "Ce livre uniquement",
    ["This page has not been rendered yet."] =
        "Cette page n'a pas encore été rendue.",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "Cette extension écrit une petite feuille de style et l'ajoute après vos ajustements de style : ses réglages l'emportent donc partout où les deux se recoupent.\n\nTout ce qui reste sur « par défaut du livre » ne produit rien du tout et laisse intacts vos ajustements et les styles de l'éditeur.\n\nChaque changement provoque un nouveau rendu du livre. C'est normal : KOReader fait de même pour tout changement de style.",
    ["This replaces the style already stored at that level with the settings you are looking at now.\n\nContinue?"] =
        "Ceci remplace le style déjà enregistré à ce niveau par les réglages que vous avez sous les yeux.\n\nContinuer ?",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "Lignes serrées et marges réduites, aucun espace entre les paragraphes. Fait tenir le plus de texte possible sur une page.",
    ["Top margin"] =
        "Marge supérieure",
    ["Traditional"] =
        "Traditionnel",
    ["Try"] =
        "Essayer",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "Deux nombres, et seul le premier écarte les mots.\n\nLa mise à l'échelle est la largeur de chaque espace, en pourcentage de l'espace propre à la police. 100 % correspond à la largeur naturelle, et la valeur par défaut de KOReader est 95 % — un peu plus étroite. Dépassez 100 % pour des blancs plus larges.\n\nLa réduction indique jusqu'où la justification peut resserrer ces espaces pour faire tenir un mot de plus sur la ligne. 100 % interdit tout resserrement : augmentez-la aussi, sinon les blancs élargis ne tiendront pas.",
    ["Typography and hyphenation: %1"] =
        "Typographie et césure : %1",
    ["Underlined instead of italic"] =
        "Souligné au lieu de l'italique",
    ["Uppercase"] =
        "Majuscules",
    ["Use these settings for all books"] =
        "Utiliser ces réglages pour tous les livres",
    ["Use these settings for all books in %1"] =
        "Utiliser ces réglages pour tous les livres en %1",
    ["Use these settings for all books in this language"] =
        "Utiliser ces réglages pour tous les livres dans cette langue",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Espace vertical entre les paragraphes. Les marges de paragraphe de l'éditeur sont d'abord supprimées, afin que la valeur choisie soit exactement celle obtenue, au lieu de s'y ajouter.",
    ["View generated CSS"] =
        "Voir le CSS généré",
    ["What counts as a chapter"] =
        "Ce qui compte comme un chapitre",
    ["Which heading levels the settings below apply to.\n\nMost books mark chapters as H1, many use H2, and a few use H3. Including H3 in a book full of sub-headings will space out things that are not chapters at all.\n\nAlignment is deliberately left out of this: it always applies to every heading level."] =
        "Les niveaux de titre auxquels s'appliquent les réglages ci-dessous.\n\nLa plupart des livres balisent les chapitres en H1, beaucoup utilisent H2, quelques-uns H3. Inclure H3 dans un livre plein de sous-titres espacera des éléments qui ne sont pas des chapitres.\n\nL'alignement en est délibérément exclu : il s'applique toujours à tous les niveaux de titre.",
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
    ["Wrap long code lines"] =
        "Renvoyer à la ligne les longues lignes de code",
    ["Writes the generated CSS into KOReader's own user style tweaks folder, where it works without this plugin. A way out that does not cost you your settings."] =
        "Écrit le CSS généré dans le dossier des ajustements de style de KOReader, où il fonctionne sans cette extension. Une porte de sortie qui ne vous coûte pas vos réglages.",
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
    ["page %1 of %2"] =
        "page %1 sur %2",
    ["style changes"] =
        "modifications de style",
}
