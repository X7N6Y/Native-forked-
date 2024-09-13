local Projects = {
	["Death Ball"] = {
		GameId = 5166944221;
		PlaceIds = {};
		Loader = "https://api.luarmor.net/files/v3/loaders/c1e22c6997f84329ce2f8667f71828f8.lua";
	};
	["Anime Vanguards"] = {
		GameId = 5578556129;
		PlaceIds = {};
		Loader = "https://api.luarmor.net/files/v3/loaders/c296c70e07b1a42087ce52d1d2625af6.lua";
	};
};

local Loaded = false

for i, v in pairs(Projects) do
	if v.GameId == game.GameId then
		Loaded = true

		(loadstring or load)(game:HttpGet(v.Loader))()

		print(("Loaded %s"):format(i))

		break
	end
end

if not Loaded then
	warn(("Unrecognized GameId %d"):format(game.GameId))

	setclipboard(tostring(game.GameId))
end
