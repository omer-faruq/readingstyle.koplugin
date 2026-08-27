--[[--
Simplified Chinese translations for the Reading style plugin.

Keys are the English msgids exactly as they appear in the source; anything not
listed here falls back to the English text through readingstyle_gettext.

Regenerate the key list with:
    luajit l10n/tools/extract.lua *.lua > l10n/template.lua
and check this file against it with:
    luajit l10n/tools/validate.lua l10n/template.lua l10n/zh_CN.lua
--]]

return {
    ["\"Fit to text width\" only shrinks images that are too wide. \"Fit to page width\" also enlarges smaller ones, which can stretch images that carry explicit pixel dimensions."] =
        "“适应文本宽度”只缩小过宽的图片。“适应页面宽度”还会放大较小的图片，这可能拉伸带有明确像素尺寸的图片。",
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nThe language comes from the book's own metadata. When a book declares none this is greyed out, but you can give it one yourself: Book information, hold the language field, and set it. Reopen the book afterwards."] =
        "为该语言的书籍单独设置样式；当某种语言采用不同的段落习惯更易阅读时很有用。\n\n语言取自书籍自身的元数据。若书籍未声明语言，此项显示为灰色；不过你可以自己指定：进入书籍信息，长按语言字段并设置。之后重新打开该书。",
    ["A style stored with this book alone.\n\nSwitching between these three only changes which one you are editing and which one this book uses. The others keep their settings."] =
        "仅随本书保存的样式。\n\n在这三个层级之间切换，只会改变你正在编辑哪一个、本书使用哪一个。其余层级会保留各自的设置。",
    ["A thin line under chapter titles, in the manner of an older printed book."] =
        "在章节标题下方加一条细线，如同旧式印刷书籍。",
    ["About reading style and style tweaks"] =
        "关于阅读样式与样式微调",
    ["Advanced"] =
        "高级",
    ["After"] =
        "之后",
    ["Align"] =
        "对齐",
    ["Aligning images turns them into blocks, which pulls inline images — drop caps, small icons inside a line of text — out of their line. Leave at book default unless you need it."] =
        "对齐图片会把它们变成块级元素，从而把行内图片——首字下沉、正文行内的小图标——挤出所在行。除非确有需要，请保持“书籍默认”。",
    ["Alignment of body text, paragraphs and list items. Headings keep their own alignment setting."] =
        "正文、段落和列表项的对齐方式。标题保留各自的对齐设置。",
    ["Alignment of headings. Applies to all six heading levels, so a centred chapter title does not sit above left-aligned sub-headings."] =
        "标题的对齐方式。适用于全部六级标题，以免居中的章节标题压在左对齐的小标题上方。",
    ["All books"] =
        "所有书籍",
    ["Applies to h1, h2 and h3 headings.\n\nBooks that do not mark their chapter titles as real headings — a styled paragraph inside a container, say — cannot be reached by any of these settings."] =
        "适用于 h1、h2 和 h3 标题。\n\n若书籍没有把章节标题标记为真正的标题——比如只是容器内一个设了样式的段落——这些设置都无法触及。",
    ["Apply"] =
        "应用",
    ["Apply changes immediately"] =
        "立即应用更改",
    ["Apply now"] =
        "立即应用",
    ["Apply to: %1"] =
        "应用于：%1",
    ["Applying this will reload the book."] =
        "应用此设置将重新加载本书。",
    ["Avoid widows and orphans"] =
        "避免孤行与寡行",
    ["Before"] =
        "之前",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "段落之间空一行，不缩进，行距和边距都很宽裕。适合疲劳的眼睛。",
    ["Block quotes"] =
        "引用块",
    ["Bold"] =
        "粗体",
    ["Bold instead of italic"] =
        "用粗体代替斜体",
    ["Book default"] =
        "书籍默认",
    ["Books in %1"] =
        "%1 语言的书籍",
    ["Books in this language"] =
        "该语言的书籍",
    ["Bottom margin"] =
        "下页边距",
    ["Cancel"] =
        "取消",
    ["Caps every image at the width and height of the page, so oversized images no longer spill past the margins."] =
        "把每张图片限制在页面的宽高之内，使过大的图片不再溢出页边距。",
    ["Centered"] =
        "居中",
    ["Chapter"] =
        "章节",
    ["Chapter title alignment"] =
        "章节标题对齐",
    ["Chapter title size"] =
        "章节标题大小",
    ["Chapter title style"] =
        "章节标题样式",
    ["Chapters"] =
        "章节",
    ["Clears every reading style setting and lets the book look the way its publisher intended."] =
        "清除所有阅读样式设置，让书籍呈现出版方原本设计的样子。",
    ["Clears tinted boxes and page backgrounds. On a greyscale screen these become flat grey blocks that make the text on them harder to read."] =
        "清除彩色方框和页面背景。在灰阶屏幕上它们会变成一片死灰，压在上面的文字更难辨读。",
    ["Close"] =
        "关闭",
    ["Compact"] =
        "紧凑",
    ["Could not write the file: %1"] =
        "无法写入文件：%1",
    ["Current style: %1"] =
        "当前样式：%1",
    ["Custom (%1)"] =
        "自定义（%1）",
    ["Custom CSS"] =
        "自定义 CSS",
    ["Custom CSS (%1 characters)"] =
        "自定义 CSS（%1 个字符）",
    ["Custom CSS applied"] =
        "已应用自定义 CSS",
    ["Cycle reading style presets"] =
        "循环切换阅读样式预设",
    ["Delete"] =
        "删除",
    ["Delete the %1 style"] =
        "删除 %1 的样式",
    ["Delete the style for this language"] =
        "删除该语言的样式",
    ["Delete the style stored at that level?"] =
        "删除该层级上保存的样式？",
    ["Delete this book's style"] =
        "删除本书的样式",
    ["Deletes the style stored at that level. Editing moves to the next level up, and its style takes over."] =
        "删除该层级上保存的样式。编辑对象转到上一层级，由它的样式接管。",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "不缩进紧接标题之后那一段的首行，这是通行的排版惯例。\n\n只对直接跟在标题后面的段落生效。若书籍把章节开头包在容器里，则无法触及。",
    ["Draws the page you are on with these settings in a separate process, and shows it to you before anything happens to the book.\n\nThe book itself is not re-rendered and nothing is saved unless you choose \"Apply\" there, so looking costs nothing."] =
        "在单独的进程中用这些设置绘制您当前所在的页面，并在本书发生任何变化之前展示给您。\n\n除非您在预览中选择“应用”，否则本书不会重新渲染，也不会保存任何内容，所以查看是没有代价的。",
    ["E-reader"] =
        "电子阅读器",
    ["Edit this book's own tweak"] =
        "编辑本书专属的样式微调",
    ["Emphasis"] =
        "强调",
    ["Exactly what this plugin is appending to your stylesheet right now. Worth pasting into a bug report."] =
        "本插件此刻追加到你样式表中的全部内容。值得贴进问题报告里。",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "字母之间的额外间距。小幅度可提升易读性；超过约 0.1 em 后文字会显得被拉伸。",
    ["First paragraph after a heading"] =
        "标题后的第一段",
    ["Fit to page width"] =
        "适应页面宽度",
    ["Fit to text width"] =
        "适应文本宽度",
    ["Font weight"] =
        "字体粗细",
    ["Footnote markers and cross-references are usually blue, which renders as a mid grey."] =
        "脚注标记和交叉引用通常是蓝色的，显示出来是中灰。",
    ["Force a page break before each chapter title, the way a printed book does.\n\nChoosing H1 and H2 also keeps a subtitle from starting a second page of its own."] =
        "在每个章节标题前强制分页，如同印刷书籍。\n\n选择 H1 和 H2 时，副标题也不会单独另起一页。",
    ["Force black text"] =
        "强制黑色文字",
    ["Full page"] =
        "整页",
    ["H1 and H2"] =
        "H1 和 H2",
    ["H1 only"] =
        "仅 H1",
    ["H1, H2 and H3"] =
        "H1、H2 和 H3",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "手写的 CSS，追加在上面各项控件生成的内容之后，因此始终优先。它与其他设置一样，遵循你当前编辑的作用范围。",
    ["Header and footer"] =
        "页眉与页脚",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "每行的高度，以百分比表示。这是 KOReader 自带的行间距设置，与底部菜单中的是同一项。",
    ["Hide images"] =
        "隐藏图片",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "页面的水平边距。文本栏的宽度由它们决定：边距越宽，行越窄，也越容易扫读。",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "每个段落首行缩进的距离。同时清除从容器、标题、列表项和表格单元格继承来的缩进——重复缩进正是由此而来。",
    ["How quoted passages are set apart from the body text. \"No special treatment\" clears the publisher's own indentation and italics instead of adding to them."] =
        "引用段落如何与正文区分开。“不作特殊处理”会清除出版方自带的缩进和斜体，而不是在其之上叠加。",
    ["Image alignment"] =
        "图片对齐",
    ["Image width"] =
        "图片宽度",
    ["Images"] =
        "图片",
    ["Indent"] =
        "缩进",
    ["Indented"] =
        "缩进",
    ["Indented and italic"] =
        "缩进并用斜体",
    ["Ink and links"] =
        "墨色与链接",
    ["Inside the preview you can go on changing settings and turning pages: everything you change there is held until you apply it."] =
        "在预览中您可以继续更改设置和翻页：您在那里更改的一切都会被保留，直到您应用为止。",
    ["Italic"] =
        "斜体",
    ["Justified"] =
        "两端对齐",
    ["KOReader's own typography rules, including hyphenation. The language chosen here decides which hyphenation dictionary is used, which is why it lives with the language setting rather than on its own."] =
        "KOReader 自带的排版规则，包含断词。这里选择的语言决定使用哪本断词词典，因此断词与语言设置放在一起，而不是单独列出。",
    ["Lang: %1"] =
        "语言：%1",
    ["Left"] =
        "左对齐",
    ["Left and right margins"] =
        "左右页边距",
    ["Lets preformatted blocks — code listings, terminal output — wrap instead of running off the edge of the page."] =
        "让预格式化块——代码清单、终端输出——自动换行，而不是冲出页面边缘。",
    ["Letter spacing"] =
        "字母间距",
    ["Line"] =
        "行距",
    ["Line spacing"] =
        "行间距",
    ["Links in black"] =
        "链接用黑色",
    ["Links without underline"] =
        "链接不加下划线",
    ["Load reading style preset"] =
        "加载阅读样式预设",
    ["Makes the text heavier or lighter than the font's own weight. A small increase is the most effective answer to a font that prints faintly on e-ink.\n\nThis is KOReader's own font weight setting."] =
        "让文字比字体本身更粗或更细。对于在墨水屏上显得发虚的字体，略微加粗是最有效的办法。\n\n这是 KOReader 自带的字体粗细设置。",
    ["Margin presets"] =
        "页边距预设",
    ["Narrow"] =
        "窄",
    ["Needs a font that can produce small capitals, or the reader's font will synthesise them and the result can look uneven."] =
        "需要支持小型大写字母的字体，否则阅读器的字体只能模拟，效果可能参差不齐。",
    ["No indentation"] =
        "不缩进",
    ["No space above"] =
        "上方不留空",
    ["No special treatment"] =
        "不作特殊处理",
    ["Normal"] =
        "标准",
    ["Not available from inside a preview: that editor writes to the book itself, which a preview must not do."] =
        "无法在预览中使用：该编辑器会直接写入书籍，而预览不应这样做。",
    ["Nothing is being generated: every setting is at book default."] =
        "当前没有生成任何内容：所有设置都保持在书籍默认。",
    ["On H1"] =
        "在 H1 处",
    ["On H1 and H2"] =
        "在 H1 和 H2 处",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "当两端对齐的行出现过大空隙时，允许把多余的空间以字母间距的形式分摊到词内。以字号的百分比设定。",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "开启时，更改会立即显示。关闭时，更改会先累积，只有选择“立即应用”后才生效。\n\n每次应用都会重新排版整本书，因此连续修改多项设置时关闭它更划算。",
    ["Only the settings this plugin owns travel with a language: indentation, spacing, alignment, chapter titles, images, custom CSS.\n\nLine spacing, margins and word spacing belong to KOReader, which stores them per book and has no notion of a language, so they stay where they are."] =
        "随语言一起保存的只有本插件自己的设置：缩进、间距、对齐、章节标题、图片和自定义 CSS。\n\n行间距、页边距和词间距属于 KOReader，它按书籍保存这些设置，也没有语言这一维度，因此它们保持原样。",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "打开 KOReader 的书籍专属样式微调编辑器，含 CSS 建议与格式化功能。该微调由 KOReader 保存，与本插件相互独立，并在这些设置之前生效。",
    ["Original size"] =
        "原始尺寸",
    ["Overrides every colour the publisher chose, including the greys used for asides and captions, which print faintly on e-ink.\n\nAlso blackens borders."] =
        "覆盖出版方选定的所有颜色，包括旁注和图片说明所用的灰色——它们在墨水屏上印得很淡。\n\n同时也把边框变为黑色。",
    ["Page layout"] =
        "页面布局",
    ["Paragraph indentation"] =
        "段落缩进",
    ["Paragraphs"] =
        "段落",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "用简单的控件调整决定书籍外观的各项设置——段落缩进与间距、章节标题周围的空白、对齐、页边距、图片——并支持预设以及按书籍或按语言的样式。\n\n它建立在 KOReader 的样式微调之上，而非取而代之：凡是保持在“书籍默认”的项目，都不会影响你的样式微调和出版方的样式。",
    ["Playground"] =
        "试验场",
    ["Presets"] =
        "预设",
    ["Prettify"] =
        "格式化",
    ["Prevent images from overflowing the page"] =
        "防止图片超出页面",
    ["Preview is not available for this book."] =
        "本书无法使用预览。",
    ["Preview is not available on this device."] =
        "此设备无法使用预览。",
    ["Preview: after"] =
        "预览：之后",
    ["Preview: before"] =
        "预览：之前",
    ["Preview: before | after"] =
        "预览：之前 | 之后",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "纸质书排版：段落首行缩进且彼此不留空，章节标题居中并在上方留出空间。",
    ["Publisher default"] =
        "出版方默认",
    ["Puts everything this menu marks as changed back to default, at the level you are editing: this plugin's settings return to book default, and KOReader's own — line spacing, word spacing, font weight, margins — return to theirs.\n\nStyles stored at the other levels are not touched; deleting those is a separate action."] =
        "把本菜单标记为已更改的一切，在你正在编辑的层级上恢复为默认：本插件的设置回到书籍默认，KOReader 自带的——行间距、词间距、字体粗细、页边距——回到各自的默认值。\n\n其他层级上保存的样式不受影响；删除它们是另一项操作。",
    ["Quick style"] =
        "快速样式",
    ["Reading style"] =
        "阅读样式",
    ["Reading style: %1"] =
        "阅读样式：%1",
    ["Reduction"] =
        "压缩",
    ["Remove background colours"] =
        "去除背景颜色",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "去掉标题后第一段上方的段间距，使其紧贴章节标题下方。",
    ["Removes every image from the page, for reading a heavily illustrated book as plain text.\n\nCaptions stay, since they are ordinary text."] =
        "移除页面上的所有图片，便于把插图繁多的书当作纯文本阅读。\n\n图片说明会保留，因为它们是普通文字。",
    ["Rendering the book with the new style…\n\nThe book on screen is not being changed. This takes about as long as applying the style would."] =
        "正在用新样式渲染本书……\n\n屏幕上的书没有被改变。这大约与应用样式所需的时间相同。",
    ["Replace"] =
        "替换",
    ["Replaces italics with something else. Worth it when a book's italic face is thin or hard to read on screen."] =
        "用别的方式取代斜体。当书中的斜体字面偏细、在屏幕上难以辨读时很有用。",
    ["Reset"] =
        "重置",
    ["Reset all four margins to their defaults?"] =
        "将四个页边距全部重置为默认值？",
    ["Reset all reading style settings"] =
        "重置全部阅读样式设置",
    ["Reset chapter settings"] =
        "重置章节设置",
    ["Reset every text setting in this section, including KOReader's own line spacing, word spacing, word expansion and font weight?"] =
        "重置本节的所有文本设置，包括 KOReader 自带的行间距、词间距、词内扩展和字体粗细？",
    ["Reset image settings"] =
        "重置图片设置",
    ["Reset ink settings"] =
        "重置墨色设置",
    ["Reset margins"] =
        "重置页边距",
    ["Reset paragraph settings"] =
        "重置段落设置",
    ["Reset text settings"] =
        "重置文本设置",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "将章节标题设置重置为出版方默认值？",
    ["Reset the colour and link settings to the publisher's defaults?"] =
        "将颜色和链接设置重置为出版方默认值？",
    ["Reset the image settings to the publisher's defaults?"] =
        "将图片设置重置为出版方默认值？",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "将段落设置重置为出版方默认值？",
    ["Right"] =
        "右对齐",
    ["Rule under the title"] =
        "标题下加线",
    ["Save as a style tweak"] =
        "另存为样式微调",
    ["Save current reading style as preset"] =
        "将当前阅读样式保存为预设",
    ["Saved to %1\n\nIt appears under Style tweaks, in User style tweaks, once KOReader is restarted."] =
        "已保存到 %1\n\n重启 KOReader 后，可在“样式微调”的用户样式微调中找到它。",
    ["Scaling"] =
        "缩放",
    ["Settings"] =
        "设置",
    ["Show after"] =
        "显示之后",
    ["Show before"] =
        "显示之前",
    ["Shrinks footnote markers and the like, and stops them from stretching the line they sit on."] =
        "缩小脚注标记之类的字符，并避免它们撑高所在的那一行。",
    ["Side by side"] =
        "并排显示",
    ["Side margins"] =
        "左右页边距",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "章节标题的大小，以周围正文的百分比表示。\n\n",
    ["Small capitals"] =
        "小型大写字母",
    ["Smaller sub- and superscript"] =
        "更小的上下标",
    ["Space after chapter title"] =
        "章节标题后的空白",
    ["Space before chapter title"] =
        "章节标题前的空白",
    ["Space below the text. The status bar, when shown at the bottom, takes its height from here."] =
        "正文下方的空白。状态栏显示在底部时，其高度取自这里。",
    ["Space between paragraphs"] =
        "段落间距",
    ["Spacing"] =
        "间距",
    ["Spacious"] =
        "宽松",
    ["Start chapters on a new page"] =
        "章节另起一页",
    ["Stop a paragraph from leaving a single line stranded at the top or bottom of a page.\n\nPages end less evenly as a result, and the page count shifts."] =
        "避免段落在页首或页尾只留下孤零零的一行。\n\n代价是各页结束得不那么齐整，页码也会随之变动。",
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "点击循环切换：书籍默认、开、关。\n\n“关”与“书籍默认”并不相同：它会主动去掉出版方设为粗体的标题的粗体效果。",
    ["Text"] =
        "正文",
    ["Text alignment"] =
        "文本对齐",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "常见的电子阅读器观感：不缩进，段落之间留一点空隙，整体间距适中。",
    ["The preview could not be rendered on this device."] =
        "此设备无法渲染预览。",
    ["The preview did not produce a page."] =
        "预览未生成页面。",
    ["The preview failed."] =
        "预览失败。",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "把最常用的设置集中在一屏。也可以通过手势打开。",
    ["The style you edit here is used for every book that has no style of its own."] =
        "在此编辑的样式适用于所有没有专属样式的书籍。",
    ["There is not enough free memory for a preview right now.\n\nA preview renders a second copy of the book in a separate process, which needs room. Closing other things, or reopening the book, usually frees enough."] =
        "目前没有足够的可用内存来进行预览。\n\n预览会在单独的进程中渲染本书的第二份副本，这需要内存空间。关闭其他内容或重新打开本书通常能释放足够的内存。",
    ["This book"] =
        "本书",
    ["This book only"] =
        "仅本书",
    ["This page has not been rendered yet."] =
        "此页面尚未渲染。",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "本插件会生成一小段样式表，并追加在你的样式微调之后，因此两者重叠时以本插件的设置为准。\n\n凡是保持在“书籍默认”的项目都不会生成任何内容，你的样式微调和出版方的样式都不受影响。\n\n每次更改都会重新排版整本书。这是正常现象，KOReader 对任何样式更改都是如此。",
    ["This replaces the style already stored at that level with the settings you are looking at now.\n\nContinue?"] =
        "这会用你当前看到的设置替换该层级上已保存的样式。\n\n是否继续？",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "行距紧凑、边距较小，段落之间不留空。一页能容纳最多的文字。",
    ["Top margin"] =
        "上页边距",
    ["Traditional"] =
        "传统",
    ["Try"] =
        "试用",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "这是两个数值，只有第一个会把词语拉开。\n\n缩放是每个空格的宽度，以字体自带空格字符的百分比表示。100% 为字体的自然宽度，而 KOReader 的默认值是 95%——略窄一些。想要更大的间隙就调到 100% 以上。\n\n压缩是指两端对齐时，为了让一行多容纳一个词，这些空格最多可以被压回多少。100% 表示完全不允许压缩，因此也要把它调高，否则加宽的间隙留不住。",
    ["Typography and hyphenation: %1"] =
        "排版与断词：%1",
    ["Underlined instead of italic"] =
        "用下划线代替斜体",
    ["Uppercase"] =
        "大写",
    ["Use these settings for all books"] =
        "将这些设置用于所有书籍",
    ["Use these settings for all books in %1"] =
        "将这些设置用于所有 %1 语言的书籍",
    ["Use these settings for all books in this language"] =
        "将这些设置用于该语言的所有书籍",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "段落之间的垂直空白。出版方自带的段落边距会先被清除，因此你设定的值就是实际效果，而不会叠加在原有值之上。",
    ["View generated CSS"] =
        "查看生成的 CSS",
    ["What counts as a chapter"] =
        "什么算作一章",
    ["Which heading levels the settings below apply to.\n\nMost books mark chapters as H1, many use H2, and a few use H3. Including H3 in a book full of sub-headings will space out things that are not chapters at all.\n\nAlignment is deliberately left out of this: it always applies to every heading level."] =
        "下面的设置作用于哪些标题级别。\n\n多数书籍把章节标记为 H1，不少使用 H2，少数使用 H3。在小标题密集的书里把 H3 也算进来，会把根本不是章节的内容也撑开。\n\n对齐方式特意不受此限制：它始终作用于全部标题级别。",
    ["Whitespace above chapter and section titles, so a chapter does not start flush against the top of the page.\n\n"] =
        "章节与小节标题上方的空白，使章节不会紧贴页面顶端开始。\n\n",
    ["Whitespace between a chapter title and the text that follows it.\n\n"] =
        "章节标题与其后正文之间的空白。\n\n",
    ["Wide"] =
        "宽",
    ["Word expansion"] =
        "词内扩展",
    ["Word spacing"] =
        "词间距",
    ["Wrap long code lines"] =
        "长代码行自动换行",
    ["Writes the generated CSS into KOReader's own user style tweaks folder, where it works without this plugin. A way out that does not cost you your settings."] =
        "把生成的 CSS 写入 KOReader 自带的用户样式微调文件夹，在那里不依赖本插件也能生效。一条不会让你丢失设置的退路。",
    ["book default"] =
        "书籍默认",
    ["hyphenation off"] =
        "断词已关闭",
    ["hyphenation on"] =
        "断词已开启",
    ["off"] =
        "关",
    ["on"] =
        "开",
    ["page %1 of %2"] =
        "第 %1 页，共 %2 页",
    ["style changes"] =
        "样式更改",
}
