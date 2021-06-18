local highlighter = require("vim.treesitter.highlighter")
local ts_utils = require "nvim-treesitter.ts_utils"

function _G.paracomm_treesitter_hl()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local self = highlighter.active[buf]

  if not self then return {} end

  local matches = {}

  self.tree:for_each_tree(function(tstree, tree)
    if not tstree then return end

    local root = tstree:root()
    local root_start_row, _, root_end_row, _ = root:range()

    -- Only worry about trees within the line range
    if root_start_row > row or root_end_row < row then return end

    local query = self:get_query(tree:lang())

    -- Some injected languages may not have highlight queries.
    if not query:query() then return end

    local iter = query:query():iter_captures(root, self.bufnr, row, row + 1)

    for capture, node in iter do
      local hl = query.hl_cache[capture]

      if hl and ts_utils.is_in_node_range(node, row, col) then
        local c = query._query.captures[capture] -- name of the capture in the query
        if c ~= nil then
          local general_hl = query:_get_hl_from_capture(capture)
          matches[c] = c
          matches[hl] = c
          matches[general_hl] = c
        end
      end
    end

  end, true)
  return matches
end
