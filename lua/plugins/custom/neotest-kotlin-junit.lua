-- TODO: actually get the custom treesitter kotlin parser working
local LOG_FILE = vim.fn.stdpath("cache") .. "/neotest_kotlin_debug.log"

local function log(msg)
	local f = io.open(LOG_FILE, "a")
	if f then
		f:write(msg .. "\n")
		f:close()
	end
end

-- lua/custom/neotest-kotlin-junit.lua
local neotest_kotlin = require("neotest-kotlin")

-- Patch discover_positions to include JUnit @Test methods
local original_get_positions = neotest_kotlin.discover_positions

neotest_kotlin.discover_positions = function(path)
	log("[DEBUG] discover_positions called for file:" .. path)

	local positions = original_get_positions(path)
	log("[DEBUG] Original Kotest positions:" .. vim.inspect(positions))

	-- Read the file into a buffer for Treesitter parsing
	local lines = vim.fn.readfile(path)
	if not lines or #lines == 0 then
		log("[DEBUG] Could not read file or file empty")
		return positions
	end

	local content = table.concat(lines, "\n")
	local lang = "kotlin"
	local parser = vim.treesitter.get_string_parser(content, lang)
	if not parser then
		log("[DEBUG] No parser found for file")
		return positions
	end

	local tree = parser:parse()[1]
	local root = tree:root()
	local query = vim.treesitter.parse_query(
		lang,
		[[
    (function_declaration
      (modifiers
        (annotation
          (simple_identifier) @annotation_name
        )
      )
      name: (simple_identifier) @fn_name
    )
  ]]
	)

	for id, node in query:iter_captures(root, 0) do
		local capture_name = query.captures[id]
		local text = vim.treesitter.get_node_text(node, 0)
		log(string.format("[DEBUG] Capture: %s -> %s", capture_name, text))
		if capture_name == "annotation_name" and text == "Test" then
			local fn_node = node.parent.field("name")[1]
			if fn_node then
				local fn_name = vim.treesitter.get_node_text(fn_node, 0)
				log("[DEBUG] Found JUnit test function:" .. fn_name)
				local class_name = vim.fn.fnamemodify(path, ":t:r")
				local pkg_line = vim.fn.systemlist("grep '^package ' " .. path)[1] or ""
				local pkg = pkg_line:match("package%s+([%w%.]+)")
				local fqn = pkg and (pkg .. "." .. class_name) or class_name
				positions[fn_name] = {
					type = "test",
					id = fqn .. "." .. fn_name,
					name = fn_name,
					range = { 0, 0, 0, 0 },
				}
			else
				log("[DEBUG] Could not find function name node for @Test")
			end
		end
	end

	log("[DEBUG] Final positions:" .. vim.inspect(positions))
	return positions
end

-- Wrap adapter for Neotest
return function()
	return neotest_kotlin
end
