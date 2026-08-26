local _ = require("readingstyle_gettext")
return {
    name = "readingstyle",
    fullname = _("Reading style"),
    description = _([[Plain controls for the settings that decide how a book looks — paragraph indentation and spacing, space around chapter titles, alignment, margins, images — with presets and per-book or per-language styles.

Builds on KOReader's style tweaks rather than replacing them: everything left at "book default" leaves your tweaks and the publisher's styles untouched.]]),
    version = "1.0.0",
}
