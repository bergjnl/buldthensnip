--[[
    This file is part of Ice Lua Components.

    Ice Lua Components is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Ice Lua Components is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with Ice Lua Components.  If not, see <http://www.gnu.org/licenses/>.
]]

if client then
-- load images
local img_font_numbers = common.img_load("pkg/base/gfx/font-numbers.tga")
local img_font_mini = common.img_load("pkg/base/gfx/font-mini.tga")
--[[
client.img_free(img_font_numbers)
img_font_numbers = nil -- PLEASE DO THIS, GUYS!
]]

local digit_map = {
	[" "] = 0,
	["0"] = 1,
	["1"] = 2,
	["2"] = 3,
	["3"] = 4,
	["4"] = 5,
	["5"] = 6,
	["6"] = 7,
	["7"] = 8,
	["8"] = 9,
	["9"] = 10,
	["-"] = 11,
}

-- TODO: find a better solution than this shit
-- y'know, just in case someone decides they're going to play this with an AZERTY
local shift_map = {
	["1"] = "!", ["2"] = "@", ["3"] = "#", ["4"] = "$", ["5"] = "%",
	["6"] = "^", ["7"] = "&", ["8"] = "*", ["9"] = "(", ["0"] = ")",
	["`"] = "~", ["-"] = "_", ["="] = "+",
	["["] = "{", ["]"] = "}", ["\\"] = "|",
	[";"] = ":", ["'"] = "\"",
	[","] = "<", ["."] = ">", ["/"] = "?",
}

function gui_print_mini(x, y, c, str)
	local i
	for i=1,#str do
		client.img_blit(img_font_mini, x, y, 6, 8, (string.byte(str,i)-32)*6, 0, c)
		x = x + 6
	end
end

function gui_print_digits(x, y, c, str)
	local i
	for i=1,#str do
		client.img_blit(img_font_numbers, x, y, 32, 48, digit_map[string.sub(str,i,i)]*32, 0, c)
		x = x + 32
	end
end

function gui_print_mini_wrap(wp, x, y, c, str)
	-- TODO!
	-- note: [W]idth in [P]ixels
	gui_print_mini(x, y, c, str)
end

function gui_get_char(key, modif)
	if key >= 32 and key <= 126 then
		local shifted = (bit_and(modif, KMOD_SHIFT) ~= 0)
		local crapslock = (bit_and(modif, KMOD_CAPS) ~= 0)
		if key >= SDLK_a and key <= SDLK_z then
			if shifted ~= crapslock then
				key = key - 32
			end
		end
		
		local k = string.char(key)
		k = (shifted and shift_map[k]) or k
		return k
	end
	
	-- TODO: check some other things
	
	return nil
end

function gui_string_edit(str, maxlen, key, modif)
	if key == SDLK_BACKSPACE then
		str = string.sub(str, 1, #str-1)
	else
		local k = gui_get_char(key, modif)
		
		if #str < maxlen and k then
			str = str .. k
		end
	end
	
	return str
end

function gui_rect_frame_test()
    -- someday this will grow up to be a real rectangle renderer
    local img = common.img_new(32, 32)
    for x = 0, 31, 1 do
        for y = 0, 31, 1 do
            common.img_pixel_set(img, x, y, 0xFFFF0000)
        end
    end
    client.img_blit(img, 0, 0)
    common.img_free(img)
end

end
