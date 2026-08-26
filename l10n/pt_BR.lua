--[[--
Brazilian Portuguese translations for the Reading style plugin.

Keys are the English msgids exactly as they appear in the source; anything not
listed here falls back to the English text through readingstyle_gettext.

Regenerate the key list with:
    luajit l10n/tools/extract.lua *.lua > l10n/template.lua
and check this file against it with:
    luajit l10n/tools/validate.lua l10n/template.lua l10n/pt_BR.lua
--]]

return {
    ["\"Fit to text width\" only shrinks images that are too wide. \"Fit to page width\" also enlarges smaller ones, which can stretch images that carry explicit pixel dimensions."] =
        "\"Ajustar à largura do texto\" apenas reduz as imagens largas demais. \"Ajustar à largura da página\" também amplia as menores, o que pode distorcer imagens com dimensões em pixels explícitas.",
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nUnavailable when the book does not declare a language."] =
        "Um estilo separado para livros neste idioma, útil quando um idioma se lê melhor com outras convenções de parágrafo.\n\nIndisponível quando o livro não declara um idioma.",
    ["A style stored with this book alone. It overrides both of the above."] =
        "Um estilo guardado apenas com este livro. Prevalece sobre os dois anteriores.",
    ["About reading style and style tweaks"] =
        "Sobre o estilo de leitura e os ajustes de estilo",
    ["Advanced"] =
        "Avançado",
    ["Align"] =
        "Alinh.",
    ["Aligning images turns them into blocks, which pulls inline images — drop caps, small icons inside a line of text — out of their line. Leave at book default unless you need it."] =
        "Alinhar as imagens as transforma em blocos, o que tira da linha as imagens embutidas — capitulares, ícones pequenos dentro de uma linha de texto. Deixe no padrão do livro a menos que precise.",
    ["Alignment of body text, paragraphs and list items. Headings keep their own alignment setting."] =
        "Alinhamento do corpo do texto, dos parágrafos e dos itens de lista. Os títulos mantêm o próprio alinhamento.",
    ["Alignment of headings. Applies to all six heading levels, so a centred chapter title does not sit above left-aligned sub-headings."] =
        "Alinhamento dos títulos. Vale para os seis níveis, para que um título de capítulo centralizado não fique acima de subtítulos alinhados à esquerda.",
    ["All books"] =
        "Todos os livros",
    ["Applies to h1, h2 and h3 headings.\n\nBooks that do not mark their chapter titles as real headings — a styled paragraph inside a container, say — cannot be reached by any of these settings."] =
        "Aplica-se aos títulos h1, h2 e h3.\n\nLivros que não marcam os títulos de capítulo como títulos de verdade — um parágrafo formatado dentro de um contêiner, por exemplo — não podem ser alcançados por nenhum destes ajustes.",
    ["Apply"] =
        "Aplicar",
    ["Apply changes immediately"] =
        "Aplicar as alterações imediatamente",
    ["Apply now"] =
        "Aplicar agora",
    ["Apply to: %1"] =
        "Aplicar a: %1",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Linha em branco entre os parágrafos, sem recuo, entrelinha e margens generosas. Confortável para olhos cansados.",
    ["Bold"] =
        "Negrito",
    ["Book default"] =
        "Padrão do livro",
    ["Books in %1"] =
        "Livros em %1",
    ["Books in this language"] =
        "Livros neste idioma",
    ["Bottom margin"] =
        "Margem inferior",
    ["Caps every image at the width and height of the page, so oversized images no longer spill past the margins."] =
        "Limita cada imagem à largura e à altura da página, de modo que imagens grandes demais não passem mais das margens.",
    ["Centered"] =
        "Centralizado",
    ["Chapter"] =
        "Capítulo",
    ["Chapter title alignment"] =
        "Alinhamento do título do capítulo",
    ["Chapter title size"] =
        "Tamanho do título do capítulo",
    ["Chapter title style"] =
        "Estilo do título do capítulo",
    ["Chapters"] =
        "Capítulos",
    ["Clears every reading style setting and lets the book look the way its publisher intended."] =
        "Limpa todos os ajustes de estilo de leitura e deixa o livro com a aparência pretendida pela editora.",
    ["Close"] =
        "Fechar",
    ["Compact"] =
        "Compacto",
    ["Current style: %1"] =
        "Estilo atual: %1",
    ["Custom (%1)"] =
        "Personalizado (%1)",
    ["Custom CSS"] =
        "CSS personalizado",
    ["Custom CSS (%1 characters)"] =
        "CSS personalizado (%1 caracteres)",
    ["Custom CSS applied"] =
        "CSS personalizado aplicado",
    ["Cycle reading style presets"] =
        "Alternar entre as predefinições de estilo de leitura",
    ["Discard"] =
        "Descartar",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "Não recuar a primeira linha do parágrafo que vem logo após um título, como manda a convenção tipográfica.\n\nAlcança apenas os parágrafos que seguem diretamente o título. Livros que envolvem o início do capítulo em um contêiner ficam fora de alcance.",
    ["E-reader"] =
        "Leitor digital",
    ["Edit this book's own tweak"] =
        "Editar o ajuste próprio deste livro",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Espaço extra entre as letras. Valores pequenos podem ajudar na legibilidade; acima de cerca de 0,1 em o texto começa a parecer esticado.",
    ["First paragraph after a heading"] =
        "Primeiro parágrafo após um título",
    ["Fit to page width"] =
        "Ajustar à largura da página",
    ["Fit to text width"] =
        "Ajustar à largura do texto",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "CSS escrito à mão, acrescentado depois de tudo o que os controles acima produzem, por isso sempre prevalece. Segue o escopo que você está editando, exatamente como os demais ajustes.",
    ["Header and footer"] =
        "Cabeçalho e rodapé",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Altura de cada linha, em porcentagem. É o ajuste de entrelinha do próprio KOReader, o mesmo que o menu inferior altera.",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Margens horizontais da página. São elas que definem a largura da coluna de texto: margens mais largas resultam em linhas mais estreitas e mais fáceis de percorrer.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "O quanto a primeira linha de cada parágrafo é recuada. Também remove o recuo herdado de contêineres, títulos, itens de lista e células de tabela, que é de onde vêm os recuos dobrados.",
    ["Image alignment"] =
        "Alinhamento da imagem",
    ["Image width"] =
        "Largura da imagem",
    ["Images"] =
        "Imagens",
    ["Indent"] =
        "Recuo",
    ["Italic"] =
        "Itálico",
    ["Justified"] =
        "Justificado",
    ["KOReader's own typography rules, including hyphenation. The language chosen here decides which hyphenation dictionary is used, which is why it lives with the language setting rather than on its own."] =
        "As regras tipográficas do próprio KOReader, incluindo a hifenização. O idioma escolhido aqui determina qual dicionário de hifenização é usado — por isso a hifenização fica junto do ajuste de idioma, e não isolada.",
    ["Lang: %1"] =
        "Idioma: %1",
    ["Left"] =
        "Esquerda",
    ["Left and right margins"] =
        "Margens esquerda e direita",
    ["Letter spacing"] =
        "Espaçamento entre letras",
    ["Line"] =
        "Linha",
    ["Line spacing"] =
        "Entrelinha",
    ["Load reading style preset"] =
        "Carregar predefinição de estilo de leitura",
    ["Margin presets"] =
        "Predefinições de margens",
    ["Narrow"] =
        "Estreitas",
    ["No indentation"] =
        "Sem recuo",
    ["No space above"] =
        "Sem espaço acima",
    ["Normal"] =
        "Normais",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "Em linhas justificadas com vãos muito largos, permite distribuir o espaço excedente dentro das palavras como espaçamento entre letras. Definido como porcentagem do tamanho da fonte.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "Ligado, as alterações aparecem assim que você as faz. Desligado, elas se acumulam e só são aplicadas quando você escolhe \"Aplicar agora\".\n\nCada aplicação renderiza o livro de novo, então desligar vale a pena quando você vai mudar vários ajustes de uma vez.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "Abre o editor de ajuste de estilo específico do livro do KOReader, com suas sugestões de CSS e o formatador. Esse ajuste é guardado pelo KOReader, separadamente deste plugin, e é aplicado antes destes ajustes.",
    ["Original size"] =
        "Tamanho original",
    ["Page layout"] =
        "Layout da página",
    ["Paragraph indentation"] =
        "Recuo de parágrafo",
    ["Paragraphs"] =
        "Parágrafos",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "Controles simples para os ajustes que decidem a aparência de um livro — recuo e espaçamento de parágrafos, espaço em volta dos títulos de capítulo, alinhamento, margens, imagens — com predefinições e estilos por livro ou por idioma.\n\nApoia-se nos ajustes de estilo do KOReader em vez de substituí-los: tudo o que ficar em \"padrão do livro\" deixa intactos os seus ajustes e os estilos da editora.",
    ["Presets"] =
        "Predefinições",
    ["Prettify"] =
        "Formatar",
    ["Prevent images from overflowing the page"] =
        "Impedir que as imagens ultrapassem a página",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "Tipografia de livro impresso: parágrafos recuados sem intervalo entre eles, títulos de capítulo centralizados com espaço acima.",
    ["Publisher default"] =
        "Padrão da editora",
    ["Quick style"] =
        "Estilo rápido",
    ["Reading style"] =
        "Estilo de leitura",
    ["Reading style: %1"] =
        "Estilo de leitura: %1",
    ["Reduction"] =
        "Redução",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Remove o espaço acima do primeiro parágrafo após um título, para que ele fique logo abaixo do título do capítulo.",
    ["Reset"] =
        "Redefinir",
    ["Reset all reading style settings"] =
        "Redefinir todos os ajustes de estilo de leitura",
    ["Reset chapter settings"] =
        "Redefinir os ajustes de capítulo",
    ["Reset image settings"] =
        "Redefinir os ajustes de imagem",
    ["Reset paragraph settings"] =
        "Redefinir os ajustes de parágrafo",
    ["Reset text settings"] =
        "Redefinir os ajustes de texto",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "Redefinir os ajustes do título do capítulo para os padrões da editora?",
    ["Reset the image settings to the publisher's defaults?"] =
        "Redefinir os ajustes de imagem para os padrões da editora?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "Redefinir os ajustes de parágrafo para os padrões da editora?",
    ["Reset the text settings this plugin controls to the publisher's defaults?\n\nLine spacing and word spacing belong to KOReader and are left alone."] =
        "Redefinir para os padrões da editora os ajustes de texto controlados por este plugin?\n\nA entrelinha e o espaçamento entre palavras pertencem ao KOReader e ficam intactos.",
    ["Right"] =
        "Direita",
    ["Save current reading style as preset"] =
        "Salvar o estilo atual como predefinição",
    ["Scaling"] =
        "Escala",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Tamanho dos títulos de capítulo, como porcentagem do texto ao redor.\n\n",
    ["Space after chapter title"] =
        "Espaço depois do título do capítulo",
    ["Space before chapter title"] =
        "Espaço antes do título do capítulo",
    ["Space below the text. The status bar, when shown at the bottom, takes its height from here."] =
        "Espaço abaixo do texto. A barra de status, quando exibida embaixo, tira daqui a sua altura.",
    ["Space between paragraphs"] =
        "Espaço entre parágrafos",
    ["Spacing"] =
        "Espaço",
    ["Spacious"] =
        "Espaçoso",
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "Toque para alternar: padrão do livro, ligado, desligado.\n\n\"Desligado\" não é a mesma coisa que \"padrão do livro\": ele tira ativamente o negrito dos títulos que a editora deixou em negrito.",
    ["Text"] =
        "Texto",
    ["Text alignment"] =
        "Alinhamento do texto",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "A aparência familiar de leitor digital: sem recuo, um pequeno intervalo entre parágrafos e espaçamentos moderados em tudo.",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "Os ajustes mais usados, em uma única tela. Também pode ser aberto por um gesto.",
    ["The settings you made for the narrower scope will be discarded, and the broader style takes over.\n\nContinue?"] =
        "Os ajustes feitos para o escopo mais restrito serão descartados, e o estilo do escopo mais amplo assume.\n\nContinuar?",
    ["The style you edit here is used for every book that has no style of its own."] =
        "O estilo editado aqui vale para todo livro que não tenha um estilo próprio.",
    ["This book"] =
        "Este livro",
    ["This book only"] =
        "Somente este livro",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "Este plugin escreve uma pequena folha de estilos e a acrescenta depois dos seus ajustes de estilo, de modo que os valores dele prevalecem onde os dois se sobrepõem.\n\nTudo o que ficar em \"padrão do livro\" não gera nada e deixa intactos os seus ajustes e os estilos da editora.\n\nCada alteração renderiza o livro de novo. Isso é normal, e é o que o KOReader faz em qualquer mudança de estilo.",
    ["This restores every reading style setting in the current scope to the publisher's defaults.\n\nKOReader's own settings — line spacing, margins, word spacing — are left alone."] =
        "Isto devolve todos os ajustes de estilo de leitura do escopo atual aos padrões da editora.\n\nOs ajustes do próprio KOReader — entrelinha, margens, espaçamento entre palavras — ficam intactos.",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "Linhas apertadas e margens pequenas, sem espaço entre parágrafos. Coloca o máximo de texto em uma página.",
    ["Top margin"] =
        "Margem superior",
    ["Traditional"] =
        "Tradicional",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "São dois números, e só o primeiro afasta as palavras.\n\nA escala é a largura de cada espaço, como porcentagem do espaço da própria fonte. 100 % é a largura natural, e o padrão do KOReader é 95 % — um pouco mais estreito. Passe de 100 % para obter vãos maiores.\n\nA redução diz o quanto a justificação pode comprimir esses espaços de volta para caber mais uma palavra na linha. 100 % proíbe a compressão, então aumente-a também, ou os vãos maiores não se mantêm.",
    ["Typography and hyphenation: %1"] =
        "Tipografia e hifenização: %1",
    ["Uppercase"] =
        "Maiúsculas",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Espaço vertical entre parágrafos. As margens de parágrafo da editora são removidas primeiro, de modo que o valor escolhido é exatamente o obtido, em vez de ser somado ao existente.",
    ["Whitespace above chapter and section titles, so a chapter does not start flush against the top of the page.\n\n"] =
        "Espaço em branco acima dos títulos de capítulo e de seção, para que um capítulo não comece colado ao topo da página.\n\n",
    ["Whitespace between a chapter title and the text that follows it.\n\n"] =
        "Espaço em branco entre um título de capítulo e o texto que vem depois dele.\n\n",
    ["Wide"] =
        "Largas",
    ["Word expansion"] =
        "Expansão de palavras",
    ["Word spacing"] =
        "Espaçamento entre palavras",
    ["book default"] =
        "padrão do livro",
    ["hyphenation off"] =
        "hifenização desligada",
    ["hyphenation on"] =
        "hifenização ligada",
    ["off"] =
        "desligado",
    ["on"] =
        "ligado",
}
