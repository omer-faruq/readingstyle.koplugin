--[[--
Turkish translations for the Reading style plugin.

Keys are the English msgids exactly as they appear in the source; anything not
listed here falls back to the English text through readingstyle_gettext.

Regenerate the key list with:
    luajit l10n/tools/extract.lua *.lua > l10n/template.lua
and check this file against it with:
    luajit l10n/tools/validate.lua l10n/template.lua l10n/tr.lua
--]]

return {
    ["\"Fit to text width\" only shrinks images that are too wide. \"Fit to page width\" also enlarges smaller ones, which can stretch images that carry explicit pixel dimensions."] =
        "\"Metin genişliğine sığdır\" yalnızca fazla geniş görselleri küçültür. \"Sayfa genişliğine sığdır\" küçük olanları da büyütür; bu, piksel boyutu belirtilmiş görselleri gerebilir.",
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nUnavailable when the book does not declare a language."] =
        "Bu dildeki kitaplar için ayrı bir stil; bir dil farklı paragraf alışkanlıklarıyla daha iyi okunduğunda işe yarar.\n\nKitap bir dil bildirmiyorsa kullanılamaz.",
    ["A style stored with this book alone. It overrides both of the above."] =
        "Yalnızca bu kitapla birlikte saklanan bir stil. Yukarıdakilerin ikisini de geçersiz kılar.",
    ["About reading style and style tweaks"] =
        "Okuma stili ve stil ince ayarları hakkında",
    ["Advanced"] =
        "Gelişmiş",
    ["Align"] =
        "Hiza",
    ["Aligning images turns them into blocks, which pulls inline images — drop caps, small icons inside a line of text — out of their line. Leave at book default unless you need it."] =
        "Görselleri hizalamak onları blok haline getirir; bu da satır içi görselleri — süslü ilk harfler, metnin içindeki küçük simgeler — bulundukları satırdan çıkarır. Gerekmedikçe kitap varsayılanında bırakın.",
    ["Alignment of body text, paragraphs and list items. Headings keep their own alignment setting."] =
        "Gövde metninin, paragrafların ve liste öğelerinin hizalaması. Başlıklar kendi hizalama ayarını korur.",
    ["Alignment of headings. Applies to all six heading levels, so a centred chapter title does not sit above left-aligned sub-headings."] =
        "Başlıkların hizalaması. Altı başlık düzeyinin hepsine uygulanır; böylece ortalanmış bir bölüm başlığı, sola yaslı alt başlıkların üstünde tek başına kalmaz.",
    ["All books"] =
        "Tüm kitaplar",
    ["Applies to h1, h2 and h3 headings.\n\nBooks that do not mark their chapter titles as real headings — a styled paragraph inside a container, say — cannot be reached by any of these settings."] =
        "h1, h2 ve h3 başlıklarına uygulanır.\n\nBölüm başlıklarını gerçek başlık olarak işaretlemeyen kitaplara — örneğin bir kapsayıcı içindeki biçimlendirilmiş paragrafa — bu ayarların hiçbiriyle ulaşılamaz.",
    ["Apply"] =
        "Uygula",
    ["Apply changes immediately"] =
        "Değişiklikleri anında uygula",
    ["Apply now"] =
        "Şimdi uygula",
    ["Apply to: %1"] =
        "Uygulanacak: %1",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Paragraflar arasında boş satır, girinti yok, cömert satır aralığı ve kenar boşlukları. Yorgun gözler için rahat.",
    ["Bold"] =
        "Kalın",
    ["Book default"] =
        "Kitap varsayılanı",
    ["Books in %1"] =
        "%1 dilindeki kitaplar",
    ["Books in this language"] =
        "Bu dildeki kitaplar",
    ["Bottom margin"] =
        "Alt kenar boşluğu",
    ["Caps every image at the width and height of the page, so oversized images no longer spill past the margins."] =
        "Her görseli sayfanın genişliği ve yüksekliğiyle sınırlar; böylece aşırı büyük görseller kenar boşluklarının dışına taşmaz.",
    ["Centered"] =
        "Ortalanmış",
    ["Chapter"] =
        "Bölüm",
    ["Chapter title alignment"] =
        "Bölüm başlığı hizalaması",
    ["Chapter title size"] =
        "Bölüm başlığı boyutu",
    ["Chapter title style"] =
        "Bölüm başlığı stili",
    ["Chapters"] =
        "Bölümler",
    ["Clears every reading style setting and lets the book look the way its publisher intended."] =
        "Bütün okuma stili ayarlarını temizler ve kitabın yayıncısının tasarladığı gibi görünmesini sağlar.",
    ["Close"] =
        "Kapat",
    ["Compact"] =
        "Sıkışık",
    ["Current style: %1"] =
        "Geçerli stil: %1",
    ["Custom (%1)"] =
        "Özel (%1)",
    ["Custom CSS"] =
        "Özel CSS",
    ["Custom CSS (%1 characters)"] =
        "Özel CSS (%1 karakter)",
    ["Custom CSS applied"] =
        "Özel CSS uygulandı",
    ["Cycle reading style presets"] =
        "Okuma stili hazır ayarları arasında geç",
    ["Discard"] =
        "Sil",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "Başlığı doğrudan izleyen paragrafın ilk satırını girintilemez; alışılmış tipografi kuralı budur.\n\nYalnızca başlığın hemen ardından gelen paragraflara ulaşır. Bölüm başlangıcını bir kapsayıcı içine saran kitaplar erişim dışındadır.",
    ["E-reader"] =
        "E-okuyucu",
    ["Edit this book's own tweak"] =
        "Bu kitabın kendi ince ayarını düzenle",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Harfler arasındaki ek boşluk. Küçük değerler okunaklığı artırabilir; 0.1 em üzerindeki değerler metni gerilmiş gösterir.",
    ["First paragraph after a heading"] =
        "Başlıktan sonraki ilk paragraf",
    ["Fit to page width"] =
        "Sayfa genişliğine sığdır",
    ["Fit to text width"] =
        "Metin genişliğine sığdır",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "Elle yazılmış CSS. Yukarıdaki denetimlerin ürettiği her şeyin sonuna eklenir, bu yüzden her zaman üstün gelir. Diğer ayarlar gibi, düzenlemekte olduğunuz kapsamı izler.",
    ["Header and footer"] =
        "Üst ve alt bilgi çubuğu",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Her satırın yüksekliği, yüzde olarak. Bu, KOReader'ın kendi satır aralığı ayarıdır; alt menüdeki ile aynı ayardır.",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Yatay sayfa kenar boşlukları. Metin sütununun genişliğini bunlar belirler: geniş kenar boşluğu, daha dar ve gözle takibi kolay satır demektir.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "Her paragrafın ilk satırının ne kadar içeriden başlayacağı. Kapsayıcılardan, başlıklardan, liste öğelerinden ve tablo hücrelerinden miras alınan girintiyi de temizler; katlanmış girintilerin kaynağı budur.",
    ["Image alignment"] =
        "Görsel hizalaması",
    ["Image width"] =
        "Görsel genişliği",
    ["Images"] =
        "Görseller",
    ["Indent"] =
        "Girinti",
    ["Italic"] =
        "İtalik",
    ["Justified"] =
        "İki yana yaslı",
    ["KOReader's own typography rules, including hyphenation. The language chosen here decides which hyphenation dictionary is used, which is why it lives with the language setting rather than on its own."] =
        "KOReader'ın kendi tipografi kuralları, heceleme dahil. Burada seçilen dil hangi heceleme sözlüğünün kullanılacağını belirler; heceleme bu yüzden tek başına değil, dil ayarının yanında durur.",
    ["Lang: %1"] =
        "Dil: %1",
    ["Left"] =
        "Sol",
    ["Left and right margins"] =
        "Sol ve sağ kenar boşlukları",
    ["Letter spacing"] =
        "Harf aralığı",
    ["Line"] =
        "Satır",
    ["Line spacing"] =
        "Satır aralığı",
    ["Load reading style preset"] =
        "Okuma stili hazır ayarını yükle",
    ["Margin presets"] =
        "Kenar boşluğu hazır ayarları",
    ["Narrow"] =
        "Dar",
    ["No indentation"] =
        "Girinti yok",
    ["No space above"] =
        "Üstünde boşluk yok",
    ["Normal"] =
        "Normal",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "İki yana yaslı satırlarda boşluklar çok açıldığında, fazla boşluğun harf aralığı olarak kelimelerin içine dağıtılmasına izin verir. Yazı tipi boyutunun yüzdesi olarak ayarlanır.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "Açıkken değişiklikler yapar yapmaz görünür. Kapalıyken biriktirilir ve yalnızca \"Şimdi uygula\" dediğinizde uygulanır.\n\nHer uygulama kitabı yeniden işler; bu yüzden birçok ayarı arka arkaya değiştirirken kapatmak işe yarar.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "KOReader'ın kitaba özel stil ince ayarı düzenleyicisini açar; CSS önerileri ve biçimlendiricisiyle birlikte. O ince ayar bu eklentiden ayrı olarak KOReader tarafından saklanır ve bu ayarlardan önce uygulanır.",
    ["Original size"] =
        "Özgün boyut",
    ["Page layout"] =
        "Sayfa düzeni",
    ["Paragraph indentation"] =
        "Paragraf girintisi",
    ["Paragraphs"] =
        "Paragraflar",
    ["Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.\n\nBuilds on KOReader's style tweaks rather than replacing them: everything left at \"book default\" leaves your tweaks and the publisher's styles untouched."] =
        "Bir kitabın nasıl göründüğüne karar veren ayarlar için sade denetimler — paragraf girintisi ve aralığı, bölüm başlıklarının çevresindeki boşluk, hizalama, kenar boşlukları, görseller — hazır ayarlar ve kitap ya da dil bazında stillerle birlikte.\n\nKOReader'ın stil ince ayarlarının yerine geçmez, üzerine kurulur: \"kitap varsayılanı\"nda bırakılan her şey, ince ayarlarınıza ve yayıncının stillerine dokunmaz.",
    ["Presets"] =
        "Hazır ayarlar",
    ["Prettify"] =
        "Biçimlendir",
    ["Prevent images from overflowing the page"] =
        "Görsellerin sayfadan taşmasını engelle",
    ["Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."] =
        "Basılı kitap tipografisi: aralarında boşluk olmayan girintili paragraflar, üstünde yer bırakılmış ortalanmış bölüm başlıkları.",
    ["Publisher default"] =
        "Yayıncı varsayılanı",
    ["Quick style"] =
        "Hızlı stil",
    ["Reading style"] =
        "Okuma stili",
    ["Reading style: %1"] =
        "Okuma stili: %1",
    ["Reduction"] =
        "Daraltma",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Başlıktan sonraki ilk paragrafın üstündeki boşluğu kaldırır; paragraf doğrudan bölüm başlığının altına oturur.",
    ["Reset"] =
        "Sıfırla",
    ["Reset all reading style settings"] =
        "Tüm okuma stili ayarlarını sıfırla",
    ["Reset chapter settings"] =
        "Bölüm ayarlarını sıfırla",
    ["Reset image settings"] =
        "Görsel ayarlarını sıfırla",
    ["Reset paragraph settings"] =
        "Paragraf ayarlarını sıfırla",
    ["Reset text settings"] =
        "Metin ayarlarını sıfırla",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "Bölüm başlığı ayarları yayıncı varsayılanlarına sıfırlansın mı?",
    ["Reset the image settings to the publisher's defaults?"] =
        "Görsel ayarları yayıncı varsayılanlarına sıfırlansın mı?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "Paragraf ayarları yayıncı varsayılanlarına sıfırlansın mı?",
    ["Reset the text settings this plugin controls to the publisher's defaults?\n\nLine spacing and word spacing belong to KOReader and are left alone."] =
        "Bu eklentinin denetlediği metin ayarları yayıncı varsayılanlarına sıfırlansın mı?\n\nSatır aralığı ve kelime aralığı KOReader'a aittir ve değiştirilmez.",
    ["Right"] =
        "Sağ",
    ["Save current reading style as preset"] =
        "Geçerli okuma stilini hazır ayar olarak kaydet",
    ["Scaling"] =
        "Ölçekleme",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Bölüm başlıklarının, çevresindeki metnin yüzdesi olarak boyutu.\n\n",
    ["Space after chapter title"] =
        "Bölüm başlığından sonraki boşluk",
    ["Space before chapter title"] =
        "Bölüm başlığından önceki boşluk",
    ["Space below the text. The status bar, when shown at the bottom, takes its height from here."] =
        "Metnin altındaki boşluk. Durum çubuğu altta gösteriliyorsa yüksekliğini buradan alır.",
    ["Space between paragraphs"] =
        "Paragraflar arası boşluk",
    ["Spacing"] =
        "Boşluk",
    ["Spacious"] =
        "Ferah",
    ["Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold."] =
        "Sırayla geçmek için dokunun: kitap varsayılanı, açık, kapalı.\n\n\"Kapalı\", \"kitap varsayılanı\" ile aynı şey değildir: yayıncının kalın yaptığı başlıkların kalınlığını etkin biçimde kaldırır.",
    ["Text"] =
        "Metin",
    ["Text alignment"] =
        "Metin hizalaması",
    ["The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."] =
        "Alışıldık e-okuyucu görünümü: girinti yok, paragraflar arasında küçük bir boşluk, her yerde ölçülü aralıklar.",
    ["The settings people reach for most, on one screen. Can also be opened with a gesture."] =
        "En sık kullanılan ayarlar, tek ekranda. Bir hareketle de açılabilir.",
    ["The settings you made for the narrower scope will be discarded, and the broader style takes over.\n\nContinue?"] =
        "Dar kapsam için yaptığınız ayarlar silinecek ve geniş kapsamdaki stil devralacak.\n\nDevam edilsin mi?",
    ["The style you edit here is used for every book that has no style of its own."] =
        "Burada düzenlediğiniz stil, kendine ait bir stili olmayan her kitap için kullanılır.",
    ["This book"] =
        "Bu kitap",
    ["This book only"] =
        "Yalnızca bu kitap",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "\nBu eklenti küçük bir stil sayfası yazar ve onu stil ince ayarlarınızın sonuna ekler; bu yüzden ikisinin çakıştığı her yerde bu eklentinin ayarları üstün gelir.\n\n\"Kitap varsayılanı\"nda bırakılan hiçbir ayar için CSS üretilmez; ince ayarlarınız ve yayıncının stilleri olduğu gibi kalır.\n\nHer değişiklik kitabı yeniden işler. Bu normaldir; KOReader herhangi bir stil değişikliğinde aynısını yapar.",
    ["This restores every reading style setting in the current scope to the publisher's defaults.\n\nKOReader's own settings — line spacing, margins, word spacing — are left alone."] =
        "Bu, geçerli kapsamdaki bütün okuma stili ayarlarını yayıncı varsayılanlarına döndürür.\n\nKOReader'ın kendi ayarlarına — satır aralığı, kenar boşlukları, kelime aralığı — dokunulmaz.",
    ["Tight lines and small margins, no space between paragraphs. Fits the most text on a page."] =
        "Sıkı satırlar, küçük kenar boşlukları, paragraflar arasında boşluk yok. Sayfaya en çok metni sığdırır.",
    ["Top margin"] =
        "Üst kenar boşluğu",
    ["Traditional"] =
        "Geleneksel",
    ["Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold."] =
        "İki sayı var ve kelimeleri birbirinden ayıran yalnızca ilki.\n\nÖlçekleme, her boşluğun genişliğidir; yazı tipinin kendi boşluk karakterinin yüzdesi olarak. %100 yazı tipinin doğal genişliğidir ve KOReader'ın varsayılanı %95 — yani biraz daha dar. Boşlukları açmak için %100'ün üstüne çıkın.\n\nDaraltma ise iki yana yaslama sırasında bu boşlukların, satıra bir kelime daha sığdırmak için ne kadar geri sıkıştırılabileceğidir. %100 sıkıştırmayı tamamen yasaklar; bu yüzden onu da yükseltin, yoksa açtığınız boşluklar kalıcı olmaz.",
    ["Typography and hyphenation: %1"] =
        "Tipografi ve heceleme: %1",
    ["Uppercase"] =
        "Büyük harf",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Paragraflar arasındaki dikey boşluk. Yayıncının kendi paragraf kenar boşlukları önce temizlenir; böylece seçtiğiniz değerin üzerine eklenmek yerine tam olarak o değer uygulanır.",
    ["Whitespace above chapter and section titles, so a chapter does not start flush against the top of the page.\n\n"] =
        "Bölüm ve alt bölüm başlıklarının üstündeki boşluk; böylece bölüm sayfanın tepesine yapışık başlamaz.\n\n",
    ["Whitespace between a chapter title and the text that follows it.\n\n"] =
        "Bölüm başlığı ile onu izleyen metin arasındaki boşluk.\n\n",
    ["Wide"] =
        "Geniş",
    ["Word expansion"] =
        "Kelime genişletme",
    ["Word spacing"] =
        "Kelime aralığı",
    ["book default"] =
        "kitap varsayılanı",
    ["hyphenation off"] =
        "heceleme kapalı",
    ["hyphenation on"] =
        "heceleme açık",
    ["off"] =
        "kapalı",
    ["on"] =
        "açık",
}
