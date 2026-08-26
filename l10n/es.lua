--[[--
Spanish translations for the Reading style plugin.

Keys are the English msgids exactly as they appear in the source; anything not
listed here falls back to the English text through readingstyle_gettext.

Regenerate the key list with:
    luajit l10n/tools/extract.lua *.lua > l10n/template.lua
and check this file against it with:
    luajit l10n/tools/validate.lua l10n/template.lua l10n/es.lua
--]]

return {
    ["\"Fit to text width\" only shrinks images that are too wide. \"Fit to page width\" also enlarges smaller ones, which can stretch images that carry explicit pixel dimensions."] =
        "«Ajustar al ancho del texto» solo reduce las imágenes demasiado anchas. «Ajustar al ancho de la página» también amplía las más pequeñas, lo que puede deformar imágenes con dimensiones en píxeles explícitas.",
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nUnavailable when the book does not declare a language."] =
        "Un estilo aparte para los libros en este idioma, útil cuando un idioma se lee mejor con otras convenciones de párrafo.\n\nNo disponible cuando el libro no declara idioma.",
    ["A style stored with this book alone. It overrides both of the above."] =
        "Un estilo guardado solo con este libro. Prevalece sobre los dos anteriores.",
    ["About reading style and style tweaks"] =
        "Acerca del estilo de lectura y los ajustes de estilo",
    ["Advanced"] =
        "Avanzado",
    ["Align"] =
        "Alin.",
    ["Aligning images turns them into blocks, which pulls inline images — drop caps, small icons inside a line of text — out of their line. Leave at book default unless you need it."] =
        "Alinear las imágenes las convierte en bloques, lo que saca de su línea a las imágenes en línea: capitulares, iconos pequeños dentro de una línea de texto. Déjelo en el valor del libro salvo que lo necesite.",
    ["Alignment of body text, paragraphs and list items. Headings keep their own alignment setting."] =
        "Alineación del cuerpo de texto, los párrafos y los elementos de lista. Los encabezados conservan su propia alineación.",
    ["Alignment of headings. Applies to all six heading levels, so a centred chapter title does not sit above left-aligned sub-headings."] =
        "Alineación de los encabezados. Se aplica a los seis niveles, para que un título de capítulo centrado no quede sobre subtítulos alineados a la izquierda.",
    ["All books"] =
        "Todos los libros",
    ["Applies to h1, h2 and h3 headings.\n\nBooks that do not mark their chapter titles as real headings — a styled paragraph inside a container, say — cannot be reached by any of these settings."] =
        "Se aplica a los encabezados h1, h2 y h3.\n\nLos libros que no marcan sus títulos de capítulo como encabezados reales —por ejemplo, un párrafo con formato dentro de un contenedor— no pueden alcanzarse con ninguno de estos ajustes.",
    ["Apply"] =
        "Aplicar",
    ["Apply changes immediately"] =
        "Aplicar los cambios de inmediato",
    ["Apply now"] =
        "Aplicar ahora",
    ["Apply to: %1"] =
        "Aplicar a: %1",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Línea en blanco entre párrafos, sin sangría, interlineado y márgenes generosos. Descansa la vista cansada.",
    ["Bold"] =
        "Negrita",
    ["Book default"] =
        "Predeterminado del libro",
    ["Books in %1"] =
        "Libros en %1",
    ["Books in this language"] =
        "Libros en este idioma",
    ["Bottom margin"] =
        "Margen inferior",
    ["Caps every image at the width and height of the page, so oversized images no longer spill past the margins."] =
        "Limita cada imagen al ancho y alto de la página, de modo que las imágenes demasiado grandes ya no se salgan de los márgenes.",
    ["Centered"] =
        "Centrado",
    ["Chapter"] =
        "Capítulo",
    ["Chapter title alignment"] =
        "Alineación del título de capítulo",
    ["Chapter title size"] =
        "Tamaño del título de capítulo",
    ["Chapter title style"] =
        "Estilo del título de capítulo",
    ["Chapters"] =
        "Capítulos",
    ["Clears every reading style setting and lets the book look the way its publisher intended."] =
        "Borra todos los ajustes de estilo de lectura y deja que el libro se vea como quiso su editorial.",
    ["Close"] =
        "Cerrar",
    ["Compact"] =
        "Compacto",
    ["Current style: %1"] =
        "Estilo actual: %1",
    ["Custom (%1)"] =
        "Personalizado (%1)",
    ["Custom CSS"] =
        "CSS personalizado",
    ["Custom CSS (%1 characters)"] =
        "CSS personalizado (%1 caracteres)",
    ["Custom CSS applied"] =
        "CSS personalizado aplicado",
    ["Cycle reading style presets"] =
        "Alternar entre preajustes de estilo de lectura",
    ["Discard"] =
        "Descartar",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "No sangrar la primera línea del párrafo que sigue a un encabezado, como manda la convención tipográfica.\n\nSolo alcanza a los párrafos que siguen directamente al encabezado. Los libros que envuelven el comienzo del capítulo en un contenedor quedan fuera de alcance.",
    ["E-reader"] =
        "Lector electrónico",
    ["Edit this book's own tweak"] =
        "Editar el ajuste propio de este libro",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Espacio adicional entre letras. Valores pequeños pueden mejorar la legibilidad; por encima de unos 0,1 em el texto empieza a verse estirado.",
    ["First paragraph after a heading"] =
        "Primer párrafo tras un encabezado",
    ["Fit to page width"] =
        "Ajustar al ancho de la página",
    ["Fit to text width"] =
        "Ajustar al ancho del texto",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "CSS escrito a mano, añadido después de todo lo que producen los controles anteriores, por lo que siempre prevalece. Sigue el ámbito que esté editando, igual que el resto de los ajustes.",
    ["Header and footer"] =
        "Encabezado y pie de página",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Altura de cada línea, en porcentaje. Es el ajuste de interlineado propio de KOReader, el mismo que cambia el menú inferior.",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Márgenes horizontales de la página. Son los que fijan el ancho de la columna de texto: márgenes más anchos dan una línea más estrecha y más fácil de recorrer.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "Cuánto se sangra la primera línea de cada párrafo. También elimina la sangría heredada de contenedores, encabezados, elementos de lista y celdas de tabla, de donde vienen las sangrías duplicadas.",
    ["Image alignment"] =
        "Alineación de imagen",
    ["Image width"] =
        "Ancho de imagen",
    ["Images"] =
        "Imágenes",
    ["Indent"] =
        "Sangría",
    ["Italic"] =
        "Cursiva",
    ["Justified"] =
        "Justificado",
    ["KOReader's own typography rules, including hyphenation. The language chosen here decides which hyphenation dictionary is used, which is why it lives with the language setting rather than on its own."] =
        "Las reglas tipográficas propias de KOReader, incluida la partición de palabras. El idioma elegido aquí determina qué diccionario de partición se usa: por eso la partición está junto al ajuste de idioma y no por separado.",
    ["Lang: %1"] =
        "Idioma: %1",
    ["Left"] =
        "Izquierda",
    ["Left and right margins"] =
        "Márgenes izquierdo y derecho",
    ["Letter spacing"] =
        "Espaciado entre letras",
    ["Line"] =
        "Línea",
    ["Line spacing"] =
        "Interlineado",
    ["Load reading style preset"] =
        "Cargar preajuste de estilo de lectura",
    ["Margin presets"] =
        "Preajustes de márgenes",
    ["Narrow"] =
        "Estrechos",
    ["No indentation"] =
        "Sin sangría",
    ["No space above"] =
        "Sin espacio encima",
    ["Normal"] =
        "Normales",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "En líneas justificadas con huecos muy anchos, permite repartir el espacio sobrante dentro de las palabras como espaciado entre letras. Se indica como porcentaje del tamaño de fuente.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "Activado, los cambios aparecen en cuanto los hace. Desactivado, se acumulan y solo se aplican cuando elige «Aplicar ahora».\n\nCada aplicación vuelve a componer el libro, así que desactivarlo compensa cuando va a cambiar varios ajustes seguidos.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "Abre el editor de ajustes de estilo específicos del libro de KOReader, con sus sugerencias de CSS y su formateador. Ese ajuste lo guarda KOReader, aparte de esta extensión, y se aplica antes que estos ajustes.",
    ["Original size"] =
        "Tamaño original",
    ["Page layout"] =
        "Diseño de página",
    ["Paragraph indentation"] =
        "Sangría de párrafo",
    ["Paragraphs"] =
        "Párrafos",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "Controles sencillos para los ajustes que deciden el aspecto de un libro —sangría y espaciado de párrafos, espacio alrededor de los títulos de capítulo, alineación, márgenes, imágenes—, con preajustes y estilos por libro o por idioma.\n\nSe apoya en los ajustes de estilo de KOReader en lugar de sustituirlos: todo lo que quede en «predeterminado del libro» deja intactos sus ajustes y los estilos de la editorial.",
    ["Presets"] =
        "Preajustes",
    ["Prettify"] =
        "Formatear",
    ["Prevent images from overflowing the page"] =
        "Evitar que las imágenes se salgan de la página",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "Tipografía de libro impreso: párrafos sangrados sin hueco entre ellos, títulos de capítulo centrados con espacio encima.",
    ["Publisher default"] =
        "Predeterminado de la editorial",
    ["Quick style"] =
        "Estilo rápido",
    ["Reading style"] =
        "Estilo de lectura",
    ["Reading style: %1"] =
        "Estilo de lectura: %1",
    ["Reduction"] =
        "Reducción",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Elimina el espacio sobre el primer párrafo tras un encabezado, de modo que quede justo debajo del título de capítulo.",
    ["Reset"] =
        "Restablecer",
    ["Reset all reading style settings"] =
        "Restablecer todos los ajustes de estilo de lectura",
    ["Reset chapter settings"] =
        "Restablecer los ajustes de capítulo",
    ["Reset image settings"] =
        "Restablecer los ajustes de imagen",
    ["Reset paragraph settings"] =
        "Restablecer los ajustes de párrafo",
    ["Reset text settings"] =
        "Restablecer los ajustes de texto",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "¿Restablecer los ajustes del título de capítulo a los valores de la editorial?",
    ["Reset the image settings to the publisher's defaults?"] =
        "¿Restablecer los ajustes de imagen a los valores de la editorial?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "¿Restablecer los ajustes de párrafo a los valores de la editorial?",
    ["Reset the text settings this plugin controls to the publisher's defaults?\n\nLine spacing and word spacing belong to KOReader and are left alone."] =
        "¿Restablecer a los valores de la editorial los ajustes de texto que controla esta extensión?\n\nEl interlineado y el espaciado entre palabras pertenecen a KOReader y quedan intactos.",
    ["Right"] =
        "Derecha",
    ["Save current reading style as preset"] =
        "Guardar el estilo actual como preajuste",
    ["Scaling"] =
        "Escalado",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Tamaño de los títulos de capítulo, como porcentaje del texto que los rodea.\n\n",
    ["Space after chapter title"] =
        "Espacio después del título de capítulo",
    ["Space before chapter title"] =
        "Espacio antes del título de capítulo",
    ["Space below the text. The status bar, when shown at the bottom, takes its height from here."] =
        "Espacio bajo el texto. La barra de estado, cuando se muestra abajo, toma de aquí su altura.",
    ["Space between paragraphs"] =
        "Espacio entre párrafos",
    ["Spacing"] =
        "Espacio",
    ["Spacious"] =
        "Espacioso",
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "Toque para alternar: predeterminado del libro, activado, desactivado.\n\n«Desactivado» no es lo mismo que «predeterminado del libro»: quita activamente la negrita a los títulos que la editorial puso en negrita.",
    ["Text"] =
        "Texto",
    ["Text alignment"] =
        "Alineación del texto",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "El aspecto habitual de un lector electrónico: sin sangría, un pequeño hueco entre párrafos y espaciados moderados en todo el texto.",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "Los ajustes que más se usan, en una sola pantalla. También puede abrirse con un gesto.",
    ["The settings you made for the narrower scope will be discarded, and the broader style takes over.\n\nContinue?"] =
        "Se descartarán los ajustes hechos para el ámbito más concreto y pasará a mandar el estilo del ámbito más amplio.\n\n¿Continuar?",
    ["The style you edit here is used for every book that has no style of its own."] =
        "El estilo que edite aquí se usa en todos los libros que no tengan un estilo propio.",
    ["This book"] =
        "Este libro",
    ["This book only"] =
        "Solo este libro",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "Esta extensión escribe una pequeña hoja de estilos y la añade después de sus ajustes de estilo, de modo que sus valores prevalecen allí donde ambos se solapan.\n\nTodo lo que quede en «predeterminado del libro» no genera nada en absoluto y deja intactos sus ajustes y los estilos de la editorial.\n\nCada cambio vuelve a componer el libro. Es normal: KOReader hace lo mismo con cualquier cambio de estilo.",
    ["This restores every reading style setting in the current scope to the publisher's defaults.\n\nKOReader's own settings — line spacing, margins, word spacing — are left alone."] =
        "Esto devuelve todos los ajustes de estilo de lectura del ámbito actual a los valores de la editorial.\n\nLos ajustes propios de KOReader —interlineado, márgenes, espaciado entre palabras— quedan intactos.",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "Líneas apretadas y márgenes pequeños, sin espacio entre párrafos. Encaja la mayor cantidad de texto en una página.",
    ["Top margin"] =
        "Margen superior",
    ["Traditional"] =
        "Tradicional",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "Dos números, y solo el primero separa las palabras.\n\nEl escalado es el ancho de cada espacio, como porcentaje del espacio propio de la fuente. El 100 % es el ancho natural, y el valor predeterminado de KOReader es 95 %: algo más estrecho. Suba por encima del 100 % para obtener huecos más anchos.\n\nLa reducción indica cuánto puede la justificación volver a comprimir esos espacios para que quepa otra palabra en la línea. El 100 % lo impide por completo, así que súbala también o los huecos más anchos no se mantendrán.",
    ["Typography and hyphenation: %1"] =
        "Tipografía y partición de palabras: %1",
    ["Uppercase"] =
        "Mayúsculas",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Espacio vertical entre párrafos. Los márgenes de párrafo de la editorial se eliminan primero, de modo que el valor elegido es exactamente el que se obtiene en lugar de sumarse al existente.",
    ["Whitespace above chapter and section titles, so a chapter does not start flush against the top of the page.\n\n"] =
        "Espacio en blanco sobre los títulos de capítulo y de sección, para que un capítulo no empiece pegado al borde superior de la página.\n\n",
    ["Whitespace between a chapter title and the text that follows it.\n\n"] =
        "Espacio en blanco entre un título de capítulo y el texto que le sigue.\n\n",
    ["Wide"] =
        "Anchos",
    ["Word expansion"] =
        "Expansión de palabras",
    ["Word spacing"] =
        "Espaciado entre palabras",
    ["book default"] =
        "predeterminado del libro",
    ["hyphenation off"] =
        "partición desactivada",
    ["hyphenation on"] =
        "partición activada",
    ["off"] =
        "desactivado",
    ["on"] =
        "activado",
}
