local S = minetest.get_translator("skinsdb")

unified_inventory.register_page("skins", {
	get_formspec = function(player)
		local skin = skins.get_player_skin(player)
		local formspec = "background[0.4,1.3;9.92,9.52;ui_misc_form.png]"..skins.get_skin_info_formspec(skin)..
				"button[.75,3;6.5,.5;skins_page;"..S("Change").."]"
		return {formspec=formspec}
	end,
})

unified_inventory.register_button("skins", {
	type = "image",
	image = "skins_button.png",
	tooltip = S("Skins"),
})

local function get_formspec(player)
	local context = skins.get_formspec_context(player)
	local formspec = "background[0.4,1.3;9.92,9.52;ui_misc_form.png]"..
			skins.get_skin_selection_formspec(player, context, 0.4)
	return formspec
end

unified_inventory.register_page("skins_page", {
	get_formspec = function(player)
		return {formspec=get_formspec(player)}
	end
})

-- click button handlers
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.skins then
		unified_inventory.set_inventory_formspec(player, "craft")
		return
	end

	if formname ~= "" then
		return
	end

	local context = skins.get_formspec_context(player)
	local action = skins.on_skin_selection_receive_fields(player, context, fields)
	if action == 'set' then
		unified_inventory.set_inventory_formspec(player, "skins")
	elseif action == 'page' then
		unified_inventory.set_inventory_formspec(player, "skins_page")
	end
end)
