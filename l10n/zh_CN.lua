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
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nUnavailable when the book does not declare a language."] =
        "为该语言的书籍单独设置样式；当某种语言采用不同的段落习惯更易阅读时很有用。\n\n书籍未声明语言时不可用。",
    ["A style stored with this book alone. It overrides both of the above."] =
        "仅随本书保存的样式。它会覆盖上述两者。",
    ["About reading style and style tweaks"] =
        "关于阅读样式与样式微调",
    ["Advanced"] =
        "高级",
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
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "段落之间空一行，不缩进，行距和边距都很宽裕。适合疲劳的眼睛。",
    ["Bold"] =
        "粗体",
    ["Book default"] =
        "书籍默认",
    ["Books in %1"] =
        "%1 语言的书籍",
    ["Books in this language"] =
        "该语言的书籍",
    ["Bottom margin"] =
        "下页边距",
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
    ["Close"] =
        "关闭",
    ["Compact"] =
        "紧凑",
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
    ["Discard"] =
        "放弃",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "不缩进紧接标题之后那一段的首行，这是通行的排版惯例。\n\n只对直接跟在标题后面的段落生效。若书籍把章节开头包在容器里，则无法触及。",
    ["E-reader"] =
        "电子阅读器",
    ["Edit this book's own tweak"] =
        "编辑本书专属的样式微调",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "字母之间的额外间距。小幅度可提升易读性；超过约 0.1 em 后文字会显得被拉伸。",
    ["First paragraph after a heading"] =
        "标题后的第一段",
    ["Fit to page width"] =
        "适应页面宽度",
    ["Fit to text width"] =
        "适应文本宽度",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "手写的 CSS，追加在上面各项控件生成的内容之后，因此始终优先。它与其他设置一样，遵循你当前编辑的作用范围。",
    ["Header and footer"] =
        "页眉与页脚",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "每行的高度，以百分比表示。这是 KOReader 自带的行间距设置，与底部菜单中的是同一项。",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "页面的水平边距。文本栏的宽度由它们决定：边距越宽，行越窄，也越容易扫读。",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "每个段落首行缩进的距离。同时清除从容器、标题、列表项和表格单元格继承来的缩进——重复缩进正是由此而来。",
    ["Image alignment"] =
        "图片对齐",
    ["Image width"] =
        "图片宽度",
    ["Images"] =
        "图片",
    ["Indent"] =
        "缩进",
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
    ["Letter spacing"] =
        "字母间距",
    ["Line"] =
        "行距",
    ["Line spacing"] =
        "行间距",
    ["Load reading style preset"] =
        "加载阅读样式预设",
    ["Margin presets"] =
        "页边距预设",
    ["Narrow"] =
        "窄",
    ["No indentation"] =
        "不缩进",
    ["No space above"] =
        "上方不留空",
    ["Normal"] =
        "标准",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "当两端对齐的行出现过大空隙时，允许把多余的空间以字母间距的形式分摊到词内。以字号的百分比设定。",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "开启时，更改会立即显示。关闭时，更改会先累积，只有选择“立即应用”后才生效。\n\n每次应用都会重新排版整本书，因此连续修改多项设置时关闭它更划算。",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "打开 KOReader 的书籍专属样式微调编辑器，含 CSS 建议与格式化功能。该微调由 KOReader 保存，与本插件相互独立，并在这些设置之前生效。",
    ["Original size"] =
        "原始尺寸",
    ["Page layout"] =
        "页面布局",
    ["Paragraph indentation"] =
        "段落缩进",
    ["Paragraphs"] =
        "段落",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "用简单的控件调整决定书籍外观的各项设置——段落缩进与间距、章节标题周围的空白、对齐、页边距、图片——并支持预设以及按书籍或按语言的样式。\n\n它建立在 KOReader 的样式微调之上，而非取而代之：凡是保持在“书籍默认”的项目，都不会影响你的样式微调和出版方的样式。",
    ["Presets"] =
        "预设",
    ["Prettify"] =
        "格式化",
    ["Prevent images from overflowing the page"] =
        "防止图片超出页面",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "纸质书排版：段落首行缩进且彼此不留空，章节标题居中并在上方留出空间。",
    ["Publisher default"] =
        "出版方默认",
    ["Quick style"] =
        "快速样式",
    ["Reading style"] =
        "阅读样式",
    ["Reading style: %1"] =
        "阅读样式：%1",
    ["Reduction"] =
        "压缩",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "去掉标题后第一段上方的段间距，使其紧贴章节标题下方。",
    ["Reset"] =
        "重置",
    ["Reset all reading style settings"] =
        "重置全部阅读样式设置",
    ["Reset chapter settings"] =
        "重置章节设置",
    ["Reset image settings"] =
        "重置图片设置",
    ["Reset paragraph settings"] =
        "重置段落设置",
    ["Reset text settings"] =
        "重置文本设置",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "将章节标题设置重置为出版方默认值？",
    ["Reset the image settings to the publisher's defaults?"] =
        "将图片设置重置为出版方默认值？",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "将段落设置重置为出版方默认值？",
    ["Reset the text settings this plugin controls to the publisher's defaults?\n\nLine spacing and word spacing belong to KOReader and are left alone."] =
        "将本插件控制的文本设置重置为出版方默认值？\n\n行间距和词间距属于 KOReader，不会被改动。",
    ["Right"] =
        "右对齐",
    ["Save current reading style as preset"] =
        "将当前阅读样式保存为预设",
    ["Scaling"] =
        "缩放",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "章节标题的大小，以周围正文的百分比表示。\n\n",
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
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "点击循环切换：书籍默认、开、关。\n\n“关”与“书籍默认”并不相同：它会主动去掉出版方设为粗体的标题的粗体效果。",
    ["Text"] =
        "正文",
    ["Text alignment"] =
        "文本对齐",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "常见的电子阅读器观感：不缩进，段落之间留一点空隙，整体间距适中。",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "把最常用的设置集中在一屏。也可以通过手势打开。",
    ["The settings you made for the narrower scope will be discarded, and the broader style takes over.\n\nContinue?"] =
        "为较小作用范围所做的设置将被放弃，改由较大范围的样式接管。\n\n是否继续？",
    ["The style you edit here is used for every book that has no style of its own."] =
        "在此编辑的样式适用于所有没有专属样式的书籍。",
    ["This book"] =
        "本书",
    ["This book only"] =
        "仅本书",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "本插件会生成一小段样式表，并追加在你的样式微调之后，因此两者重叠时以本插件的设置为准。\n\n凡是保持在“书籍默认”的项目都不会生成任何内容，你的样式微调和出版方的样式都不受影响。\n\n每次更改都会重新排版整本书。这是正常现象，KOReader 对任何样式更改都是如此。",
    ["This restores every reading style setting in the current scope to the publisher's defaults.\n\nKOReader's own settings — line spacing, margins, word spacing — are left alone."] =
        "这会把当前作用范围内的所有阅读样式设置恢复为出版方默认值。\n\nKOReader 自带的设置——行间距、页边距、词间距——不受影响。",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "行距紧凑、边距较小，段落之间不留空。一页能容纳最多的文字。",
    ["Top margin"] =
        "上页边距",
    ["Traditional"] =
        "传统",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "这是两个数值，只有第一个会把词语拉开。\n\n缩放是每个空格的宽度，以字体自带空格字符的百分比表示。100% 为字体的自然宽度，而 KOReader 的默认值是 95%——略窄一些。想要更大的间隙就调到 100% 以上。\n\n压缩是指两端对齐时，为了让一行多容纳一个词，这些空格最多可以被压回多少。100% 表示完全不允许压缩，因此也要把它调高，否则加宽的间隙留不住。",
    ["Typography and hyphenation: %1"] =
        "排版与断词：%1",
    ["Uppercase"] =
        "大写",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "段落之间的垂直空白。出版方自带的段落边距会先被清除，因此你设定的值就是实际效果，而不会叠加在原有值之上。",
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
}
