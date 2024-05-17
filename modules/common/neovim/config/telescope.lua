local telescope = require("telescope.builtin")


-- Function to cut down config boilerplate
local key = function(mode, key_sequence, action, params)
    params = params or {}
    vim.keymap.set(mode, key_sequence, action, params)
end

key("n", "<Leader>k", telescope.keymaps, { desc = "keymaps" })
key("n", "<Leader>/", telescope.live_grep, { desc = "live grep" })
key("n", "<Leader>ff", telescope.find_files, { desc = "find files" })
key("n", "<Leader>fp", telescope.git_files, { desc = "git files" })
key("n", "<Leader>fw", telescope.grep_string, { desc = "grep for string" })
key("n", "<Leader>b", telescope.buffers, { desc = "search buffers" })
key("n", "<Leader>hh", telescope.help_tags, { desc = "help tags" })
key("n", "<Leader>fr", telescope.oldfiles, { desc = "oldfiles" })
key("n", "<Leader>cc", telescope.commands, { desc = "commands" })
key("n", "<Leader>gc", telescope.git_commits, { desc = "git commits" })
key("n", "<Leader>gf", telescope.git_bcommits, { desc = "git bcommits" })
key("n", "<Leader>gb", telescope.git_branches, { desc = "git branches" })
key("n", "<Leader>gs", telescope.git_status, { desc = "git status" })
key("n", "<Leader>s", telescope.current_buffer_fuzzy_find, { desc = "current buffer" })
key("n", "<Leader>rr", telescope.resume, { desc = "resume" })

key("n", "<Leader>N", function()
    local opts = {
        prompt_title = "Search Notes",
        cwd = "$NOTES_PATH",
    }
    telescope.live_grep(opts)
end)

key("n", "<Leader>fN", function()
    local opts = {
        prompt_title = "Find Notes",
        cwd = "$NOTES_PATH",
    }
    telescope.find_files(opts)
end)

key("n", "<Leader>cr", function()
    local opts = require("telescope.themes").get_ivy({
        layout_config = {
            bottom_pane = {
                height = 15,
            },
        },
    })
    telescope.command_history(opts)
end)

-- Zoxide
key("n", "<Leader>fz", require("telescope").extensions.zoxide.list)

-- Project
require("telescope").load_extension("projects")
key("n", "<C-p>", function()
    local opts = require("telescope.themes").get_ivy({
        layout_config = {
            bottom_pane = {
                height = 10,
            },
        },
    })
    require("telescope").extensions.projects.projects(opts)
end)

-- File browser
require("telescope").load_extension("file_browser")
key("n", "<Leader>fa", require("telescope").extensions.file_browser.file_browser)
key("n", "<Leader>fD", function()
    local opts = {
        prompt_title = "Find Downloads",
        cwd = "~/downloads",
    }
    require("telescope").extensions.file_browser.file_browser(opts)
end)
