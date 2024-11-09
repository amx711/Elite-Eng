local maxClients = GetConvarInt('sv_maxclients', 32)

function Log( line, title, msg)
    local embed = {}
    embed = {
      {
        ["color"] = 2303786,
        ["title"] = title,
        ["description"] = msg,
        ["thumbnail"] = {["url"] = "",},
        ["footer"] = {
          ["text"] = "Made With 🤍 By EliteCode | At " .. os.date("%x | %X") .. "",
          ["icon_url"] ="elitecode.xyz"
        },
      }
    }
    PerformHttpRequest(line,
    function(err, text, headers) end, 'POST',
    json.encode({ username = "EliteAc", embeds = embed, avatar_url = "" }),
      { ['Content-Type'] = 'application/json' })
  end

local function OnPlayerConnecting(name, setKickReason, deferrals)
	if GetNumPlayerIndices() < maxClients then
		deferrals.defer()
		local identifiers = GetPlayerIdentifiers(source)
		local cname = string.gsub(name, "%s+", "")
		deferrals.update(string.format("Hello %s. Your name is being checked.", name))

		-- Use this for logging and / or banning purposes!
		local ids = ''
		for _, v in pairs(identifiers) do
			local ids = ids..' '..v
		end

		if string.find(cname, "<script") then
			deferrals.done("Your username seems to be fishy...")
			Log(
                Elite.Logs,
                "**Some Fishy User is Here**",
                "**ID:** ``"..ids.."`` \n **Name:** ``"..GetPlayerName(source).."``"
              )
		else
			deferrals.done()
		end
	end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)
