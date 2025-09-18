-- Sketchybar Spaces Configuration
-- Manages workspace display and interaction with Aerospace window manager

local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Event registration
sbar.add("event", "aerospace_workspace_change")

-- State management
local spaces = {}
local spaces_indicator = nil
local focused_workspace = nil
local last_workspace_structure = ""

-- Configuration constants
local SPACE_CONFIG = {
	icon = {
		font = { family = settings.font.numbers },
		padding_left = 15,
		padding_right = 8,
		color = colors.white,
		highlight_color = colors.red,
	},
	label = {
		padding_right = 20,
		color = colors.grey,
		highlight_color = colors.white,
		font = "sketchybar-app-font:Regular:16.0",
		y_offset = -1,
	},
	padding_right = 1,
	padding_left = 1,
	background = {
		color = colors.bg1,
		border_width = 1,
		height = 26,
		border_color = colors.black,
	},
	popup = {
		background = {
			border_width = 5,
			border_color = colors.black,
		},
	},
}

local BRACKET_CONFIG = {
	background = {
		color = colors.transparent,
		border_color = colors.bg2,
		height = 28,
		border_width = 2,
	},
}

-- Utility functions
local function validate_workspace_id(workspace_id)
	return workspace_id and workspace_id ~= "" and tonumber(workspace_id) ~= nil
end

local function get_space_name(workspace_id)
	return "space." .. workspace_id
end

local function get_padding_name(workspace_id)
	return "space.padding." .. workspace_id
end

local function get_bracket_name(workspace_id)
	return "bracket." .. workspace_id
end

-- Generate a structure signature to detect changes
local function get_workspace_structure(workspace_ids)
	table.sort(workspace_ids, function(a, b)
		return tonumber(a) < tonumber(b)
	end)
	return table.concat(workspace_ids, ",")
end

-- Run aerospace through /bin/bash -lc to load user's shell environment/PATH
local function exec_aerospace(aero_args, callback)
	local cmd = string.format("/bin/bash -lc %q", "aerospace " .. aero_args)
	if callback then
		sbar.exec(cmd, callback)
	else
		sbar.exec(cmd)
	end
end

-- Fast appearance-only update using batched commands (no flicker)
local function update_space_appearances(workspace_data_map, current_focused_workspace)
	local batch_commands = {}

	for workspace_id, components in pairs(spaces) do
		local workspace_data = workspace_data_map[workspace_id]
		if workspace_data then
			local is_focused = current_focused_workspace == workspace_data.workspace
			local border_color = is_focused and colors.black or colors.bg2

			-- Build batch command for this space
			table.insert(batch_commands, "--set")
			table.insert(batch_commands, components.space.name)
			table.insert(batch_commands, "icon.highlight=" .. (is_focused and "true" or "false"))
			table.insert(batch_commands, "label.highlight=" .. (is_focused and "true" or "false"))
			table.insert(batch_commands, "background.border_color=" .. tostring(border_color))
			table.insert(batch_commands, "drawing=true")

			-- Update padding visibility
			if components.padding then
				table.insert(batch_commands, "--set")
				table.insert(batch_commands, components.padding.name)
				table.insert(batch_commands, "drawing=true")
			end
		else
			-- Hide spaces that no longer exist
			table.insert(batch_commands, "--set")
			table.insert(batch_commands, components.space.name)
			table.insert(batch_commands, "drawing=false")

			if components.padding then
				table.insert(batch_commands, "--set")
				table.insert(batch_commands, components.padding.name)
				table.insert(batch_commands, "drawing=false")
			end
		end
	end

	-- Execute all updates in a single batch
	if #batch_commands > 0 then
		sbar.exec("sketchybar " .. table.concat(batch_commands, " "))
	end
end

-- Clean up specific spaces by name
local function remove_spaces(workspace_ids_to_remove)
	if #workspace_ids_to_remove == 0 then
		return
	end

	local batch_commands = {}

	for _, workspace_id in ipairs(workspace_ids_to_remove) do
		local components = spaces[workspace_id]
		if components then
			if components.space and components.space.name then
				table.insert(batch_commands, "--remove")
				table.insert(batch_commands, components.space.name)
			end
			if components.bracket and components.bracket.name then
				table.insert(batch_commands, "--remove")
				table.insert(batch_commands, components.bracket.name)
			end
			if components.padding and components.padding.name then
				table.insert(batch_commands, "--remove")
				table.insert(batch_commands, components.padding.name)
			end
			spaces[workspace_id] = nil
		end
	end

	-- Execute all removals in a single batch
	if #batch_commands > 0 then
		sbar.exec("sketchybar " .. table.concat(batch_commands, " "))
	end
end

-- Remove and recreate spaces indicator
local function recreate_spaces_indicator()
	-- Remove existing indicator
	if spaces_indicator and spaces_indicator.name then
		sbar.remove(spaces_indicator.name)
	end

	-- Create new indicator
	spaces_indicator = sbar.add("item", "spaces_indicator", {
		position = "left",
		padding_left = -3,
		padding_right = 0,
		icon = {
			padding_left = 8,
			padding_right = 9,
			color = colors.grey,
			string = icons.switch.on,
		},
		label = {
			width = 0,
			padding_left = 0,
			padding_right = 8,
			string = "Spaces",
			color = colors.bg1,
		},
		background = {
			color = colors.with_alpha(colors.grey, 0.0),
			border_color = colors.with_alpha(colors.bg1, 0.0),
		},
	})

	-- Setup indicator interactions
	spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
		local currently_on = spaces_indicator:query().icon.value == icons.switch.on
		spaces_indicator:set({
			icon = currently_on and icons.switch.off or icons.switch.on,
		})
	end)

	spaces_indicator:subscribe("mouse.entered", function(env)
		sbar.animate("tanh", 30, function()
			spaces_indicator:set({
				background = {
					color = { alpha = 1.0 },
					border_color = { alpha = 1.0 },
				},
				icon = { color = colors.bg1 },
				label = { width = "dynamic" },
			})
		end)
	end)

	spaces_indicator:subscribe("mouse.exited", function(env)
		sbar.animate("tanh", 30, function()
			spaces_indicator:set({
				background = {
					color = { alpha = 0.0 },
					border_color = { alpha = 0.0 },
				},
				icon = { color = colors.grey },
				label = { width = 0 },
			})
		end)
	end)

	spaces_indicator:subscribe("mouse.clicked", function(env)
		sbar.trigger("swap_menus_and_spaces")
	end)
