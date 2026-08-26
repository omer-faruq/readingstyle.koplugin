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
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nThe language comes from the book's own metadata. When a book declares none this is greyed out, but you can give it one yourself: Book information, hold the language field, and set it. Reopen the book afterwards."] =
        "Um estilo separado para livros neste idioma, útil quando um idioma se lê melhor com outras convenções de parágrafo.\n\nO idioma vem dos metadados do próprio livro. Quando um livro não declara nenhum, esta opção fica esmaecida; mas você pode definir um: Informações do livro, segure o campo de idioma e preencha. Depois reabra o livro.",
    ["A style stored with this book alone.\n\nSwitching between these three only changes which one you are editing and which one this book uses. The others keep their settings."] =
        "Um estilo guardado apenas com este livro.\n\nAlternar entre estes três níveis muda somente qual você está editando e qual este livro usa. Os outros mantêm seus ajustes.",
    ["A thin line under chapter titles, in the manner of an older printed book."] =
        "Uma linha fina sob os títulos de capítulo, à maneira de um livro impresso antigo.",
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
    ["Avoid widows and orphans"] =
        "Evitar viúvas e órfãs",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Linha em branco entre os parágrafos, sem recuo, entrelinha e margens generosas. Confortável para olhos cansados.",
    ["Block quotes"] =
        "Citações em bloco",
    ["Bold"] =
        "Negrito",
    ["Bold instead of italic"] =
        "Negrito em vez de itálico",
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
    ["Clears tinted boxes and page backgrounds. On a greyscale screen these become flat grey blocks that make the text on them harder to read."] =
        "Remove caixas coloridas e fundos de página. Numa tela em tons de cinza elas viram blocos cinzentos chapados que dificultam a leitura do texto sobre eles.",
    ["Close"] =
        "Fechar",
    ["Compact"] =
        "Compacto",
    ["Could not write the file: %1"] =
        "Não foi possível gravar o arquivo: %1",
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
    ["Delete"] =
        "Excluir",
    ["Delete the %1 style"] =
        "Excluir o estilo de %1",
    ["Delete the style for this language"] =
        "Excluir o estilo deste idioma",
    ["Delete the style stored at that level?"] =
        "Excluir o estilo guardado nesse nível?",
    ["Delete this book's style"] =
        "Excluir o estilo deste livro",
    ["Deletes the style stored at that level. Editing moves to the next level up, and its style takes over."] =
        "Exclui o estilo guardado nesse nível. A edição passa para o nível acima, e o estilo dele assume.",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "Não recuar a primeira linha do parágrafo que vem logo após um título, como manda a convenção tipográfica.\n\nAlcança apenas os parágrafos que seguem diretamente o título. Livros que envolvem o início do capítulo em um contêiner ficam fora de alcance.",
    ["E-reader"] =
        "Leitor digital",
    ["Edit this book's own tweak"] =
        "Editar o ajuste próprio deste livro",
    ["Emphasis"] =
        "Ênfase",
    ["Exactly what this plugin is appending to your stylesheet right now. Worth pasting into a bug report."] =
        "Exatamente o que este plugin está acrescentando à sua folha de estilos agora. Vale colar num relatório de erro.",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Espaço extra entre as letras. Valores pequenos podem ajudar na legibilidade; acima de cerca de 0,1 em o texto começa a parecer esticado.",
    ["First paragraph after a heading"] =
        "Primeiro parágrafo após um título",
    ["Fit to page width"] =
        "Ajustar à largura da página",
    ["Fit to text width"] =
        "Ajustar à largura do texto",
    ["Font weight"] =
        "Peso da fonte",
    ["Footnote markers and cross-references are usually blue, which renders as a mid grey."] =
        "Chamadas de nota e remissões costumam ser azuis, o que aparece como um cinza médio.",
    ["Force a page break before each chapter title, the way a printed book does.\n\nChoosing H1 and H2 also keeps a subtitle from starting a second page of its own."] =
        "Força uma quebra de página antes de cada título de capítulo, como num livro impresso.\n\nCom H1 e H2, um subtítulo também não começa uma segunda página só para ele.",
    ["Force black text"] =
        "Forçar texto preto",
    ["H1 and H2"] =
        "H1 e H2",
    ["H1 only"] =
        "Apenas H1",
    ["H1, H2 and H3"] =
        "H1, H2 e H3",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "CSS escrito à mão, acrescentado depois de tudo o que os controles acima produzem, por isso sempre prevalece. Segue o escopo que você está editando, exatamente como os demais ajustes.",
    ["Header and footer"] =
        "Cabeçalho e rodapé",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Altura de cada linha, em porcentagem. É o ajuste de entrelinha do próprio KOReader, o mesmo que o menu inferior altera.",
    ["Hide images"] =
        "Ocultar imagens",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Margens horizontais da página. São elas que definem a largura da coluna de texto: margens mais largas resultam em linhas mais estreitas e mais fáceis de percorrer.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "O quanto a primeira linha de cada parágrafo é recuada. Também remove o recuo herdado de contêineres, títulos, itens de lista e células de tabela, que é de onde vêm os recuos dobrados.",
    ["How quoted passages are set apart from the body text. \"No special treatment\" clears the publisher's own indentation and italics instead of adding to them."] =
        "Como as passagens citadas se destacam do corpo do texto. \"Sem tratamento especial\" remove o recuo e o itálico da editora em vez de somar-se a eles.",
    ["Image alignment"] =
        "Alinhamento da imagem",
    ["Image width"] =
        "Largura da imagem",
    ["Images"] =
        "Imagens",
    ["Indent"] =
        "Recuo",
    ["Indented"] =
        "Recuado",
    ["Indented and italic"] =
        "Recuado e em itálico",
    ["Ink and links"] =
        "Tinta e links",
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
    ["Lets preformatted blocks — code listings, terminal output — wrap instead of running off the edge of the page."] =
        "Permite que blocos pré-formatados — listagens de código, saída de terminal — quebrem a linha em vez de passar da borda da página.",
    ["Letter spacing"] =
        "Espaçamento entre letras",
    ["Line"] =
        "Linha",
    ["Line spacing"] =
        "Entrelinha",
    ["Links in black"] =
        "Links em preto",
    ["Links without underline"] =
        "Links sem sublinhado",
    ["Load reading style preset"] =
        "Carregar predefinição de estilo de leitura",
    ["Makes the text heavier or lighter than the font's own weight. A small increase is the most effective answer to a font that prints faintly on e-ink.\n\nThis is KOReader's own font weight setting."] =
        "Deixa o texto mais pesado ou mais leve que o peso próprio da fonte. Um aumento pequeno é a resposta mais eficaz a uma fonte que imprime fraca em e-ink.\n\nEste é o ajuste de peso da fonte do próprio KOReader.",
    ["Margin presets"] =
        "Predefinições de margens",
    ["Narrow"] =
        "Estreitas",
    ["Needs a font that can produce small capitals, or the reader's font will synthesise them and the result can look uneven."] =
        "Requer uma fonte com versaletes de verdade; caso contrário a fonte os simula e o resultado pode ficar irregular.",
    ["No indentation"] =
        "Sem recuo",
    ["No space above"] =
        "Sem espaço acima",
    ["No special treatment"] =
        "Sem tratamento especial",
    ["Normal"] =
        "Normais",
    ["Nothing is being generated: every setting is at book default."] =
        "Nada está sendo gerado: todos os ajustes estão no padrão do livro.",
    ["On H1"] =
        "Em H1",
    ["On H1 and H2"] =
        "Em H1 e H2",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "Em linhas justificadas com vãos muito largos, permite distribuir o espaço excedente dentro das palavras como espaçamento entre letras. Definido como porcentagem do tamanho da fonte.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "Ligado, as alterações aparecem assim que você as faz. Desligado, elas se acumulam e só são aplicadas quando você escolhe \"Aplicar agora\".\n\nCada aplicação renderiza o livro de novo, então desligar vale a pena quando você vai mudar vários ajustes de uma vez.",
    ["Only the settings this plugin owns travel with a language: indentation, spacing, alignment, chapter titles, images, custom CSS.\n\nLine spacing, margins and word spacing belong to KOReader, which stores them per book and has no notion of a language, so they stay where they are."] =
        "Com um idioma viajam apenas os ajustes que pertencem a este plugin: recuo, espaçamento, alinhamento, títulos de capítulo, imagens e CSS personalizado.\n\nA entrelinha, as margens e o espaçamento entre palavras pertencem ao KOReader, que os guarda por livro e não conhece idiomas, então ficam onde estão.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "Abre o editor de ajuste de estilo específico do livro do KOReader, com suas sugestões de CSS e o formatador. Esse ajuste é guardado pelo KOReader, separadamente deste plugin, e é aplicado antes destes ajustes.",
    ["Original size"] =
        "Tamanho original",
    ["Overrides every colour the publisher chose, including the greys used for asides and captions, which print faintly on e-ink.\n\nAlso blackens borders."] =
        "Sobrepõe todas as cores escolhidas pela editora, inclusive os cinzas usados em notas laterais e legendas, que saem fracos em e-ink.\n\nTambém escurece as bordas.",
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
    ["Puts everything this menu marks as changed back to default, at the level you are editing: this plugin's settings return to book default, and KOReader's own — line spacing, word spacing, font weight, margins — return to theirs.\n\nStyles stored at the other levels are not touched; deleting those is a separate action."] =
        "Devolve ao padrão tudo o que este menu marca como alterado, no nível que você está editando: os ajustes deste plugin voltam ao padrão do livro e os do próprio KOReader — entrelinha, espaçamento entre palavras, peso da fonte, margens — voltam aos deles.\n\nOs estilos guardados nos outros níveis não são tocados; excluí-los é uma ação separada.",
    ["Quick style"] =
        "Estilo rápido",
    ["Reading style"] =
        "Estilo de leitura",
    ["Reading style: %1"] =
        "Estilo de leitura: %1",
    ["Reduction"] =
        "Redução",
    ["Remove background colours"] =
        "Remover as cores de fundo",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Remove o espaço acima do primeiro parágrafo após um título, para que ele fique logo abaixo do título do capítulo.",
    ["Removes every image from the page, for reading a heavily illustrated book as plain text.\n\nCaptions stay, since they are ordinary text."] =
        "Remove todas as imagens da página, para ler um livro muito ilustrado como texto puro.\n\nAs legendas ficam, pois são texto comum.",
    ["Replace"] =
        "Substituir",
    ["Replaces italics with something else. Worth it when a book's italic face is thin or hard to read on screen."] =
        "Substitui o itálico por outra coisa. Vale a pena quando o itálico do livro é fino ou difícil de ler na tela.",
    ["Reset"] =
        "Redefinir",
    ["Reset all four margins to their defaults?"] =
        "Redefinir as quatro margens para os valores padrão?",
    ["Reset all reading style settings"] =
        "Redefinir todos os ajustes de estilo de leitura",
    ["Reset chapter settings"] =
        "Redefinir os ajustes de capítulo",
    ["Reset every text setting in this section, including KOReader's own line spacing, word spacing, word expansion and font weight?"] =
        "Redefinir todos os ajustes de texto desta seção, incluindo a entrelinha, o espaçamento entre palavras, a expansão de palavras e o peso da fonte do próprio KOReader?",
    ["Reset image settings"] =
        "Redefinir os ajustes de imagem",
    ["Reset ink settings"] =
        "Redefinir os ajustes de tinta",
    ["Reset margins"] =
        "Redefinir as margens",
    ["Reset paragraph settings"] =
        "Redefinir os ajustes de parágrafo",
    ["Reset text settings"] =
        "Redefinir os ajustes de texto",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "Redefinir os ajustes do título do capítulo para os padrões da editora?",
    ["Reset the colour and link settings to the publisher's defaults?"] =
        "Redefinir os ajustes de cor e de links para os padrões da editora?",
    ["Reset the image settings to the publisher's defaults?"] =
        "Redefinir os ajustes de imagem para os padrões da editora?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "Redefinir os ajustes de parágrafo para os padrões da editora?",
    ["Right"] =
        "Direita",
    ["Rule under the title"] =
        "Linha sob o título",
    ["Save as a style tweak"] =
        "Salvar como ajuste de estilo",
    ["Save current reading style as preset"] =
        "Salvar o estilo atual como predefinição",
    ["Saved to %1\n\nIt appears under Style tweaks, in User style tweaks, once KOReader is restarted."] =
        "Salvo em %1\n\nAparece em Ajustes de estilo, entre os ajustes do usuário, depois de reiniciar o KOReader.",
    ["Scaling"] =
        "Escala",
    ["Shrinks footnote markers and the like, and stops them from stretching the line they sit on."] =
        "Diminui chamadas de nota e afins, e impede que estiquem a linha em que estão.",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Tamanho dos títulos de capítulo, como porcentagem do texto ao redor.\n\n",
    ["Small capitals"] =
        "Versaletes",
    ["Smaller sub- and superscript"] =
        "Subscrito e sobrescrito menores",
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
    ["Start chapters on a new page"] =
        "Começar os capítulos em uma nova página",
    ["Stop a paragraph from leaving a single line stranded at the top or bottom of a page.\n\nPages end less evenly as a result, and the page count shifts."] =
        "Impede que um parágrafo deixe uma única linha solta no topo ou no pé de uma página.\n\nAs páginas terminam de forma menos uniforme e a paginação se desloca.",
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
    ["The style you edit here is used for every book that has no style of its own."] =
        "O estilo editado aqui vale para todo livro que não tenha um estilo próprio.",
    ["This book"] =
        "Este livro",
    ["This book only"] =
        "Somente este livro",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "Este plugin escreve uma pequena folha de estilos e a acrescenta depois dos seus ajustes de estilo, de modo que os valores dele prevalecem onde os dois se sobrepõem.\n\nTudo o que ficar em \"padrão do livro\" não gera nada e deixa intactos os seus ajustes e os estilos da editora.\n\nCada alteração renderiza o livro de novo. Isso é normal, e é o que o KOReader faz em qualquer mudança de estilo.",
    ["This replaces the style already stored at that level with the settings you are looking at now.\n\nContinue?"] =
        "Isto substitui o estilo já guardado nesse nível pelos ajustes que você está vendo agora.\n\nContinuar?",
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
    ["Underlined instead of italic"] =
        "Sublinhado em vez de itálico",
    ["Uppercase"] =
        "Maiúsculas",
    ["Use these settings for all books"] =
        "Usar estes ajustes para todos os livros",
    ["Use these settings for all books in %1"] =
        "Usar estes ajustes para todos os livros em %1",
    ["Use these settings for all books in this language"] =
        "Usar estes ajustes para todos os livros neste idioma",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Espaço vertical entre parágrafos. As margens de parágrafo da editora são removidas primeiro, de modo que o valor escolhido é exatamente o obtido, em vez de ser somado ao existente.",
    ["View generated CSS"] =
        "Ver o CSS gerado",
    ["What counts as a chapter"] =
        "O que conta como capítulo",
    ["Which heading levels the settings below apply to.\n\nMost books mark chapters as H1, many use H2, and a few use H3. Including H3 in a book full of sub-headings will space out things that are not chapters at all.\n\nAlignment is deliberately left out of this: it always applies to every heading level."] =
        "A quais níveis de título os ajustes abaixo se aplicam.\n\nA maioria dos livros marca capítulos como H1, muitos usam H2 e alguns poucos, H3. Incluir H3 num livro cheio de subtítulos vai espaçar coisas que não são capítulos.\n\nO alinhamento fica de fora de propósito: ele sempre vale para todos os níveis de título.",
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
    ["Wrap long code lines"] =
        "Quebrar linhas de código longas",
    ["Writes the generated CSS into KOReader's own user style tweaks folder, where it works without this plugin. A way out that does not cost you your settings."] =
        "Grava o CSS gerado na pasta de ajustes de estilo do próprio KOReader, onde ele funciona sem este plugin. Uma saída que não custa os seus ajustes.",
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
