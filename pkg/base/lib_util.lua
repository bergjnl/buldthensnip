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

function argb_split_to_merged(r,g,b,a)
	a = a or 0xFF
	return 256*(256*(256*a+r)+g)+b
end

function abgr_split_to_merged(r,g,b,a)
	a = a or 0xFF
	return 256*(256*(256*a+b)+g)+r
end


function recolor_component(r,g,b,mdata)
	for i=1,#mdata do
		if mdata[i].r == 0 and mdata[i].g == 0 and mdata[i].b == 0 then
			mdata[i].r = r
			mdata[i].g = g
			mdata[i].b = b
		end
	end
end
