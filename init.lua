directionalgravity = {}

minetest.register_chatcommand("gravity", {
    params = "[<direction>]",
    -- Short parameter description.  See the below note.

    description = "changes player's gravity - argument is the direction to fall in (i.e. \"-y\" as default or \"0\" as no gravity)",
    -- General description of the command's purpose.

    privs = {},
    -- Required privileges to run. See `minetest.check_player_privs()` for
    -- the format and see [Privileges] for an overview of privileges.

    -- func = send_word(name, param)
    func = function(name, param)
      if param == nil then
        return false
      end
      return change_gravity(name, param)
    end,
    -- Called when command is run.
    -- * `name` is the name of the player who issued the command.
    -- * `param` is a string with the full arguments to the command.
    -- Returns a boolean for success and a string value.
    -- The string is shown to the issuing player upon exit of `func` or,
    -- if `func` returns `false` and no string, the help message is shown.
})


function change_gravity(name, direction)
  minetest.chat_send_player(name, "|"..direction.."|")
  if direction == "+y" then
    playerphysics.add_physics_factor(minetest.get_player_by_name(name), "gravity", "directional gravity", -1)
  elseif direction == "-y" then
    playerphysics.add_physics_factor(minetest.get_player_by_name(name), "gravity", "directional gravity", 1)
  elseif direction == "0" or string.match(direction, "^[+-][xz]$") then
    playerphysics.add_physics_factor(minetest.get_player_by_name(name), "gravity", "directional gravity", 0)
  else
    return false
  end
end
