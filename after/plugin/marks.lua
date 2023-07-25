require "marks".setup {
    default_mappings = true,
    -- which builtin marks to show. default {}, example below:
    -- builtin_marks = {".", "<", ">", "^"},
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 150,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = {lower = 10, upper = 15, builtin = 8, bookmark = 20},
    excluded_filetypes = {},
    mappings = {}
}

-- Bindings:
--
-- mx              Set mark x
-- m,              Set the next available alphabetical (lowercase) mark
-- m;              Toggle the next available mark at the current line
-- dmx             Delete mark x
-- dm-             Delete all marks on the current line
-- dm<space>       Delete all marks in the current buffer
-- m]              Move to next mark
-- m[              Move to previous mark
-- m:              Preview mark. This will prompt you for a specific mark to preview; press <cr> to preview the next mark.
-- m[0-9]          Add a bookmark from bookmark group[0-9].
-- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
-- m}              Move to the next bookmark having the same type as the bookmark under the cursor. Works across buffers.
-- m{              Move to the previous bookmark having the same type as the bookmark under the cursor. Works across buffers.
-- dm=             Delete the bookmark under the cursor.
