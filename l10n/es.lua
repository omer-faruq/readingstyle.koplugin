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
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nThe language comes from the book's own metadata. When a book declares none this is greyed out, but you can give it one yourself: Book information, hold the language field, and set it. Reopen the book afterwards."] =
        "Un estilo aparte para los libros en este idioma, útil cuando un idioma se lee mejor con otras convenciones de párrafo.\n\nEl idioma procede de los metadatos del propio libro. Cuando un libro no declara ninguno, esta opción aparece atenuada; pero puede asignarlo usted: Información del libro, mantenga pulsado el campo de idioma y establézcalo. Después vuelva a abrir el libro.",
    ["A style stored with this book alone.\n\nSwitching between these three only changes which one you are editing and which one this book uses. The others keep their settings."] =
        "Un estilo guardado solo con este libro.\n\nCambiar entre estos tres niveles solo cambia cuál está editando y cuál usa este libro. Los demás conservan sus ajustes.",
    ["A thin line under chapter titles, in the manner of an older printed book."] =
        "Una línea fina bajo los títulos de capítulo, al modo de un libro impreso antiguo.",
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
    ["Avoid widows and orphans"] =
        "Evitar viudas y huérfanas",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Línea en blanco entre párrafos, sin sangría, interlineado y márgenes generosos. Descansa la vista cansada.",
    ["Block quotes"] =
        "Citas en bloque",
    ["Bold"] =
        "Negrita",
    ["Bold instead of italic"] =
        "Negrita en lugar de cursiva",
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
    ["Clears tinted boxes and page backgrounds. On a greyscale screen these become flat grey blocks that make the text on them harder to read."] =
        "Elimina los recuadros de color y los fondos de página. En una pantalla en escala de grises se convierten en bloques grises planos que dificultan la lectura del texto que llevan encima.",
    ["Close"] =
        "Cerrar",
    ["Compact"] =
        "Compacto",
    ["Could not write the file: %1"] =
        "No se pudo escribir el archivo: %1",
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
    ["Delete"] =
        "Eliminar",
    ["Delete the %1 style"] =
        "Eliminar el estilo de %1",
    ["Delete the style for this language"] =
        "Eliminar el estilo de este idioma",
    ["Delete the style stored at that level?"] =
        "¿Eliminar el estilo guardado en ese nivel?",
    ["Delete this book's style"] =
        "Eliminar el estilo de este libro",
    ["Deletes the style stored at that level. Editing moves to the next level up, and its style takes over."] =
        "Elimina el estilo guardado en ese nivel. La edición pasa al nivel superior y su estilo toma el relevo.",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "No sangrar la primera línea del párrafo que sigue a un encabezado, como manda la convención tipográfica.\n\nSolo alcanza a los párrafos que siguen directamente al encabezado. Los libros que envuelven el comienzo del capítulo en un contenedor quedan fuera de alcance.",
    ["E-reader"] =
        "Lector electrónico",
    ["Edit this book's own tweak"] =
        "Editar el ajuste propio de este libro",
    ["Emphasis"] =
        "Énfasis",
    ["Exactly what this plugin is appending to your stylesheet right now. Worth pasting into a bug report."] =
        "Exactamente lo que esta extensión está añadiendo a su hoja de estilos ahora mismo. Vale la pena pegarlo en un informe de error.",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Espacio adicional entre letras. Valores pequeños pueden mejorar la legibilidad; por encima de unos 0,1 em el texto empieza a verse estirado.",
    ["First paragraph after a heading"] =
        "Primer párrafo tras un encabezado",
    ["Fit to page width"] =
        "Ajustar al ancho de la página",
    ["Fit to text width"] =
        "Ajustar al ancho del texto",
    ["Font weight"] =
        "Grosor de la fuente",
    ["Footnote markers and cross-references are usually blue, which renders as a mid grey."] =
        "Las llamadas de nota y las referencias cruzadas suelen ser azules, lo que se ve como un gris medio.",
    ["Force a page break before each chapter title, the way a printed book does.\n\nChoosing H1 and H2 also keeps a subtitle from starting a second page of its own."] =
        "Fuerza un salto de página antes de cada título de capítulo, como en un libro impreso.\n\nCon H1 y H2, un subtítulo tampoco empieza una segunda página por su cuenta.",
    ["Force black text"] =
        "Forzar texto en negro",
    ["H1 and H2"] =
        "H1 y H2",
    ["H1 only"] =
        "Solo H1",
    ["H1, H2 and H3"] =
        "H1, H2 y H3",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "CSS escrito a mano, añadido después de todo lo que producen los controles anteriores, por lo que siempre prevalece. Sigue el ámbito que esté editando, igual que el resto de los ajustes.",
    ["Header and footer"] =
        "Encabezado y pie de página",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Altura de cada línea, en porcentaje. Es el ajuste de interlineado propio de KOReader, el mismo que cambia el menú inferior.",
    ["Hide images"] =
        "Ocultar imágenes",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Márgenes horizontales de la página. Son los que fijan el ancho de la columna de texto: márgenes más anchos dan una línea más estrecha y más fácil de recorrer.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "Cuánto se sangra la primera línea de cada párrafo. También elimina la sangría heredada de contenedores, encabezados, elementos de lista y celdas de tabla, de donde vienen las sangrías duplicadas.",
    ["How quoted passages are set apart from the body text. \"No special treatment\" clears the publisher's own indentation and italics instead of adding to them."] =
        "Cómo se distinguen los pasajes citados del cuerpo del texto. «Sin tratamiento especial» elimina la sangría y la cursiva de la editorial en lugar de sumarse a ellas.",
    ["Image alignment"] =
        "Alineación de imagen",
    ["Image width"] =
        "Ancho de imagen",
    ["Images"] =
        "Imágenes",
    ["Indent"] =
        "Sangría",
    ["Indented"] =
        "Con sangría",
    ["Indented and italic"] =
        "Con sangría y en cursiva",
    ["Ink and links"] =
        "Tinta y enlaces",
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
    ["Lets preformatted blocks — code listings, terminal output — wrap instead of running off the edge of the page."] =
        "Permite que los bloques preformateados —listados de código, salidas de terminal— pasen de línea en lugar de salirse del borde de la página.",
    ["Letter spacing"] =
        "Espaciado entre letras",
    ["Line"] =
        "Línea",
    ["Line spacing"] =
        "Interlineado",
    ["Links in black"] =
        "Enlaces en negro",
    ["Links without underline"] =
        "Enlaces sin subrayado",
    ["Load reading style preset"] =
        "Cargar preajuste de estilo de lectura",
    ["Makes the text heavier or lighter than the font's own weight. A small increase is the most effective answer to a font that prints faintly on e-ink.\n\nThis is KOReader's own font weight setting."] =
        "Hace el texto más grueso o más fino que el grosor propio de la fuente. Un aumento pequeño es la respuesta más eficaz a una fuente que se imprime pálida en tinta electrónica.\n\nEs el ajuste de grosor propio de KOReader.",
    ["Margin presets"] =
        "Preajustes de márgenes",
    ["Narrow"] =
        "Estrechos",
    ["Needs a font that can produce small capitals, or the reader's font will synthesise them and the result can look uneven."] =
        "Necesita una fuente con versalitas reales; de lo contrario la fuente las simula y el resultado puede verse irregular.",
    ["No indentation"] =
        "Sin sangría",
    ["No space above"] =
        "Sin espacio encima",
    ["No special treatment"] =
        "Sin tratamiento especial",
    ["Normal"] =
        "Normales",
    ["Nothing is being generated: every setting is at book default."] =
        "No se está generando nada: todos los ajustes están en el valor predeterminado del libro.",
    ["On H1"] =
        "En H1",
    ["On H1 and H2"] =
        "En H1 y H2",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "En líneas justificadas con huecos muy anchos, permite repartir el espacio sobrante dentro de las palabras como espaciado entre letras. Se indica como porcentaje del tamaño de fuente.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "Activado, los cambios aparecen en cuanto los hace. Desactivado, se acumulan y solo se aplican cuando elige «Aplicar ahora».\n\nCada aplicación vuelve a componer el libro, así que desactivarlo compensa cuando va a cambiar varios ajustes seguidos.",
    ["Only the settings this plugin owns travel with a language: indentation, spacing, alignment, chapter titles, images, custom CSS.\n\nLine spacing, margins and word spacing belong to KOReader, which stores them per book and has no notion of a language, so they stay where they are."] =
        "Con un idioma solo viajan los ajustes propios de esta extensión: sangría, espaciado, alineación, títulos de capítulo, imágenes y CSS personalizado.\n\nEl interlineado, los márgenes y el espaciado entre palabras pertenecen a KOReader, que los guarda por libro y no sabe nada de idiomas, así que se quedan donde están.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "Abre el editor de ajustes de estilo específicos del libro de KOReader, con sus sugerencias de CSS y su formateador. Ese ajuste lo guarda KOReader, aparte de esta extensión, y se aplica antes que estos ajustes.",
    ["Original size"] =
        "Tamaño original",
    ["Overrides every colour the publisher chose, including the greys used for asides and captions, which print faintly on e-ink.\n\nAlso blackens borders."] =
        "Sustituye todos los colores elegidos por la editorial, incluidos los grises de los apartes y los pies de foto, que salen pálidos en tinta electrónica.\n\nTambién ennegrece los bordes.",
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
    ["Puts everything this menu marks as changed back to default, at the level you are editing: this plugin's settings return to book default, and KOReader's own — line spacing, word spacing, font weight, margins — return to theirs.\n\nStyles stored at the other levels are not touched; deleting those is a separate action."] =
        "Devuelve al valor predeterminado todo lo que este menú marca como cambiado, en el nivel que está editando: los ajustes de esta extensión vuelven al predeterminado del libro y los propios de KOReader —interlineado, espaciado entre palabras, grosor, márgenes— a los suyos.\n\nLos estilos guardados en los otros niveles no se tocan; eliminarlos es una acción aparte.",
    ["Quick style"] =
        "Estilo rápido",
    ["Reading style"] =
        "Estilo de lectura",
    ["Reading style: %1"] =
        "Estilo de lectura: %1",
    ["Reduction"] =
        "Reducción",
    ["Remove background colours"] =
        "Quitar los colores de fondo",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Elimina el espacio sobre el primer párrafo tras un encabezado, de modo que quede justo debajo del título de capítulo.",
    ["Removes every image from the page, for reading a heavily illustrated book as plain text.\n\nCaptions stay, since they are ordinary text."] =
        "Quita todas las imágenes de la página, para leer un libro muy ilustrado como texto sin más.\n\nLos pies de foto se quedan, porque son texto corriente.",
    ["Replace"] =
        "Reemplazar",
    ["Replaces italics with something else. Worth it when a book's italic face is thin or hard to read on screen."] =
        "Sustituye la cursiva por otra cosa. Útil cuando la cursiva de un libro es fina o cuesta leerla en pantalla.",
    ["Reset"] =
        "Restablecer",
    ["Reset all four margins to their defaults?"] =
        "¿Restablecer los cuatro márgenes a sus valores predeterminados?",
    ["Reset all reading style settings"] =
        "Restablecer todos los ajustes de estilo de lectura",
    ["Reset chapter settings"] =
        "Restablecer los ajustes de capítulo",
    ["Reset every text setting in this section, including KOReader's own line spacing, word spacing, word expansion and font weight?"] =
        "¿Restablecer todos los ajustes de texto de esta sección, incluidos el interlineado, el espaciado entre palabras, la expansión de palabras y el grosor propios de KOReader?",
    ["Reset image settings"] =
        "Restablecer los ajustes de imagen",
    ["Reset ink settings"] =
        "Restablecer los ajustes de tinta",
    ["Reset margins"] =
        "Restablecer los márgenes",
    ["Reset paragraph settings"] =
        "Restablecer los ajustes de párrafo",
    ["Reset text settings"] =
        "Restablecer los ajustes de texto",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "¿Restablecer los ajustes del título de capítulo a los valores de la editorial?",
    ["Reset the colour and link settings to the publisher's defaults?"] =
        "¿Restablecer los ajustes de color y enlaces a los valores de la editorial?",
    ["Reset the image settings to the publisher's defaults?"] =
        "¿Restablecer los ajustes de imagen a los valores de la editorial?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "¿Restablecer los ajustes de párrafo a los valores de la editorial?",
    ["Right"] =
        "Derecha",
    ["Rule under the title"] =
        "Línea bajo el título",
    ["Save as a style tweak"] =
        "Guardar como ajuste de estilo",
    ["Save current reading style as preset"] =
        "Guardar el estilo actual como preajuste",
    ["Saved to %1\n\nIt appears under Style tweaks, in User style tweaks, once KOReader is restarted."] =
        "Guardado en %1\n\nAparece en Ajustes de estilo, dentro de los ajustes del usuario, tras reiniciar KOReader.",
    ["Scaling"] =
        "Escalado",
    ["Shrinks footnote markers and the like, and stops them from stretching the line they sit on."] =
        "Reduce las llamadas de nota y similares, y evita que estiren la línea en la que están.",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Tamaño de los títulos de capítulo, como porcentaje del texto que los rodea.\n\n",
    ["Small capitals"] =
        "Versalitas",
    ["Smaller sub- and superscript"] =
        "Subíndices y superíndices más pequeños",
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
    ["Start chapters on a new page"] =
        "Empezar los capítulos en una página nueva",
    ["Stop a paragraph from leaving a single line stranded at the top or bottom of a page.\n\nPages end less evenly as a result, and the page count shifts."] =
        "Impide que un párrafo deje una sola línea suelta al principio o al final de una página.\n\nLas páginas terminan de forma menos pareja y la paginación se desplaza.",
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
    ["The style you edit here is used for every book that has no style of its own."] =
        "El estilo que edite aquí se usa en todos los libros que no tengan un estilo propio.",
    ["This book"] =
        "Este libro",
    ["This book only"] =
        "Solo este libro",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "Esta extensión escribe una pequeña hoja de estilos y la añade después de sus ajustes de estilo, de modo que sus valores prevalecen allí donde ambos se solapan.\n\nTodo lo que quede en «predeterminado del libro» no genera nada en absoluto y deja intactos sus ajustes y los estilos de la editorial.\n\nCada cambio vuelve a componer el libro. Es normal: KOReader hace lo mismo con cualquier cambio de estilo.",
    ["This replaces the style already stored at that level with the settings you are looking at now.\n\nContinue?"] =
        "Esto sustituye el estilo ya guardado en ese nivel por los ajustes que tiene ahora delante.\n\n¿Continuar?",
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
    ["Underlined instead of italic"] =
        "Subrayado en lugar de cursiva",
    ["Uppercase"] =
        "Mayúsculas",
    ["Use these settings for all books"] =
        "Usar estos ajustes para todos los libros",
    ["Use these settings for all books in %1"] =
        "Usar estos ajustes para todos los libros en %1",
    ["Use these settings for all books in this language"] =
        "Usar estos ajustes para todos los libros en este idioma",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Espacio vertical entre párrafos. Los márgenes de párrafo de la editorial se eliminan primero, de modo que el valor elegido es exactamente el que se obtiene en lugar de sumarse al existente.",
    ["View generated CSS"] =
        "Ver el CSS generado",
    ["What counts as a chapter"] =
        "Qué cuenta como capítulo",
    ["Which heading levels the settings below apply to.\n\nMost books mark chapters as H1, many use H2, and a few use H3. Including H3 in a book full of sub-headings will space out things that are not chapters at all.\n\nAlignment is deliberately left out of this: it always applies to every heading level."] =
        "A qué niveles de encabezado se aplican los ajustes de abajo.\n\nLa mayoría de los libros marcan los capítulos como H1, muchos usan H2 y unos pocos H3. Incluir H3 en un libro lleno de subtítulos separará cosas que no son capítulos.\n\nLa alineación queda fuera a propósito: siempre se aplica a los seis niveles.",
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
    ["Wrap long code lines"] =
        "Ajustar las líneas de código largas",
    ["Writes the generated CSS into KOReader's own user style tweaks folder, where it works without this plugin. A way out that does not cost you your settings."] =
        "Escribe el CSS generado en la carpeta de ajustes de estilo de KOReader, donde funciona sin esta extensión. Una salida que no le cuesta sus ajustes.",
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
