-- Project/session picker: Shift-Cmd-K
dofile(os.getenv("HOME") .. "/dev/rex-sesh/rex-config.lua")

-- Rex Nvim Navigator
local data = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
local plugin = data .. "/nvim/lazy/rex-navigator.nvim"
local ok, err = pcall(function()
	dofile(plugin .. "/rex/navigator.lua").setup()
end)
if not ok then
	rex.log("warn", "rex-navigator not loaded: " .. tostring(err))
end