end

-- Create a single space component
local function create_space_components(workspace_id)
	if not validate_workspace_id(workspace_id) then
		return nil
	end

	-- Create space item
	local space_name = get_space_name(workspace_id)
	local space_config = {
		icon = { string = workspace_id },
		position = "left",
		drawing = false, -- Start hidden to reduce flicker
	}

	-- Merge with base config
	for key, value in pairs(SPACE_CONFIG) do
		if key ~= "icon" then
			space_config[key] = value
		else
			for icon_key, icon_value in pairs(value) do
				if icon_key ~= "string" then
					space_config.icon[icon_key] = icon_value
				end
			end
		end
	end

	local space_item = sbar.add("item", space_name, space_config)
	if not space_item then
		return nil
	end

	-- Create bracket
	local bracket = sbar.add("bracket", { space_item.name }, BRACKET_CONFIG)

	-- Create padding
	local padding_name = get_padding_name(workspace_id)
	local padding = sbar.add("item", padding_name, {
		script = "",
		width = settings.group_paddings,
		position = "left",
		drawing = false, -- Start hidden to reduce flicker
	})

	-- Setup interaction
	space_item:subscribe("mouse.clicked", function(env)
		if env.BUTTON == "left" then
			exec_aerospace("workspace " .. workspace_id)
		end
	end)

	return {
		space = space_item,
		bracket = bracket,
		padding = padding,
		workspace_id = workspace_id,
	}
end

-- Smart update: only recreate when structure changes
local function smart_update_spaces(workspaces_data, current_focused_workspace)
	if not workspaces_data then
		return
	end

	-- Step 1: Collect workspace data
	local workspace_ids = {}
	local workspace_map = {}

	for _, workspace_data in ipairs(workspaces_data) do
		local workspace_id = tostring(workspace_data.workspace)
		if validate_workspace_id(workspace_id) then
			table.insert(workspace_ids, workspace_id)
			workspace_map[workspace_id] = workspace_data
		end
	end

	-- Always include the focused workspace
	if current_focused_workspace and validate_workspace_id(tostring(current_focused_workspace)) then
		local focused_id = tostring(current_focused_workspace)
		local found = false
		for _, id in ipairs(workspace_ids) do
			if id == focused_id then
				found = true
				break
			end
		end
		if not found then
			table.insert(workspace_ids, focused_id)
			workspace_map[focused_id] = { workspace = current_focused_workspace }
		end
	end

	-- Step 2: Check if structure changed
	local new_structure = get_workspace_structure(workspace_ids)

	if new_structure == last_workspace_structure then
		-- Structure unchanged - just update appearances (no flicker)
		update_space_appearances(workspace_map, current_focused_workspace)
		return
	end

	-- Step 3: Structure changed - minimize flicker with smart updates
	last_workspace_structure = new_structure

	-- Sort workspace IDs numerically for consistent order
	table.sort(workspace_ids, function(a, b)
		return tonumber(a) < tonumber(b)
	end)

	-- Find spaces to remove
	local current_space_ids = {}
	for workspace_id in pairs(spaces) do
		current_space_ids[workspace_id] = true
	end

	local new_space_ids = {}
	for _, workspace_id in ipairs(workspace_ids) do
		new_space_ids[workspace_id] = true
	end

	-- Remove spaces that no longer exist
	local to_remove = {}
	for workspace_id in pairs(current_space_ids) do
		if not new_space_ids[workspace_id] then
			table.insert(to_remove, workspace_id)
		end
	end
	remove_spaces(to_remove)

	-- Create missing spaces
	for _, workspace_id in ipairs(workspace_ids) do
		if not spaces[workspace_id] then
			local components = create_space_components(workspace_id)
			if components then
				spaces[workspace_id] = components
			end
		end
	end

	-- Update all appearances with batch command
	update_space_appearances(workspace_map, current_focused_workspace)

	-- Recreate spaces indicator to ensure it appears at the end
	recreate_spaces_indicator()
end

-- Workspace change handler
local function handle_workspace_change(new_focused_workspace)
	focused_workspace = new_focused_workspace

	exec_aerospace("list-workspaces --all --json", function(workspaces_data)
		smart_update_spaces(workspaces_data, new_focused_workspace)
	end)
end

-- Initialize spaces observer
local function setup_workspace_observer()
	local space_window_observer = sbar.add("item", {
		drawing = false,
		updates = true,
	})

	space_window_observer:subscribe("aerospace_workspace_change", function(env)
		handle_workspace_change(env.FOCUSED_WORKSPACE)
	end)
end

-- Main initialization
local function initialize_spaces()
	-- Setup workspace change observer first
	setup_workspace_observer()

	-- Initial render - this will create the spaces first
	exec_aerospace("list-workspaces --all --json", function(workspaces_data)
		smart_update_spaces(workspaces_data, focused_workspace)
	end)
end

-- Start initialization
initialize_spaces()
