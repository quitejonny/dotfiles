local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local isn = ls.indent_snippet_node

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})

local termcodes = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function ()
    if ls.expand_or_jumpable() then
        return termcodes("<Plug>luasnip-expand-or-jump")
    else
        return termcodes("<Tab>")
    end
end
_G.s_tab_complete = function()
    if ls and ls.jumpable(-1) then
        return termcodes("<Plug>luasnip-jump-prev")
    else
        return termcodes "<S-Tab>"
    end
end


local current_package = function(_, _, user_arg1)
    local path = vim.fn.expand('%')
    path = string.gsub(path, "%.pm$", "")
    path = string.gsub(path, "%.t$", "")
    path = string.gsub(path, "^.*/lib/", "")
    path = string.gsub(path, "^.*/backend%-tests/", "")
    path = string.gsub(path, "/", "::")
    return path
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local function current_elixir_module(_, _, user_arg1)
    local path = vim.fn.expand('%')
    path = string.gsub(path, "%.exs?$", "")
    path = string.gsub(path, "^.*elixir/lib/", "")
    path = string.gsub(path, "^.*elixir/test/", "")
    path = string.gsub(path, "/(.)", function(s) return "." .. string.upper(s) end)
    return path:gsub("_(.)", string.upper):gsub("^(.)", string.upper)
end

local function elixir_general_block(block, insertion, insertion_number)
    return s(block, {
        t({ block .. " " }), insertion(), t({ " do" }),
        isn(insertion_number or 1, { t({ "", "" }), i(1) }, "$PARENT_INDENT  "),
        t({ "", "end" }),
    })
end

local function elixir_block(block)
    return elixir_general_block(block, function() return i(1, "name") end, 2)
end

ls.add_snippets("elixir", {
    elixir_general_block("defmodule", function() return f(current_elixir_module, {}) end),
    elixir_general_block("test", function() return isn(1, { t({ "\"" }), i(1, "description"), t({ "\"" }) }, "") end, 2),
    elixir_block("case"),
    elixir_block("def"),
    elixir_block("defp"),
    elixir_block("pipeline"),
    elixir_block("scope"),
    s("paramtest", {
        t({ "for { value, result } <- ["}),
        isn(1, {
            isn(3, {
                isn(1, { t({ "", "{" }), i(1), t({ "}" }) }, "$PARENT_INDENT  "),
                t({ "", "] do" }),
            }, "$PARENT_INDENT  "),
            t({ "", "test \"" }),
            i(1),
            t({ " #{value}\" do"}),
            isn(2, { 
                t({ "", "assert "}),
                i(1),
                t({ "(unquote(value)) == unquote(result)" }) 
            }, "$PARENT_INDENT  "),
            t({ "", "end" }),
        }, "$PARENT_INDENT  "),
        t({ "", "end" }),
    }),
})

ls.add_snippets("perl", {
    s("package", {
        t( "package "),
        f(current_package, {}),
        t({ ";", "" }),
        i(0),
        t({ "", "", "1;" }),
    }),
    s("use Test::Spec", {
        t({ "use strict;", "use warnings;", "", "use Test::Spec;", "use Qwiki::Test;", "", "" }),
        t("describe '"),
        i(1, "description"),
        t({ "' => sub {"}),
        isn(2, {
            t({ "", "" }), i(1),
        }, "$PARENT_INDENT    "),
        t({ "", "};", "", "runtests unless caller;", "" }),
    }),
    s("use Data::Dumper", {
        t({
            "use Data::Dumper;",
            "use Qwiki::Utils::JSON qw( encodeJSON );",
            "print STDERR encodeJSON({ Body => Dumper(",
        }),
        i(1),
        t({ ") }) . \"\\n\";" }),
    }),
    s("use Moose", {
        t({ "use Moose;", "" }),
        i(0),
        t({ "", "", "no Moose;", "__PACKAGE__->meta->make_immutable;" }),
    }),
    s("use Moose::Exporter", {
        t({
            "use Moose::Exporter;",
            "",
            "Moose::Exporter->setup_import_methods( trait_aliases => [__PACKAGE__] );",
            "",
        }),
    }),
    s("tableSpec", {
        t({ "tableSpec { " }), i(1), t({ " } (" }),
        isn(2, {
            t({ "", "{ value => " }),
            i(1, "value"),
            t({ ", expected => " }),
            i(2, "expected"),
            t({ " }," }),
        }, "$PARENT_INDENT    "),
        t({ "", ");" }),
    }),
    s("it", {
        t({ "it '" }), i(1, "description"), t({ "' => sub {" }),
        isn(2, { t({ "", "" }), i(1) }, "$PARENT_INDENT    "),
        t({ "", "};" }),
    }),
    s("describe", {
        t({ "describe '" }), i(1, "description"), t({ "' => sub {" }),
        isn(2, { t({ "", "" }), i(1) }, "$PARENT_INDENT    "),
        t({ "", "};" }),
    }),
})
