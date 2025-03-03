local ok_status, alpha = pcall(require, "alpha")
local ok_status, dashboard = pcall(require, "alpha.themes.dashboard")
if not ok_status then
    return
end

alpha.setup(dashboard.config)
