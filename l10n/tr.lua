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
    ["A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nThe language comes from the book's own metadata. When a book declares none this is greyed out, but you can give it one yourself: Book information, hold the language field, and set it. Reopen the book afterwards."] =
        "Bu dildeki kitaplar için ayrı bir stil; bir dil farklı paragraf alışkanlıklarıyla daha iyi okunduğunda işe yarar.\n\nDil, kitabın kendi üstverisinden gelir. Kitap dil bildirmiyorsa bu seçenek soluk kalır; ama dili kendiniz de verebilirsiniz: Kitap bilgisi, dil alanına basılı tutun ve ayarlayın. Ardından kitabı yeniden açın.",
    ["A style stored with this book alone.\n\nSwitching between these three only changes which one you are editing and which one this book uses. The others keep their settings."] =
        "Yalnızca bu kitapla birlikte saklanan bir stil.\n\nBu üçü arasında geçiş yapmak sadece hangisini düzenlediğinizi ve bu kitabın hangisini kullandığını değiştirir. Diğerleri ayarlarını korur.",
    ["A thin line under chapter titles, in the manner of an older printed book."] =
        "Bölüm başlıklarının altına ince bir çizgi; eski basılı kitaplardaki gibi.",
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
    ["Avoid widows and orphans"] =
        "Dul ve yetim satırları önle",
    ["Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."] =
        "Paragraflar arasında boş satır, girinti yok, cömert satır aralığı ve kenar boşlukları. Yorgun gözler için rahat.",
    ["Block quotes"] =
        "Alıntı blokları",
    ["Bold"] =
        "Kalın",
    ["Bold instead of italic"] =
        "İtalik yerine kalın",
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
    ["Clears tinted boxes and page backgrounds. On a greyscale screen these become flat grey blocks that make the text on them harder to read."] =
        "Renkli kutuları ve sayfa arka planlarını temizler. Gri tonlamalı ekranda bunlar düz gri bloklara dönüşür ve üzerlerindeki metni okumayı zorlaştırır.",
    ["Close"] =
        "Kapat",
    ["Compact"] =
        "Sıkışık",
    ["Could not write the file: %1"] =
        "Dosya yazılamadı: %1",
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
    ["Delete"] =
        "Sil",
    ["Delete the %1 style"] =
        "%1 stilini sil",
    ["Delete the style for this language"] =
        "Bu dilin stilini sil",
    ["Delete the style stored at that level?"] =
        "O seviyede saklanan stil silinsin mi?",
    ["Delete this book's style"] =
        "Bu kitabın stilini sil",
    ["Deletes the style stored at that level. Editing moves to the next level up, and its style takes over."] =
        "O seviyede saklanan stili siler. Düzenleme bir üst seviyeye geçer ve oradaki stil devralır.",
    ["Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach."] =
        "Başlığı doğrudan izleyen paragrafın ilk satırını girintilemez; alışılmış tipografi kuralı budur.\n\nYalnızca başlığın hemen ardından gelen paragraflara ulaşır. Bölüm başlangıcını bir kapsayıcı içine saran kitaplar erişim dışındadır.",
    ["E-reader"] =
        "E-okuyucu",
    ["Edit this book's own tweak"] =
        "Bu kitabın kendi ince ayarını düzenle",
    ["Emphasis"] =
        "Vurgu",
    ["Exactly what this plugin is appending to your stylesheet right now. Worth pasting into a bug report."] =
        "Bu eklentinin şu anda stil sayfanıza eklediği şeyin tamamı. Hata bildirimine yapıştırmaya değer.",
    ["Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched."] =
        "Harfler arasındaki ek boşluk. Küçük değerler okunaklığı artırabilir; 0.1 em üzerindeki değerler metni gerilmiş gösterir.",
    ["First paragraph after a heading"] =
        "Başlıktan sonraki ilk paragraf",
    ["Fit to page width"] =
        "Sayfa genişliğine sığdır",
    ["Fit to text width"] =
        "Metin genişliğine sığdır",
    ["Font weight"] =
        "Yazı kalınlığı",
    ["Footnote markers and cross-references are usually blue, which renders as a mid grey."] =
        "Dipnot işaretleri ve çapraz referanslar genelde mavidir; bu da orta bir gri olarak basılır.",
    ["Force a page break before each chapter title, the way a printed book does.\n\nChoosing H1 and H2 also keeps a subtitle from starting a second page of its own."] =
        "Her bölüm başlığından önce sayfa sonu koyar; basılı kitaplardaki gibi.\n\nH1 ve H2 seçilirse, alt başlığın kendi başına ikinci bir sayfa açması da engellenir.",
    ["Force black text"] =
        "Metni siyaha zorla",
    ["H1 and H2"] =
        "H1 ve H2",
    ["H1 only"] =
        "Yalnızca H1",
    ["H1, H2 and H3"] =
        "H1, H2 ve H3",
    ["Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."] =
        "Elle yazılmış CSS. Yukarıdaki denetimlerin ürettiği her şeyin sonuna eklenir, bu yüzden her zaman üstün gelir. Diğer ayarlar gibi, düzenlemekte olduğunuz kapsamı izler.",
    ["Header and footer"] =
        "Üst ve alt bilgi çubuğu",
    ["Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes."] =
        "Her satırın yüksekliği, yüzde olarak. Bu, KOReader'ın kendi satır aralığı ayarıdır; alt menüdeki ile aynı ayardır.",
    ["Hide images"] =
        "Görselleri gizle",
    ["Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line."] =
        "Yatay sayfa kenar boşlukları. Metin sütununun genişliğini bunlar belirler: geniş kenar boşluğu, daha dar ve gözle takibi kolay satır demektir.",
    ["How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from."] =
        "Her paragrafın ilk satırının ne kadar içeriden başlayacağı. Kapsayıcılardan, başlıklardan, liste öğelerinden ve tablo hücrelerinden miras alınan girintiyi de temizler; katlanmış girintilerin kaynağı budur.",
    ["How quoted passages are set apart from the body text. \"No special treatment\" clears the publisher's own indentation and italics instead of adding to them."] =
        "Alıntı pasajlarının gövde metninden nasıl ayrıldığı. \"Özel biçim yok\", yayıncının kendi girintisini ve italiğini üzerine eklemek yerine temizler.",
    ["Image alignment"] =
        "Görsel hizalaması",
    ["Image width"] =
        "Görsel genişliği",
    ["Images"] =
        "Görseller",
    ["Indent"] =
        "Girinti",
    ["Indented"] =
        "Girintili",
    ["Indented and italic"] =
        "Girintili ve italik",
    ["Ink and links"] =
        "Mürekkep ve bağlantılar",
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
    ["Lets preformatted blocks — code listings, terminal output — wrap instead of running off the edge of the page."] =
        "Önbiçimli blokların — kod listeleri, terminal çıktısı — sayfa kenarından taşmak yerine alt satıra kaymasını sağlar.",
    ["Letter spacing"] =
        "Harf aralığı",
    ["Line"] =
        "Satır",
    ["Line spacing"] =
        "Satır aralığı",
    ["Links in black"] =
        "Bağlantılar siyah",
    ["Links without underline"] =
        "Bağlantıların altı çizili değil",
    ["Load reading style preset"] =
        "Okuma stili hazır ayarını yükle",
    ["Makes the text heavier or lighter than the font's own weight. A small increase is the most effective answer to a font that prints faintly on e-ink.\n\nThis is KOReader's own font weight setting."] =
        "Metni yazı tipinin kendi kalınlığından daha kalın ya da daha ince yapar. E-ink'te soluk basan bir yazı tipine karşı en etkili çözüm, küçük bir artıştır.\n\nBu, KOReader'ın kendi yazı kalınlığı ayarıdır.",
    ["Margin presets"] =
        "Kenar boşluğu hazır ayarları",
    ["Narrow"] =
        "Dar",
    ["Needs a font that can produce small capitals, or the reader's font will synthesise them and the result can look uneven."] =
        "Küçük kapiteller üretebilen bir yazı tipi gerekir; aksi halde okuyucunun yazı tipi bunları taklit eder ve sonuç dengesiz görünebilir.",
    ["No indentation"] =
        "Girinti yok",
    ["No space above"] =
        "Üstünde boşluk yok",
    ["No special treatment"] =
        "Özel biçim yok",
    ["Normal"] =
        "Normal",
    ["Nothing is being generated: every setting is at book default."] =
        "Hiçbir şey üretilmiyor: bütün ayarlar kitap varsayılanında.",
    ["On H1"] =
        "H1'de",
    ["On H1 and H2"] =
        "H1 ve H2'de",
    ["On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size."] =
        "İki yana yaslı satırlarda boşluklar çok açıldığında, fazla boşluğun harf aralığı olarak kelimelerin içine dağıtılmasına izin verir. Yazı tipi boyutunun yüzdesi olarak ayarlanır.",
    ["On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."] =
        "Açıkken değişiklikler yapar yapmaz görünür. Kapalıyken biriktirilir ve yalnızca \"Şimdi uygula\" dediğinizde uygulanır.\n\nHer uygulama kitabı yeniden işler; bu yüzden birçok ayarı arka arkaya değiştirirken kapatmak işe yarar.",
    ["Only the settings this plugin owns travel with a language: indentation, spacing, alignment, chapter titles, images, custom CSS.\n\nLine spacing, margins and word spacing belong to KOReader, which stores them per book and has no notion of a language, so they stay where they are."] =
        "Bir dille birlikte yalnızca bu eklentinin sahip olduğu ayarlar taşınır: girinti, boşluk, hizalama, bölüm başlıkları, görseller, özel CSS.\n\nSatır aralığı, kenar boşlukları ve kelime aralığı KOReader'a aittir; onları kitap bazında saklar ve dil diye bir kavramı yoktur, bu yüzden oldukları gibi kalırlar.",
    ["Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."] =
        "KOReader'ın kitaba özel stil ince ayarı düzenleyicisini açar; CSS önerileri ve biçimlendiricisiyle birlikte. O ince ayar bu eklentiden ayrı olarak KOReader tarafından saklanır ve bu ayarlardan önce uygulanır.",
    ["Original size"] =
        "Özgün boyut",
    ["Overrides every colour the publisher chose, including the greys used for asides and captions, which print faintly on e-ink.\n\nAlso blackens borders."] =
        "Yayıncının seçtiği bütün renkleri ezer; ara notlarda ve resim altyazılarında kullanılan ve e-ink'te soluk basan grileri de.\n\nKenarlıkları da siyaha çevirir.",
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
    ["Puts everything this menu marks as changed back to default, at the level you are editing: this plugin's settings return to book default, and KOReader's own — line spacing, word spacing, font weight, margins — return to theirs.\n\nStyles stored at the other levels are not touched; deleting those is a separate action."] =
        "Bu menünün değişmiş olarak işaretlediği her şeyi, düzenlemekte olduğunuz seviyede varsayılana döndürür: bu eklentinin ayarları kitap varsayılanına, KOReader'ın kendi ayarları — satır aralığı, kelime aralığı, yazı kalınlığı, kenar boşlukları — kendi varsayılanlarına döner.\n\nDiğer seviyelerde saklanan stillere dokunulmaz; onları silmek ayrı bir eylemdir.",
    ["Quick style"] =
        "Hızlı stil",
    ["Reading style"] =
        "Okuma stili",
    ["Reading style: %1"] =
        "Okuma stili: %1",
    ["Reduction"] =
        "Daraltma",
    ["Remove background colours"] =
        "Arka plan renklerini kaldır",
    ["Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title."] =
        "Başlıktan sonraki ilk paragrafın üstündeki boşluğu kaldırır; paragraf doğrudan bölüm başlığının altına oturur.",
    ["Removes every image from the page, for reading a heavily illustrated book as plain text.\n\nCaptions stay, since they are ordinary text."] =
        "Sayfadaki bütün görselleri kaldırır; bol resimli bir kitabı düz metin gibi okumak için.\n\nResim altyazıları kalır, çünkü onlar sıradan metindir.",
    ["Replace"] =
        "Değiştir",
    ["Replaces italics with something else. Worth it when a book's italic face is thin or hard to read on screen."] =
        "İtaliği başka bir şeyle değiştirir. Kitabın italik yüzü inceyse veya ekranda zor okunuyorsa işe yarar.",
    ["Reset"] =
        "Sıfırla",
    ["Reset all four margins to their defaults?"] =
        "Dört kenar boşluğu da varsayılanlarına sıfırlansın mı?",
    ["Reset all reading style settings"] =
        "Tüm okuma stili ayarlarını sıfırla",
    ["Reset chapter settings"] =
        "Bölüm ayarlarını sıfırla",
    ["Reset every text setting in this section, including KOReader's own line spacing, word spacing, word expansion and font weight?"] =
        "Bu bölümdeki bütün metin ayarları, KOReader'ın kendi satır aralığı, kelime aralığı, kelime genişletme ve yazı kalınlığı ayarları dahil, sıfırlansın mı?",
    ["Reset image settings"] =
        "Görsel ayarlarını sıfırla",
    ["Reset ink settings"] =
        "Mürekkep ayarlarını sıfırla",
    ["Reset margins"] =
        "Kenar boşluklarını sıfırla",
    ["Reset paragraph settings"] =
        "Paragraf ayarlarını sıfırla",
    ["Reset text settings"] =
        "Metin ayarlarını sıfırla",
    ["Reset the chapter title settings to the publisher's defaults?"] =
        "Bölüm başlığı ayarları yayıncı varsayılanlarına sıfırlansın mı?",
    ["Reset the colour and link settings to the publisher's defaults?"] =
        "Renk ve bağlantı ayarları yayıncı varsayılanlarına sıfırlansın mı?",
    ["Reset the image settings to the publisher's defaults?"] =
        "Görsel ayarları yayıncı varsayılanlarına sıfırlansın mı?",
    ["Reset the paragraph settings to the publisher's defaults?"] =
        "Paragraf ayarları yayıncı varsayılanlarına sıfırlansın mı?",
    ["Right"] =
        "Sağ",
    ["Rule under the title"] =
        "Başlığın altına çizgi",
    ["Save as a style tweak"] =
        "Stil ince ayarı olarak kaydet",
    ["Save current reading style as preset"] =
        "Geçerli okuma stilini hazır ayar olarak kaydet",
    ["Saved to %1\n\nIt appears under Style tweaks, in User style tweaks, once KOReader is restarted."] =
        "%1 konumuna kaydedildi\n\nKOReader yeniden başlatıldığında Stil ince ayarları altında, Kullanıcı stil ince ayarları içinde görünür.",
    ["Scaling"] =
        "Ölçekleme",
    ["Shrinks footnote markers and the like, and stops them from stretching the line they sit on."] =
        "Dipnot işaretlerini ve benzerlerini küçültür, bulundukları satırı germelerini engeller.",
    ["Size of chapter titles, as a percentage of the surrounding text.\n\n"] =
        "Bölüm başlıklarının, çevresindeki metnin yüzdesi olarak boyutu.\n\n",
    ["Small capitals"] =
        "Küçük kapiteller",
    ["Smaller sub- and superscript"] =
        "Daha küçük alt ve üst simge",
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
    ["Start chapters on a new page"] =
        "Bölümler yeni sayfada başlasın",
    ["Stop a paragraph from leaving a single line stranded at the top or bottom of a page.\n\nPages end less evenly as a result, and the page count shifts."] =
        "Bir paragrafın sayfanın başında veya sonunda tek satır bırakmasını engeller.\n\nBunun sonucu olarak sayfalar daha az düzgün biter ve sayfa sayısı kayar.",
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
    ["The style you edit here is used for every book that has no style of its own."] =
        "Burada düzenlediğiniz stil, kendine ait bir stili olmayan her kitap için kullanılır.",
    ["This book"] =
        "Bu kitap",
    ["This book only"] =
        "Yalnızca bu kitap",
    ["This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.\n\nAnything left at \"book default\" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.\n\nEvery change re-renders the book. That is normal, and is what KOReader does for any style change."] =
        "\nBu eklenti küçük bir stil sayfası yazar ve onu stil ince ayarlarınızın sonuna ekler; bu yüzden ikisinin çakıştığı her yerde bu eklentinin ayarları üstün gelir.\n\n\"Kitap varsayılanı\"nda bırakılan hiçbir ayar için CSS üretilmez; ince ayarlarınız ve yayıncının stilleri olduğu gibi kalır.\n\nHer değişiklik kitabı yeniden işler. Bu normaldir; KOReader herhangi bir stil değişikliğinde aynısını yapar.",
    ["This replaces the style already stored at that level with the settings you are looking at now.\n\nContinue?"] =
        "Bu, o seviyede zaten saklanan stili şu anda baktığınız ayarlarla değiştirir.\n\nDevam edilsin mi?",
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
    ["Underlined instead of italic"] =
        "İtalik yerine altı çizili",
    ["Uppercase"] =
        "Büyük harf",
    ["Use these settings for all books"] =
        "Bu ayarları tüm kitaplar için kullan",
    ["Use these settings for all books in %1"] =
        "Bu ayarları %1 dilindeki tüm kitaplar için kullan",
    ["Use these settings for all books in this language"] =
        "Bu ayarları bu dildeki tüm kitaplar için kullan",
    ["Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top."] =
        "Paragraflar arasındaki dikey boşluk. Yayıncının kendi paragraf kenar boşlukları önce temizlenir; böylece seçtiğiniz değerin üzerine eklenmek yerine tam olarak o değer uygulanır.",
    ["View generated CSS"] =
        "Üretilen CSS'i göster",
    ["What counts as a chapter"] =
        "Neyin bölüm sayılacağı",
    ["Which heading levels the settings below apply to.\n\nMost books mark chapters as H1, many use H2, and a few use H3. Including H3 in a book full of sub-headings will space out things that are not chapters at all.\n\nAlignment is deliberately left out of this: it always applies to every heading level."] =
        "Aşağıdaki ayarların hangi başlık düzeylerine uygulanacağı.\n\nÇoğu kitap bölümleri H1 olarak işaretler, birçoğu H2 kullanır, birkaçı da H3. Alt başlığı bol bir kitapta H3'ü de dahil etmek, bölüm olmayan şeylerin arasını açar.\n\nHizalama bilerek bunun dışında tutuldu: o her zaman bütün başlık düzeylerine uygulanır.",
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
    ["Wrap long code lines"] =
        "Uzun kod satırlarını sar",
    ["Writes the generated CSS into KOReader's own user style tweaks folder, where it works without this plugin. A way out that does not cost you your settings."] =
        "Üretilen CSS'i KOReader'ın kendi kullanıcı stil ince ayarları klasörüne yazar; orada bu eklenti olmadan da çalışır. Ayarlarınızı kaybettirmeyen bir çıkış yolu.",
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
