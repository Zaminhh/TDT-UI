--[[
    TDTLib UI V2 (Switch Hub Edition)
    • Modern Card-Based Hub with Home Dashboard & Detail Pages
    • Dynamic Island Top Menu Controller
    • Full Lucide Icon integration (https://lucide.dev/icons/)
    • Single Left Logo header layout
    • Smooth Animations & Transitions
    • Backward-compatible API for existing scripts
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")

local function getGuiParent()
    if CoreGui and pcall(function() return CoreGui.Name end) then
        return CoreGui
    end
    return PlayerGui or LocalPlayer:WaitForChild("PlayerGui")
end

-- =========================================================================
-- LUCIDE ICONS DATABASE (Auto-import from lucide.dev repository + Fallbacks)
-- =========================================================================
local LucideIcons = {
    ["accessibility"] = "rbxassetid://10709751939",
    ["activity"] = "rbxassetid://10709752035",
    ["air-vent"] = "rbxassetid://10709752131",
    ["airplay"] = "rbxassetid://10709752254",
    ["alarm-check"] = "rbxassetid://10709752405",
    ["alarm-clock"] = "rbxassetid://10709752630",
    ["alarm-clock-off"] = "rbxassetid://10709752508",
    ["alert-circle"] = "rbxassetid://10709752996",
    ["alert-octagon"] = "rbxassetid://10709753064",
    ["alert-triangle"] = "rbxassetid://10709753149",
    ["align-justify"] = "rbxassetid://10709759610",
    ["anchor"] = "rbxassetid://10709761530",
    ["aperture"] = "rbxassetid://10709761813",
    ["apple"] = "rbxassetid://10709761889",
    ["archive"] = "rbxassetid://10709762233",
    ["arrow-down"] = "rbxassetid://10709767827",
    ["arrow-left"] = "rbxassetid://10709768114",
    ["arrow-right"] = "rbxassetid://10709768347",
    ["arrow-up"] = "rbxassetid://10709768545",
    ["award"] = "rbxassetid://10709769508",
    ["axe"] = "rbxassetid://10709769598",
    ["backpack"] = "rbxassetid://10709769686",
    ["baggage-claim"] = "rbxassetid://10709769788",
    ["bar-chart"] = "rbxassetid://10709769889",
    ["battery"] = "rbxassetid://10709770560",
    ["battery-charging"] = "rbxassetid://10709770007",
    ["bell"] = "rbxassetid://10709775704",
    ["bell-ring"] = "rbxassetid://10709775600",
    ["binary"] = "rbxassetid://10709775829",
    ["bluetooth"] = "rbxassetid://10709775894",
    ["bold"] = "rbxassetid://10709775978",
    ["bomb"] = "rbxassetid://10709776036",
    ["book"] = "rbxassetid://10709776432",
    ["book-open"] = "rbxassetid://10709776307",
    ["bookmark"] = "rbxassetid://10709776608",
    ["bot"] = "rbxassetid://10709776735",
    ["box"] = "rbxassetid://10709776857",
    ["briefcase"] = "rbxassetid://10709776980",
    ["brush"] = "rbxassetid://10709777099",
    ["bug"] = "rbxassetid://10709777176",
    ["building"] = "rbxassetid://10709777324",
    ["calculator"] = "rbxassetid://10709777413",
    ["calendar"] = "rbxassetid://10709777620",
    ["camera"] = "rbxassetid://10709777823",
    ["cast"] = "rbxassetid://10709778103",
    ["check"] = "rbxassetid://10709778389",
    ["check-circle"] = "rbxassetid://10709778276",
    ["chevron-down"] = "rbxassetid://10709778521",
    ["chevron-left"] = "rbxassetid://10709778622",
    ["chevron-right"] = "rbxassetid://10709778713",
    ["chevron-up"] = "rbxassetid://10709778807",
    ["chevrons-down"] = "rbxassetid://10709778906",
    ["chrome"] = "rbxassetid://10709779339",
    ["circle"] = "rbxassetid://10709779558",
    ["clipboard"] = "rbxassetid://10709779838",
    ["clock"] = "rbxassetid://10709780038",
    ["cloud"] = "rbxassetid://10709780359",
    ["code"] = "rbxassetid://10709780709",
    ["codepen"] = "rbxassetid://10709780826",
    ["coffee"] = "rbxassetid://10709781048",
    ["coins"] = "rbxassetid://10709781154",
    ["command"] = "rbxassetid://10709781262",
    ["compass"] = "rbxassetid://10709781362",
    ["cpu"] = "rbxassetid://10709781603",
    ["crosshair"] = "rbxassetid://10709781919",
    ["crown"] = "rbxassetid://10709782017",
    ["database"] = "rbxassetid://10709782154",
    ["disc"] = "rbxassetid://10709782342",
    ["dollar-sign"] = "rbxassetid://10709782497",
    ["download"] = "rbxassetid://10709782725",
    ["droplet"] = "rbxassetid://10709782980",
    ["edit"] = "rbxassetid://10709783311",
    ["eye"] = "rbxassetid://10709783819",
    ["eye-off"] = "rbxassetid://10709783707",
    ["fast-forward"] = "rbxassetid://10709783934",
    ["feather"] = "rbxassetid://10709784030",
    ["file"] = "rbxassetid://10709784347",
    ["file-text"] = "rbxassetid://10709784236",
    ["film"] = "rbxassetid://10709784433",
    ["filter"] = "rbxassetid://10709784532",
    ["flag"] = "rbxassetid://10709784628",
    ["flame"] = "rbxassetid://10709784739",
    ["flash"] = "rbxassetid://10709819973",
    ["folder"] = "rbxassetid://10709785102",
    ["gamepad"] = "rbxassetid://10709785530",
    ["gamepad-2"] = "rbxassetid://10709785418",
    ["gauge"] = "rbxassetid://10709785648",
    ["gavel"] = "rbxassetid://10709785745",
    ["gift"] = "rbxassetid://10709785852",
    ["git-branch"] = "rbxassetid://10709785948",
    ["github"] = "rbxassetid://10709786259",
    ["globe"] = "rbxassetid://10709786448",
    ["grid"] = "rbxassetid://10709786630",
    ["hammer"] = "rbxassetid://10709786961",
    ["hand"] = "rbxassetid://10709787132",
    ["hard-drive"] = "rbxassetid://10709787262",
    ["hash"] = "rbxassetid://10709787360",
    ["headphones"] = "rbxassetid://10709787472",
    ["heart"] = "rbxassetid://10709787680",
    ["help-circle"] = "rbxassetid://10709787782",
    ["home"] = "rbxassetid://10709787900",
    ["image"] = "rbxassetid://10709788019",
    ["inbox"] = "rbxassetid://10709788118",
    ["info"] = "rbxassetid://10709788221",
    ["key"] = "rbxassetid://10709788350",
    ["keyboard"] = "rbxassetid://10709788460",
    ["layers"] = "rbxassetid://10709788608",
    ["layout"] = "rbxassetid://10709788734",
    ["life-buoy"] = "rbxassetid://10709788874",
    ["lightbulb"] = "rbxassetid://10709788993",
    ["link"] = "rbxassetid://10709789144",
    ["list"] = "rbxassetid://10709789280",
    ["lock"] = "rbxassetid://10709789505",
    ["map"] = "rbxassetid://10709789710",
    ["map-pin"] = "rbxassetid://10709789608",
    ["maximize"] = "rbxassetid://10709789835",
    ["message-circle"] = "rbxassetid://10709790202",
    ["message-square"] = "rbxassetid://10709790387",
    ["mic"] = "rbxassetid://10709790597",
    ["minimize"] = "rbxassetid://10709790797",
    ["minus"] = "rbxassetid://10709790900",
    ["moon"] = "rbxassetid://10709791174",
    ["mouse-pointer"] = "rbxassetid://10709791284",
    ["music"] = "rbxassetid://10709791437",
    ["navigation"] = "rbxassetid://10709791698",
    ["package"] = "rbxassetid://10709792102",
    ["palette"] = "rbxassetid://10709792274",
    ["paperclip"] = "rbxassetid://10709792408",
    ["pause"] = "rbxassetid://10709792632",
    ["percent"] = "rbxassetid://10709792742",
    ["phone"] = "rbxassetid://10709792942",
    ["pin"] = "rbxassetid://10709793137",
    ["play"] = "rbxassetid://10709793262",
    ["plus"] = "rbxassetid://10709793452",
    ["power"] = "rbxassetid://10709793644",
    ["printer"] = "rbxassetid://10709793751",
    ["radio"] = "rbxassetid://10709793863",
    ["refresh-ccw"] = "rbxassetid://10709794067",
    ["refresh-cw"] = "rbxassetid://10709794187",
    ["repeat"] = "rbxassetid://10709794300",
    ["rocket"] = "rbxassetid://10709794585",
    ["save"] = "rbxassetid://10709794729",
    ["scissors"] = "rbxassetid://10709794838",
    ["search"] = "rbxassetid://10709794966",
    ["send"] = "rbxassetid://10709795088",
    ["server"] = "rbxassetid://10709795207",
    ["settings"] = "rbxassetid://10709795325",
    ["share"] = "rbxassetid://10709795532",
    ["shield"] = "rbxassetid://10709795814",
    ["shield-alert"] = "rbxassetid://10709795643",
    ["shield-check"] = "rbxassetid://10709795727",
    ["shopping-bag"] = "rbxassetid://10709795922",
    ["shopping-cart"] = "rbxassetid://10709796030",
    ["shuffle"] = "rbxassetid://10709796144",
    ["sidebar"] = "rbxassetid://10709796245",
    ["skip-back"] = "rbxassetid://10709796349",
    ["skip-forward"] = "rbxassetid://10709796464",
    ["skull"] = "rbxassetid://10709796570",
    ["sliders"] = "rbxassetid://10709796682",
    ["smartphone"] = "rbxassetid://10709796803",
    ["smile"] = "rbxassetid://10709796918",
    ["sparkles"] = "rbxassetid://10709797008",
    ["speaker"] = "rbxassetid://10709797108",
    ["star"] = "rbxassetid://10709797232",
    ["sun"] = "rbxassetid://10709797437",
    ["sword"] = "rbxassetid://10709797532",
    ["swords"] = "rbxassetid://10709797532",
    ["target"] = "rbxassetid://10709797772",
    ["terminal"] = "rbxassetid://10709797880",
    ["thermometer"] = "rbxassetid://10709797980",
    ["thumbs-down"] = "rbxassetid://10709798083",
    ["thumbs-up"] = "rbxassetid://10709798188",
    ["timer"] = "rbxassetid://10709798284",
    ["trash"] = "rbxassetid://10709798485",
    ["trophy"] = "rbxassetid://10709798686",
    ["truck"] = "rbxassetid://10709798782",
    ["tv"] = "rbxassetid://10709798881",
    ["unlock"] = "rbxassetid://10709799003",
    ["upload"] = "rbxassetid://10709799110",
    ["user"] = "rbxassetid://10709799324",
    ["user-check"] = "rbxassetid://10709799216",
    ["users"] = "rbxassetid://10709799435",
    ["video"] = "rbxassetid://10709799547",
    ["volume-2"] = "rbxassetid://10709799868",
    ["wand"] = "rbxassetid://10709800072",
    ["wifi"] = "rbxassetid://10709800275",
    ["wrench"] = "rbxassetid://10709800419",
    ["zap"] = "rbxassetid://10709819973",
}

-- Background asynchronous loader to fetch entire online Lucide collection if available
task.spawn(function()
    pcall(function()
        local get = (syn and syn.request) or (http and http.request) or http_request or (game and game.HttpGet and function(url) return game:HttpGet(url) end)
        if typeof(get) == "function" then
            local str
            if game and game.HttpGet then
                str = game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/src/Icons.lua")
            else
                local resp = get({Url = "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/src/Icons.lua", Method = "GET"})
                str = resp and (resp.Body or resp.body)
            end
            if str then
                local fn = loadstring(str)
                if fn then
                    local data = fn()
                    local assets = (data and data.assets) or (typeof(data) == "table" and data)
                    if assets then
                        for k, v in pairs(assets) do
                            local cleanKey = string.lower(string.gsub(k, "^lucide%-", ""))
                            LucideIcons[cleanKey] = v
                            LucideIcons[k] = v
                        end
                    end
                end
            end
        end
    end)
end)

local function resolveIcon(iconName)
    if not iconName or iconName == "" then return "" end
    if string.find(tostring(iconName), "^rbxassetid://") or tonumber(iconName) then
        return tonumber(iconName) and ("rbxassetid://" .. tostring(iconName)) or tostring(iconName)
    end
    local raw = string.lower(tostring(iconName))
    local clean = string.gsub(raw, "^lucide%-", "")
    return LucideIcons[clean] or LucideIcons["lucide-" .. clean] or LucideIcons[raw] or "rbxassetid://10709778521"
end

-- =========================================================================
-- LIBRARY ROOT & THEME
-- =========================================================================
local Library = {
    Flags = {},
    ActiveDropdown = nil,
    Theme = {
        Window = Color3.fromRGB(12, 16, 15),
        Header = Color3.fromRGB(17, 21, 20),
        Surface = Color3.fromRGB(15, 20, 19),
        Surface2 = Color3.fromRGB(20, 26, 25),
        Hover = Color3.fromRGB(24, 32, 30),
        Line = Color3.fromRGB(36, 46, 44),
        Text = Color3.fromRGB(241, 246, 245),
        Muted = Color3.fromRGB(125, 139, 136),
        Muted2 = Color3.fromRGB(84, 96, 94),
        Accent = Color3.fromRGB(69, 235, 200),
        Accent2 = Color3.fromRGB(37, 198, 168),
        AccentInk = Color3.fromRGB(8, 45, 38),
        Danger = Color3.fromRGB(242, 85, 91),
        Warning = Color3.fromRGB(246, 194, 67),
        Success = Color3.fromRGB(73, 221, 126),
    },
}

local BASE_WIDTH = 720
local BASE_HEIGHT = 520
local HEADER_HEIGHT = 176

-- Utility helpers
local function create(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties or {}) do
        if property ~= "Parent" then
            instance[property] = value
        end
    end
    if properties and properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

local function addCorner(parent, radius)
    return create("UICorner", {
        CornerRadius = UDim.new(0, radius),
        Parent = parent,
    })
end

local function addStroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

local function tween(object, duration, properties, style, direction)
    local info = TweenInfo.new(
        duration or 0.18,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    local animation = TweenService:Create(object, info, properties)
    animation:Play()
    return animation
end

local function makeText(parent, properties)
    properties = properties or {}
    properties.BackgroundTransparency = properties.BackgroundTransparency == nil and 1 or properties.BackgroundTransparency
    properties.BorderSizePixel = 0
    properties.Font = properties.Font or Enum.Font.Gotham
    properties.TextColor3 = properties.TextColor3 or Library.Theme.Text
    properties.TextSize = properties.TextSize or 14
    properties.Parent = parent
    return create("TextLabel", properties)
end

-- =========================================================================
-- CREATE WINDOW
-- =========================================================================
function Library:CreateWindow(config)
    config = config or {}
    local Title = config.Title or "SWITCH HUB"
    local Subtitle = config.Subtitle or "CUSTOM UI • SMOOTH CONTROLS"
    local Keybind = config.Keybind or Enum.KeyCode.RightShift
    local DiscordLink = config.Discord or (config.Home and config.Home.Discord) or "https://discord.gg/tdt"
    local LogoAsset = config.Logo or config.LogoLeft or "rbxassetid://90621121286115"

    local parentGui = getGuiParent()
    local existing = parentGui:FindFirstChild("SwitchHubUI")
    if existing then existing:Destroy() end

    local gui = create("ScreenGui", {
        Name = "SwitchHubUI",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 100,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = parentGui,
    })

    -- Overlay container for Dropdowns (to be always on top of everything without clipping)
    local dropdownOverlayContainer = create("Frame", {
        Name = "DropdownOverlayContainer",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ZIndex = 500,
        Visible = false,
        Parent = gui,
    })

    local dropdownClickAway = create("TextButton", {
        Name = "ClickAway",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 501,
        Parent = dropdownOverlayContainer,
    })

    local activeOverlayMenu = create("Frame", {
        Name = "OverlayMenu",
        Size = UDim2.fromOffset(160, 100),
        BackgroundColor3 = Color3.fromRGB(22, 28, 27),
        BorderSizePixel = 0,
        ZIndex = 505,
        Visible = false,
        Parent = dropdownOverlayContainer,
    })
    addCorner(activeOverlayMenu, 6)
    addStroke(activeOverlayMenu, Library.Theme.Accent, 1, 0.3)

    local activeOverlayScroll = create("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Library.Theme.Accent,
        CanvasSize = UDim2.fromOffset(0, 0),
        ZIndex = 506,
        Parent = activeOverlayMenu,
    })
    create("UIPadding", {
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 4),
        PaddingLeft = UDim.new(0, 4),
        PaddingRight = UDim.new(0, 4),
        Parent = activeOverlayScroll,
    })
    create("UIListLayout", {
        Padding = UDim.new(0, 2),
        Parent = activeOverlayScroll,
    })

    local function closeActiveDropdown()
        dropdownOverlayContainer.Visible = false
        activeOverlayMenu.Visible = false
        if Library.ActiveDropdown then
            if typeof(Library.ActiveDropdown.OnClose) == "function" then
                Library.ActiveDropdown.OnClose()
            end
            Library.ActiveDropdown = nil
        end
    end
    dropdownClickAway.MouseButton1Click:Connect(closeActiveDropdown)

    -- Shadow frame
    local shadow = create("Frame", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 3),
        Size = UDim2.fromOffset(BASE_WIDTH + 6, BASE_HEIGHT + 6),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.88,
        BorderSizePixel = 0,
        ZIndex = 1,
        Parent = gui,
    })
    addCorner(shadow, 17)

    -- Main Container
    local main = create("CanvasGroup", {
        Name = "Main",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(BASE_WIDTH, BASE_HEIGHT),
        BackgroundColor3 = Library.Theme.Window,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Active = true,
        GroupTransparency = 0,
        ZIndex = 2,
        Parent = gui,
    })
    addCorner(main, 14)
    addStroke(main, Library.Theme.Line, 1, 0.2)

    local mainScale = create("UIScale", {Scale = 1, Parent = main})
    local shadowScale = create("UIScale", {Scale = 1, Parent = shadow})
    local targetScale = 1

    local function updateResponsiveScale()
        local camera = Workspace.CurrentCamera
        if not camera then return end
        local viewport = camera.ViewportSize
        targetScale = math.clamp(math.min(viewport.X / 1120, viewport.Y / 660), 0.48, 1)
        mainScale.Scale = targetScale
        shadowScale.Scale = targetScale
    end

    updateResponsiveScale()
    if Workspace.CurrentCamera then
        Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateResponsiveScale)
    end
    Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        updateResponsiveScale()
        if Workspace.CurrentCamera then
            Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateResponsiveScale)
        end
    end)

    -- =====================================================================
    -- HOME PAGE
    -- =====================================================================
    local homePage = create("Frame", {
        Name = "HomePage",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = main,
    })

    local header = create("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
        BackgroundColor3 = Library.Theme.Header,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Active = true,
        ZIndex = 4,
        Parent = homePage,
    })
    addCorner(header, 14)

    create("Frame", {
        Position = UDim2.new(0, 0, 1, -14),
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundColor3 = Library.Theme.Header,
        BorderSizePixel = 0,
        ZIndex = 4,
        Parent = header,
    })

    create("UIGradient", {
        Rotation = 14,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 14, 14)),
            ColorSequenceKeypoint.new(0.48, Color3.fromRGB(24, 30, 29)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 14, 14)),
        }),
        Parent = header,
    })

    -- Background decorative shards
    for _, shard in ipairs({
        {UDim2.fromOffset(180, 64), UDim2.fromOffset(-42, 5), -20, 0.58},
        {UDim2.fromOffset(130, 45), UDim2.fromOffset(30, 135), 13, 0.68},
        {UDim2.fromOffset(180, 64), UDim2.fromOffset(560, 4), 22, 0.58},
        {UDim2.fromOffset(145, 48), UDim2.fromOffset(540, 138), -13, 0.68},
    }) do
        create("Frame", {
            Size = shard[1],
            Position = shard[2],
            Rotation = shard[3],
            BackgroundColor3 = Color3.fromRGB(62, 73, 71),
            BackgroundTransparency = shard[4],
            BorderSizePixel = 0,
            ZIndex = 4,
            Parent = header,
        })
    end

    -- Single Left Logo (Right logo is deleted)
    local logoHolder = create("Frame", {
        Name = "LogoLeft",
        Position = UDim2.fromOffset(36, 28),
        Size = UDim2.fromOffset(116, 116),
        BackgroundColor3 = Library.Theme.Surface2,
        BackgroundTransparency = (LogoAsset ~= "") and 1 or 0.18,
        BorderSizePixel = 0,
        ZIndex = 5,
        Parent = header,
    })
    addCorner(logoHolder, 12)

    local logoImage = create("ImageLabel", {
        Name = "Image",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Image = LogoAsset or "",
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 6,
        Parent = logoHolder,
    })
    if not LogoAsset or LogoAsset == "" then
        addStroke(logoHolder, Library.Theme.Line, 1, 0.15)
        makeText(logoHolder, {
            Size = UDim2.fromScale(1, 1),
            Text = "LOGO",
            TextColor3 = Library.Theme.Muted2,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            ZIndex = 7,
        })
    end

    -- Header Center Info
    makeText(header, {
        Position = UDim2.fromOffset(170, 16),
        Size = UDim2.new(1, -190, 0, 15),
        Text = "[/] " .. string.upper(Title) .. " // ON",
        TextColor3 = Color3.fromRGB(198, 210, 207),
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 6,
    })
    makeText(header, {
        Position = UDim2.fromOffset(170, 38),
        Size = UDim2.new(1, -190, 0, 24),
        Text = "WELCOME TO",
        Font = Enum.Font.GothamBlack,
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 6,
    })
    makeText(header, {
        Position = UDim2.fromOffset(170, 62),
        Size = UDim2.new(1, -190, 0, 28),
        Text = Title,
        TextColor3 = Library.Theme.Accent,
        Font = Enum.Font.GothamBlack,
        TextSize = 24,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 6,
    })
    makeText(header, {
        Position = UDim2.fromOffset(170, 92),
        Size = UDim2.new(1, -190, 0, 16),
        Text = Subtitle,
        TextColor3 = Library.Theme.Muted,
        Font = Enum.Font.GothamMedium,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 6,
    })

    local discordButton = create("TextButton", {
        Name = "DiscordButton",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 75, 0, 118),
        Size = UDim2.fromOffset(142, 34),
        BackgroundColor3 = Library.Theme.Accent,
        AutoButtonColor = false,
        Text = "Join Discord",
        TextColor3 = Library.Theme.AccentInk,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        ZIndex = 7,
        Parent = header,
    })
    addCorner(discordButton, 6)
    create("UIGradient", {
        Color = ColorSequence.new(Library.Theme.Accent, Library.Theme.Accent2),
        Parent = discordButton,
    })

    discordButton.MouseEnter:Connect(function()
        tween(discordButton, 0.14, {Size = UDim2.fromOffset(148, 36)})
    end)
    discordButton.MouseLeave:Connect(function()
        tween(discordButton, 0.14, {Size = UDim2.fromOffset(142, 34)})
    end)
    discordButton.Activated:Connect(function()
        if setclipboard then
            setclipboard(DiscordLink)
            Library:Notify({Title = "Discord", Content = "Copied invite link to clipboard!", Duration = 3})
        else
            Library:Notify({Title = "Discord", Content = DiscordLink, Duration = 4})
        end
    end)

    create("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Library.Theme.Line,
        BorderSizePixel = 0,
        ZIndex = 8,
        Parent = header,
    })

    -- Tab Cards Scroll Grid
    local homeScroll = create("ScrollingFrame", {
        Name = "TabCards",
        Position = UDim2.fromOffset(0, HEADER_HEIGHT),
        Size = UDim2.new(1, 0, 1, -HEADER_HEIGHT),
        BackgroundColor3 = Library.Theme.Window,
        BorderSizePixel = 0,
        CanvasSize = UDim2.fromOffset(0, 0),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ElasticBehavior = Enum.ElasticBehavior.Never,
        ClipsDescendants = true,
        ZIndex = 4,
        Parent = homePage,
    })
    addCorner(homeScroll, 14)

    create("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 18),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        Parent = homeScroll,
    })

    local homeGrid = create("UIGridLayout", {
        CellSize = UDim2.new(0.5, -10, 0, 78),
        CellPadding = UDim2.fromOffset(10, 8),
        FillDirection = Enum.FillDirection.Horizontal,
        FillDirectionMaxCells = 2,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = homeScroll,
    })

    local function updateHomeCanvas()
        homeScroll.CanvasSize = UDim2.fromOffset(0, homeGrid.AbsoluteContentSize.Y + 28)
    end
    homeGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateHomeCanvas)

    -- =====================================================================
    -- DETAIL PAGE
    -- =====================================================================
    local detailPage = create("Frame", {
        Name = "DetailPage",
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Library.Theme.Window,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = false,
        ZIndex = 10,
        Parent = main,
    })
    addCorner(detailPage, 14)

    local detailTopbar = create("Frame", {
        Size = UDim2.new(1, 0, 0, 64),
        BackgroundColor3 = Library.Theme.Header,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 11,
        Parent = detailPage,
    })
    addCorner(detailTopbar, 14)

    create("Frame", {
        Position = UDim2.new(0, 0, 1, -14),
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundColor3 = Library.Theme.Header,
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = detailTopbar,
    })

    local backButton = create("TextButton", {
        Name = "Back",
        Position = UDim2.fromOffset(14, 15),
        Size = UDim2.fromOffset(34, 34),
        BackgroundColor3 = Library.Theme.Surface2,
        Text = "‹",
        TextColor3 = Library.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 28,
        AutoButtonColor = false,
        ZIndex = 12,
        Parent = detailTopbar,
    })
    addCorner(backButton, 6)
    addStroke(backButton, Library.Theme.Line, 1, 0.05)

    local detailTitle = makeText(detailTopbar, {
        Position = UDim2.fromOffset(58, 12),
        Size = UDim2.new(1, -180, 0, 24),
        Text = "Tab",
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        TextSize = 17,
        ZIndex = 12,
    })
    local detailSubtitle = makeText(detailTopbar, {
        Position = UDim2.fromOffset(58, 34),
        Size = UDim2.new(1, -180, 0, 15),
        Text = "Automation",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Library.Theme.Muted,
        Font = Enum.Font.GothamMedium,
        TextSize = 10,
        ZIndex = 12,
    })

    local previousButton = create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -54, 0.5, 0),
        Size = UDim2.fromOffset(35, 35),
        BackgroundTransparency = 1,
        Text = "‹",
        TextColor3 = Library.Theme.Muted,
        Font = Enum.Font.GothamBold,
        TextSize = 30,
        AutoButtonColor = false,
        ZIndex = 12,
        Parent = detailTopbar,
    })
    local nextButton = create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -13, 0.5, 0),
        Size = UDim2.fromOffset(35, 35),
        BackgroundTransparency = 1,
        Text = "›",
        TextColor3 = Library.Theme.Muted,
        Font = Enum.Font.GothamBold,
        TextSize = 30,
        AutoButtonColor = false,
        ZIndex = 12,
        Parent = detailTopbar,
    })

    create("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Library.Theme.Line,
        BorderSizePixel = 0,
        ZIndex = 13,
        Parent = detailTopbar,
    })

    local detailContent = create("ScrollingFrame", {
        Name = "Content",
        Position = UDim2.fromOffset(0, 64),
        Size = UDim2.new(1, 0, 1, -64),
        BackgroundColor3 = Library.Theme.Window,
        BorderSizePixel = 0,
        CanvasSize = UDim2.fromOffset(0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Library.Theme.Accent2,
        ScrollBarImageTransparency = 0.35,
        ElasticBehavior = Enum.ElasticBehavior.Never,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ClipsDescendants = true,
        ZIndex = 11,
        Parent = detailPage,
    })
    addCorner(detailContent, 14)

    create("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 16),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        Parent = detailContent,
    })
    local detailLayout = create("UIListLayout", {
        Padding = UDim.new(0, 0),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = detailContent,
    })

    local function refreshDetailCanvas()
        detailContent.CanvasSize = UDim2.fromOffset(0, detailLayout.AbsoluteContentSize.Y + 28)
    end
    detailLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshDetailCanvas)

    -- Tab Management state
    local tabList = {}
    local currentTabIndex = 1
    local transitioning = false

    local function openTab(index, immediate)
        if transitioning or #tabList == 0 then return end
        currentTabIndex = ((index - 1) % #tabList) + 1
        local activeTab = tabList[currentTabIndex]

        closeActiveDropdown()

        for idx, t in ipairs(tabList) do
            if t.Container then
                t.Container.Visible = (idx == currentTabIndex)
            end
        end

        detailTitle.Text = activeTab.Name
        detailSubtitle.Text = activeTab.Subtitle or "Automation"
        detailContent.CanvasPosition = Vector2.new(0, 0)
        refreshDetailCanvas()

        if detailPage.Visible and not immediate then
            detailPage.Position = UDim2.fromScale(0, 0)
            return
        end

        transitioning = true
        detailPage.Visible = true
        detailPage.Position = UDim2.fromScale(1, 0)
        homePage.Position = UDim2.fromScale(0, 0)

        tween(homePage, 0.22, {Position = UDim2.fromScale(-0.12, 0)}, Enum.EasingStyle.Quint)
        tween(detailPage, 0.26, {Position = UDim2.fromScale(0, 0)}, Enum.EasingStyle.Quint)

        task.delay(0.27, function()
            homePage.Visible = false
            transitioning = false
        end)
    end

    local function returnHome()
        if transitioning or not detailPage.Visible then return end
        closeActiveDropdown()
        transitioning = true
        homePage.Visible = true
        homePage.Position = UDim2.fromScale(-0.12, 0)

        tween(detailPage, 0.23, {Position = UDim2.fromScale(1, 0)}, Enum.EasingStyle.Quint)
        tween(homePage, 0.26, {Position = UDim2.fromScale(0, 0)}, Enum.EasingStyle.Quint)

        task.delay(0.27, function()
            detailPage.Visible = false
            transitioning = false
        end)
    end

    backButton.Activated:Connect(returnHome)
    previousButton.Activated:Connect(function() openTab(currentTabIndex - 1, false) end)
    nextButton.Activated:Connect(function() openTab(currentTabIndex + 1, false) end)

    previousButton.MouseEnter:Connect(function() tween(previousButton, 0.12, {TextColor3 = Library.Theme.Accent}) end)
    previousButton.MouseLeave:Connect(function() tween(previousButton, 0.12, {TextColor3 = Library.Theme.Muted}) end)
    nextButton.MouseEnter:Connect(function() tween(nextButton, 0.12, {TextColor3 = Library.Theme.Accent}) end)
    nextButton.MouseLeave:Connect(function() tween(nextButton, 0.12, {TextColor3 = Library.Theme.Muted}) end)

    -- Window Open/Close & Controls
    local isOpen = true
    local function setWindowOpen(value)
        isOpen = value == true
        closeActiveDropdown()
        if isOpen then
            main.Visible = true
            shadow.Visible = true
            main.GroupTransparency = 1
            mainScale.Scale = targetScale * 0.92
            shadowScale.Scale = targetScale * 0.92
            tween(main, 0.22, {GroupTransparency = 0})
            tween(mainScale, 0.3, {Scale = targetScale}, Enum.EasingStyle.Back)
            tween(shadowScale, 0.3, {Scale = targetScale}, Enum.EasingStyle.Back)
            tween(shadow, 0.2, {BackgroundTransparency = 0.88})
        else
            tween(main, 0.17, {GroupTransparency = 1})
            tween(mainScale, 0.2, {Scale = targetScale * 0.94})
            tween(shadowScale, 0.2, {Scale = targetScale * 0.94})
            tween(shadow, 0.17, {BackgroundTransparency = 1})
            task.delay(0.21, function()
                if not isOpen then
                    main.Visible = false
                    shadow.Visible = false
                end
            end)
        end
    end

    -- =====================================================================
    -- FOOTER BUTTONS (Green = Reset/Maximize, Yellow = Minimize, Red = Close)
    -- =====================================================================
    local footerDots = create("Frame", {
        Name = "FooterControlButtons",
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -14, 1, -10),
        Size = UDim2.fromOffset(56, 16),
        BackgroundTransparency = 1,
        ZIndex = 30,
        Parent = main,
    })

    -- Green Dot: Reset Position to Screen Center
    local greenDot = create("TextButton", {
        Name = "BtnMaximizeReset",
        Position = UDim2.fromOffset(0, 2),
        Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Library.Theme.Success,
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex = 32,
        Parent = footerDots,
    })
    addCorner(greenDot, 12)
    greenDot.MouseEnter:Connect(function()
        tween(greenDot, 0.12, {Size = UDim2.fromOffset(14, 14)})
    end)
    greenDot.MouseLeave:Connect(function()
        tween(greenDot, 0.12, {Size = UDim2.fromOffset(12, 12)})
    end)
    greenDot.MouseButton1Click:Connect(function()
        main.Position = UDim2.fromScale(0.5, 0.5)
        shadow.Position = UDim2.new(0.5, 0, 0.5, 3)
        Library:Notify({
            Title = "UI Control",
            Content = "Đã căn giữa cửa sổ UI!",
            Duration = 2,
        })
    end)

    -- Yellow Dot: Minimize to Dynamic Island
    local yellowDot = create("TextButton", {
        Name = "BtnMinimize",
        Position = UDim2.fromOffset(18, 2),
        Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Library.Theme.Warning,
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex = 32,
        Parent = footerDots,
    })
    addCorner(yellowDot, 12)
    yellowDot.MouseEnter:Connect(function()
        tween(yellowDot, 0.12, {Size = UDim2.fromOffset(14, 14)})
    end)
    yellowDot.MouseLeave:Connect(function()
        tween(yellowDot, 0.12, {Size = UDim2.fromOffset(12, 12)})
    end)
    yellowDot.MouseButton1Click:Connect(function()
        setWindowOpen(false)
        Library:Notify({
            Title = "UI Control",
            Content = "Đã thu nhỏ UI lên Dynamic Island!",
            Duration = 2,
        })
    end)

    -- Red Dot: Close / Toggle Hide UI
    local redDot = create("TextButton", {
        Name = "BtnClose",
        Position = UDim2.fromOffset(36, 2),
        Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Library.Theme.Danger,
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex = 32,
        Parent = footerDots,
    })
    addCorner(redDot, 12)
    redDot.MouseEnter:Connect(function()
        tween(redDot, 0.12, {Size = UDim2.fromOffset(14, 14)})
    end)
    redDot.MouseLeave:Connect(function()
        tween(redDot, 0.12, {Size = UDim2.fromOffset(12, 12)})
    end)
    redDot.MouseButton1Click:Connect(function()
        setWindowOpen(false)
    end)

    -- =====================================================================
    -- DYNAMIC ISLAND MENU BUTTON
    -- =====================================================================
    local dynamicIsland = create("TextButton", {
        Name = "DynamicIsland",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 14),
        Size = UDim2.fromOffset(200, 46),
        BackgroundColor3 = Color3.fromRGB(5, 8, 8),
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ClipsDescendants = true,
        ZIndex = 100,
        Parent = gui,
    })
    addCorner(dynamicIsland, 24)
    local islandStroke = addStroke(dynamicIsland, Library.Theme.Accent2, 1, 0.52)
    create("UIGradient", {
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 18, 17)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(3, 5, 5)),
        }),
        Parent = dynamicIsland,
    })

    local islandIcon = create("Frame", {
        Position = UDim2.fromOffset(8, 7),
        Size = UDim2.fromOffset(32, 32),
        BackgroundColor3 = Color3.fromRGB(16, 37, 33),
        BorderSizePixel = 0,
        ZIndex = 102,
        Parent = dynamicIsland,
    })
    addCorner(islandIcon, 16)
    addStroke(islandIcon, Library.Theme.Accent2, 1, 0.28)
    makeText(islandIcon, {
        Size = UDim2.fromScale(1, 1),
        Text = string.sub(Title, 1, 2),
        TextColor3 = Library.Theme.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        ZIndex = 103,
    })

    local islandTitle = makeText(dynamicIsland, {
        Position = UDim2.fromOffset(48, 7),
        Size = UDim2.fromOffset(110, 16),
        Text = string.upper(Title),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Library.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        ZIndex = 102,
    })
    local islandSubtitle = makeText(dynamicIsland, {
        Position = UDim2.fromOffset(48, 23),
        Size = UDim2.fromOffset(110, 15),
        Text = "Menu đang mở",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Library.Theme.Muted,
        Font = Enum.Font.GothamMedium,
        TextSize = 8,
        ZIndex = 102,
    })

    local islandStatusRing = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundColor3 = Color3.fromRGB(17, 25, 23),
        BorderSizePixel = 0,
        ZIndex = 102,
        Parent = dynamicIsland,
    })
    addCorner(islandStatusRing, 12)
    addStroke(islandStatusRing, Library.Theme.Line, 1, 0.3)

    local islandStatusDot = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(8, 8),
        BackgroundColor3 = Library.Theme.Success,
        BorderSizePixel = 0,
        ZIndex = 103,
        Parent = islandStatusRing,
    })
    addCorner(islandStatusDot, 8)

    local islandHovered = false
    local function renderDynamicIsland(opened, pressed)
        islandSubtitle.Text = opened and "Menu đang mở" or "Nhấn để mở menu"
        tween(islandStatusDot, 0.18, {
            BackgroundColor3 = opened and Library.Theme.Success or Library.Theme.Muted2,
            BackgroundTransparency = opened and 0 or 0.2,
        })
        tween(islandIcon, 0.18, {
            BackgroundColor3 = opened and Color3.fromRGB(16, 45, 38) or Color3.fromRGB(20, 25, 24),
        })
        tween(islandStroke, 0.18, {
            Color = opened and Library.Theme.Accent2 or Library.Theme.Line,
            Transparency = opened and 0.52 or 0.34,
        })

        local targetSize
        if pressed then
            targetSize = UDim2.fromOffset(186, 40)
        elseif islandHovered then
            targetSize = UDim2.fromOffset(218, 52)
        else
            targetSize = UDim2.fromOffset(200, 46)
        end

        tween(dynamicIsland, pressed and 0.07 or 0.2, {
            Size = targetSize,
            BackgroundColor3 = islandHovered and Color3.fromRGB(9, 14, 13) or Color3.fromRGB(5, 8, 8),
        }, pressed and Enum.EasingStyle.Quad or Enum.EasingStyle.Quint)
    end

    dynamicIsland.Activated:Connect(function()
        renderDynamicIsland(isOpen, true)
        task.delay(0.075, function()
            setWindowOpen(not isOpen)
            renderDynamicIsland(isOpen, false)
        end)
    end)
    dynamicIsland.MouseEnter:Connect(function()
        islandHovered = true
        renderDynamicIsland(isOpen, false)
    end)
    dynamicIsland.MouseLeave:Connect(function()
        islandHovered = false
        renderDynamicIsland(isOpen, false)
    end)

    renderDynamicIsland(isOpen, false)

    -- Draggable
    local dragging = false
    local dragInput, dragStart, dragOrigin
    local function beginDrag(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        dragging = true
        dragStart = input.Position
        dragOrigin = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    header.InputBegan:Connect(beginDrag)
    detailTopbar.InputBegan:Connect(beginDrag)

    local function rememberDragInput(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end
    header.InputChanged:Connect(rememberDragInput)
    detailTopbar.InputChanged:Connect(rememberDragInput)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging or input ~= dragInput then return end
        closeActiveDropdown()
        local delta = input.Position - dragStart
        local scale = math.max(mainScale.Scale, 0.01)
        local target = UDim2.new(
            dragOrigin.X.Scale,
            dragOrigin.X.Offset + delta.X / scale,
            dragOrigin.Y.Scale,
            dragOrigin.Y.Offset + delta.Y / scale
        )
        main.Position = target
        shadow.Position = UDim2.new(target.X.Scale, target.X.Offset, target.Y.Scale, target.Y.Offset + 3)
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Keybind then
            setWindowOpen(not isOpen)
            renderDynamicIsland(isOpen, false)
        elseif input.KeyCode == Enum.KeyCode.Escape and detailPage.Visible then
            returnHome()
        end
    end)

    -- Intro animation
    main.GroupTransparency = 1
    shadow.BackgroundTransparency = 1
    mainScale.Scale = targetScale * 0.92
    shadowScale.Scale = targetScale * 0.92
    task.defer(function()
        tween(main, 0.24, {GroupTransparency = 0})
        tween(mainScale, 0.34, {Scale = targetScale}, Enum.EasingStyle.Back)
        tween(shadowScale, 0.34, {Scale = targetScale}, Enum.EasingStyle.Back)
        tween(shadow, 0.22, {BackgroundTransparency = 0.88})
    end)

    -- =====================================================================
    -- WINDOW OBJECT & METHODS
    -- =====================================================================
    local WindowObj = {
        Main = main,
        Gui = gui,
        Tabs = tabList,
        SetOpen = setWindowOpen,
    }

    function WindowObj:AddTab(tabConfig)
        local tabName = (typeof(tabConfig) == "table" and (tabConfig.Title or tabConfig.Name)) or tostring(tabConfig or "Tab")
        local tabIcon = (typeof(tabConfig) == "table" and (tabConfig.Icon or tabConfig.Image)) or ""
        local tabSubtitle = (typeof(tabConfig) == "table" and (tabConfig.Subtitle or tabConfig.Description)) or "Automation"
        local tabShort = string.upper(string.sub(tabName, 1, 2))

        local resolvedIconAsset = resolveIcon(tabIcon)
        local tabIndex = #tabList + 1

        -- Tab Card on Home Page
        local card = create("TextButton", {
            Name = "TabCard_" .. tabName,
            BackgroundColor3 = Library.Theme.Surface,
            BackgroundTransparency = 0.12,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = tabIndex,
            ZIndex = 5,
            Parent = homeScroll,
        })
        addCorner(card, 7)
        addStroke(card, Library.Theme.Line, 1, 0.28)

        local iconHolder = create("Frame", {
            Name = "IconHolder",
            Position = UDim2.fromOffset(14, 12),
            Size = UDim2.fromOffset(54, 54),
            BackgroundColor3 = Library.Theme.Surface2,
            BackgroundTransparency = (resolvedIconAsset ~= "") and 1 or 0.18,
            BorderSizePixel = 0,
            ZIndex = 6,
            Parent = card,
        })
        addCorner(iconHolder, 8)

        local iconImage = create("ImageLabel", {
            Name = "Image",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Image = resolvedIconAsset,
            ImageColor3 = Library.Theme.Accent,
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = 7,
            Parent = iconHolder,
        })

        local placeholder = makeText(iconHolder, {
            Name = "Placeholder",
            Size = UDim2.fromScale(1, 1),
            Text = tabShort,
            TextColor3 = Library.Theme.Muted2,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            Visible = (resolvedIconAsset == ""),
            ZIndex = 8,
        })

        if resolvedIconAsset == "" and tabIcon ~= "" then
            task.delay(1, function()
                local delayed = resolveIcon(tabIcon)
                if delayed ~= "" and iconImage then
                    iconImage.Image = delayed
                    placeholder.Visible = false
                end
            end)
        end

        local cardTitle = makeText(card, {
            Position = UDim2.fromOffset(80, 17),
            Size = UDim2.new(1, -100, 0, 24),
            Text = tabName,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.GothamBold,
            TextSize = 16,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 7,
        })
        local cardSub = makeText(card, {
            Position = UDim2.fromOffset(80, 41),
            Size = UDim2.new(1, -100, 0, 17),
            Text = tabSubtitle,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Library.Theme.Muted,
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            ZIndex = 7,
        })

        card.MouseEnter:Connect(function()
            tween(card, 0.14, {BackgroundColor3 = Library.Theme.Hover, BackgroundTransparency = 0})
            tween(cardTitle, 0.14, {TextColor3 = Library.Theme.Accent})
            tween(iconHolder, 0.14, {BackgroundColor3 = Color3.fromRGB(25, 48, 43)})
        end)
        card.MouseLeave:Connect(function()
            tween(card, 0.14, {BackgroundColor3 = Library.Theme.Surface, BackgroundTransparency = 0.12})
            tween(cardTitle, 0.14, {TextColor3 = Library.Theme.Text})
            tween(iconHolder, 0.14, {BackgroundColor3 = Library.Theme.Surface2})
        end)
        card.Activated:Connect(function()
            openTab(tabIndex, false)
        end)

        updateHomeCanvas()

        -- Detail container for this tab's sections
        local tabContainer = create("Frame", {
            Name = "TabContainer_" .. tabName,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = tabIndex,
            Visible = false,
            ZIndex = 12,
            Parent = detailContent,
        })
        local tabLayout = create("UIListLayout", {
            Padding = UDim.new(0, 0),
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = tabContainer,
        })
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshDetailCanvas)

        local TabObj = {
            Name = tabName,
            Subtitle = tabSubtitle,
            Icon = tabIcon,
            Card = card,
            Container = tabContainer,
            Order = 0,
        }
        table.insert(tabList, TabObj)

        -- =================================================================
        -- SECTION BUILDER
        -- =================================================================
        function TabObj:AddSection(secConfig)
            local secTitle = (typeof(secConfig) == "table" and (secConfig.Title or secConfig.Name)) or tostring(secConfig or "Section")

            TabObj.Order = TabObj.Order + 1
            local sectionHeader = create("Frame", {
                Name = "Section_" .. secTitle,
                Size = UDim2.new(1, -20, 0, 41),
                BackgroundColor3 = Library.Theme.Accent,
                BorderSizePixel = 0,
                LayoutOrder = TabObj.Order,
                ZIndex = 12,
                Parent = tabContainer,
            })
            addCorner(sectionHeader, 5)
            create("UIGradient", {
                Color = ColorSequence.new(Color3.fromRGB(87, 246, 214), Library.Theme.Accent2),
                Parent = sectionHeader,
            })

            makeText(sectionHeader, {
                Position = UDim2.fromOffset(15, 0),
                Size = UDim2.new(0.55, 0, 1, 0),
                Text = secTitle,
                TextColor3 = Library.Theme.AccentInk,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                ZIndex = 14,
            })

            -- Dot matrix pattern
            for row = 0, 2 do
                for column = 0, 17 do
                    local fade = column / 17
                    local dot = create("Frame", {
                        AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, -10 - column * 10, 0, 7 + row * 10),
                        Size = UDim2.fromOffset(3, 3),
                        BackgroundColor3 = Library.Theme.AccentInk,
                        BackgroundTransparency = 0.9 - fade * 0.46,
                        BorderSizePixel = 0,
                        ZIndex = 13,
                        Parent = sectionHeader,
                    })
                    addCorner(dot, 3)
                end
            end

            local SectionObj = {}

            local function createRow(itemTitle, itemDesc, itemStatus)
                TabObj.Order = TabObj.Order + 1
                local row = create("Frame", {
                    Name = "Row_" .. (itemTitle or "Item"),
                    Size = UDim2.new(1, -20, 0, 61),
                    BackgroundColor3 = (TabObj.Order % 2 == 0) and Library.Theme.Surface or Color3.fromRGB(13, 18, 17),
                    BorderSizePixel = 0,
                    LayoutOrder = TabObj.Order,
                    ZIndex = 12,
                    Parent = tabContainer,
                })

                makeText(row, {
                    Position = UDim2.fromOffset(14, 9),
                    Size = UDim2.new(1, -220, 0, 22),
                    Text = itemTitle or "",
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 13,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 13,
                })
                makeText(row, {
                    Position = UDim2.fromOffset(14, 31),
                    Size = UDim2.new(1, -220, 0, 16),
                    Text = itemDesc or "",
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextColor3 = Library.Theme.Muted2,
                    Font = Enum.Font.Gotham,
                    TextSize = 9,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 13,
                })

                if itemStatus then
                    makeText(row, {
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -79, 0.5, 0),
                        Size = UDim2.fromOffset(145, 20),
                        Text = itemStatus,
                        TextColor3 = Library.Theme.Muted,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Font = Enum.Font.GothamMedium,
                        TextSize = 9,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        ZIndex = 14,
                    })
                end

                create("Frame", {
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Library.Theme.Line,
                    BackgroundTransparency = 0.35,
                    BorderSizePixel = 0,
                    ZIndex = 13,
                    Parent = row,
                })

                return row
            end

            -- ADD TOGGLE
            function SectionObj:AddToggle(opts)
                opts = opts or {}
                local title = opts.Title or opts.Name or "Toggle"
                local desc = opts.Description or opts.Desc or ""
                local flag = opts.Flag or title
                local defaultVal = opts.Default == true
                local callback = opts.Callback

                Library.Flags[flag] = defaultVal
                local row = createRow(title, desc, opts.Status)

                local toggle = create("TextButton", {
                    Name = "Toggle",
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -16, 0.5, 0),
                    Size = UDim2.fromOffset(48, 25),
                    BackgroundColor3 = defaultVal and Library.Theme.Accent2 or Color3.fromRGB(31, 39, 38),
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 15,
                    Parent = row,
                })
                addCorner(toggle, 13)
                addStroke(toggle, defaultVal and Library.Theme.Accent or Library.Theme.Line, 1, 0.2)

                local knob = create("Frame", {
                    Position = defaultVal and UDim2.fromOffset(26, 3) or UDim2.fromOffset(3, 3),
                    Size = UDim2.fromOffset(19, 19),
                    BackgroundColor3 = defaultVal and Library.Theme.AccentInk or Library.Theme.Muted,
                    BorderSizePixel = 0,
                    ZIndex = 16,
                    Parent = toggle,
                })
                addCorner(knob, 10)

                local enabled = defaultVal
                local function setVal(newVal)
                    enabled = (newVal == true)
                    Library.Flags[flag] = enabled
                    tween(toggle, 0.16, {
                        BackgroundColor3 = enabled and Library.Theme.Accent2 or Color3.fromRGB(31, 39, 38),
                    })
                    tween(knob, 0.18, {
                        Position = enabled and UDim2.fromOffset(26, 3) or UDim2.fromOffset(3, 3),
                        BackgroundColor3 = enabled and Library.Theme.AccentInk or Library.Theme.Muted,
                    }, Enum.EasingStyle.Quint)
                    if typeof(callback) == "function" then
                        task.spawn(callback, enabled)
                    end
                end

                toggle.Activated:Connect(function()
                    setVal(not enabled)
                end)

                local ToggleObj = {
                    Set = setVal,
                    Value = function() return enabled end,
                }
                return ToggleObj
            end

            -- ADD BUTTON
            function SectionObj:AddButton(opts)
                opts = opts or {}
                local title = opts.Title or opts.Name or "Button"
                local desc = opts.Description or opts.Desc or ""
                local btnText = opts.ButtonText or opts.Text or "Click"
                local callback = opts.Callback

                local row = createRow(title, desc, opts.Status)

                local button = create("TextButton", {
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -16, 0.5, 0),
                    Size = UDim2.fromOffset(96, 28),
                    BackgroundColor3 = Library.Theme.Accent,
                    Text = btnText,
                    TextColor3 = Library.Theme.AccentInk,
                    Font = Enum.Font.GothamBold,
                    TextSize = 11,
                    AutoButtonColor = false,
                    ZIndex = 15,
                    Parent = row,
                })
                addCorner(button, 15)

                button.MouseEnter:Connect(function()
                    tween(button, 0.12, {BackgroundColor3 = Color3.fromRGB(102, 250, 220)})
                end)
                button.MouseLeave:Connect(function()
                    tween(button, 0.12, {BackgroundColor3 = Library.Theme.Accent})
                end)
                button.Activated:Connect(function()
                    tween(button, 0.07, {Size = UDim2.fromOffset(90, 25)})
                    task.delay(0.08, function()
                        tween(button, 0.12, {Size = UDim2.fromOffset(96, 28)}, Enum.EasingStyle.Back)
                    end)
                    if typeof(callback) == "function" then
                        task.spawn(callback)
                    end
                end)

                return button
            end

            -- ADD DROPDOWN (Fixed with Global Overlay & Lucide Chevron Arrow)
            function SectionObj:AddDropdown(opts)
                opts = opts or {}
                local title = opts.Title or opts.Name or "Dropdown"
                local desc = opts.Description or opts.Desc or ""
                local flag = opts.Flag or title
                local options = opts.Options or {"Option"}
                local defaultVal = opts.Default or options[1]
                local callback = opts.Callback

                local currentIndex = table.find(options, defaultVal) or 1
                local currentOption = options[currentIndex]
                Library.Flags[flag] = currentOption

                local row = createRow(title, desc, opts.Status)

                local dropdown = create("TextButton", {
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -16, 0.5, 0),
                    Size = UDim2.fromOffset(160, 30),
                    BackgroundColor3 = Library.Theme.Surface2,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 15,
                    Parent = row,
                })
                addCorner(dropdown, 6)
                addStroke(dropdown, Library.Theme.Line, 1, 0.1)

                local valueLabel = makeText(dropdown, {
                    Position = UDim2.fromOffset(11, 0),
                    Size = UDim2.new(1, -36, 1, 0),
                    Text = tostring(currentOption),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 11,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 16,
                })

                -- Lucide Chevron Down Icon (Proper image vector, never square box)
                local arrowIcon = create("ImageLabel", {
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -8, 0.5, 0),
                    Size = UDim2.fromOffset(14, 14),
                    BackgroundTransparency = 1,
                    Image = resolveIcon("chevron-down"),
                    ImageColor3 = Library.Theme.Accent,
                    ScaleType = Enum.ScaleType.Fit,
                    ZIndex = 16,
                    Parent = dropdown,
                })

                local function selectOpt(opt)
                    currentOption = opt
                    currentIndex = table.find(options, opt) or 1
                    valueLabel.Text = tostring(currentOption)
                    Library.Flags[flag] = currentOption
                    closeActiveDropdown()
                    if typeof(callback) == "function" then
                        task.spawn(callback, currentOption)
                    end
                end

                local function openThisDropdown()
                    if Library.ActiveDropdown then
                        closeActiveDropdown()
                    end

                    -- Clear previous options in overlay scroll
                    for _, c in ipairs(activeOverlayScroll:GetChildren()) do
                        if c:IsA("TextButton") then c:Destroy() end
                    end

                    for _, opt in ipairs(options) do
                        local isSelected = (opt == currentOption)
                        local optBtn = create("TextButton", {
                            Size = UDim2.new(1, 0, 0, 26),
                            BackgroundColor3 = isSelected and Library.Theme.Hover or Library.Theme.Surface2,
                            Text = "   " .. tostring(opt),
                            TextColor3 = isSelected and Library.Theme.Accent or Library.Theme.Text,
                            Font = isSelected and Enum.Font.GothamBold or Enum.Font.GothamMedium,
                            TextSize = 11,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            AutoButtonColor = false,
                            ZIndex = 510,
                            Parent = activeOverlayScroll,
                        })
                        addCorner(optBtn, 4)
                        if isSelected then
                            addStroke(optBtn, Library.Theme.Accent, 1, 0.4)
                        end
                        optBtn.MouseButton1Click:Connect(function()
                            selectOpt(opt)
                        end)
                        optBtn.MouseEnter:Connect(function()
                            tween(optBtn, 0.1, {BackgroundColor3 = Library.Theme.Hover, TextColor3 = Library.Theme.Accent})
                        end)
                        optBtn.MouseLeave:Connect(function()
                            if opt ~= currentOption then
                                tween(optBtn, 0.1, {BackgroundColor3 = Library.Theme.Surface2, TextColor3 = Library.Theme.Text})
                            end
                        end)
                    end

                    local absPos = dropdown.AbsolutePosition
                    local absSize = dropdown.AbsoluteSize
                    local menuHeight = math.min(#options * 28 + 10, 140)

                    activeOverlayMenu.Size = UDim2.fromOffset(absSize.X, menuHeight)
                    activeOverlayMenu.Position = UDim2.fromOffset(absPos.X, absPos.Y + absSize.Y + 4)
                    activeOverlayScroll.CanvasSize = UDim2.fromOffset(0, #options * 28 + 8)

                    dropdownOverlayContainer.Visible = true
                    activeOverlayMenu.Visible = true
                    tween(arrowIcon, 0.15, {Rotation = 180})

                    Library.ActiveDropdown = {
                        OnClose = function()
                            tween(arrowIcon, 0.15, {Rotation = 0})
                        end
                    }
                end

                dropdown.Activated:Connect(function()
                    if dropdownOverlayContainer.Visible and Library.ActiveDropdown then
                        closeActiveDropdown()
                    else
                        openThisDropdown()
                    end
                end)

                local DropdownObj = {
                    Set = selectOpt,
                    Refresh = function(_, newOptions, newDefault)
                        options = newOptions or options
                        if newDefault then selectOpt(newDefault) else selectOpt(options[1]) end
                    end,
                    Value = function() return currentOption end,
                }
                return DropdownObj
            end

            -- ADD SLIDER
            function SectionObj:AddSlider(opts)
                opts = opts or {}
                local title = opts.Title or opts.Name or "Slider"
                local desc = opts.Description or opts.Desc or ""
                local flag = opts.Flag or title
                local minimum = opts.Min or 0
                local maximum = opts.Max or 100
                local step = opts.Increment or opts.Step or 1
                local suffix = opts.Suffix or ""
                local defaultVal = math.clamp(opts.Default or minimum, minimum, maximum)
                local callback = opts.Callback

                local currentValue = defaultVal
                Library.Flags[flag] = currentValue

                local row = createRow(title, desc, opts.Status)

                local holder = create("Frame", {
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -16, 0.5, 0),
                    Size = UDim2.fromOffset(170, 35),
                    BackgroundTransparency = 1,
                    ZIndex = 15,
                    Parent = row,
                })

                local valueLabel = makeText(holder, {
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, 0, 0, -2),
                    Size = UDim2.fromOffset(60, 15),
                    Text = tostring(currentValue) .. suffix,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    TextColor3 = Library.Theme.Accent,
                    Font = Enum.Font.GothamBold,
                    TextSize = 10,
                    ZIndex = 16,
                })

                local bar = create("TextButton", {
                    Position = UDim2.fromOffset(0, 21),
                    Size = UDim2.fromOffset(170, 8),
                    BackgroundColor3 = Color3.fromRGB(32, 41, 39),
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 15,
                    Parent = holder,
                })
                addCorner(bar, 4)

                local fill = create("Frame", {
                    Size = UDim2.new((currentValue - minimum) / math.max(maximum - minimum, 1), 0, 1, 0),
                    BackgroundColor3 = Library.Theme.Accent,
                    BorderSizePixel = 0,
                    ZIndex = 16,
                    Parent = bar,
                })
                addCorner(fill, 4)

                local function setSlider(val)
                    val = math.clamp(val, minimum, maximum)
                    if step > 0 then
                        val = math.floor((val - minimum) / step + 0.5) * step + minimum
                    end
                    currentValue = val
                    Library.Flags[flag] = currentValue
                    local alpha = (currentValue - minimum) / math.max(maximum - minimum, 1)
                    fill.Size = UDim2.new(alpha, 0, 1, 0)
                    valueLabel.Text = tostring(currentValue) .. suffix
                    if typeof(callback) == "function" then
                        task.spawn(callback, currentValue)
                    end
                end

                local draggingSlider = false
                local function updateFromInput(input)
                    local alpha = math.clamp((input.Position.X - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
                    local raw = minimum + (maximum - minimum) * alpha
                    setSlider(raw)
                end

                bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = true
                        updateFromInput(input)
                    end
                end)
                bar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = false
                    end
                end)

                local sliderConn
                sliderConn = UserInputService.InputChanged:Connect(function(input)
                    if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        updateFromInput(input)
                    end
                end)
                holder.Destroying:Connect(function()
                    if sliderConn then sliderConn:Disconnect() end
                end)

                local SliderObj = {
                    Set = setSlider,
                    Value = function() return currentValue end,
                }
                return SliderObj
            end

            -- ADD LABEL
            function SectionObj:AddLabel(opts)
                local title = (typeof(opts) == "table" and (opts.Title or opts.Text)) or tostring(opts or "Label")
                local desc = (typeof(opts) == "table" and (opts.Description or opts.Desc)) or ""
                local row = createRow(title, desc)
                return row
            end

            -- Space separator
            TabObj.Order = TabObj.Order + 1
            create("Frame", {
                Size = UDim2.new(1, -20, 0, 10),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = TabObj.Order,
                Parent = tabContainer,
            })

            return SectionObj
        end

        return TabObj
    end

    return WindowObj
end

-- =========================================================================
-- NOTIFICATIONS (Standalone ScreenGui with animation & icon)
-- =========================================================================
function Library:Notify(opts, contentArg, durationArg)
    local title = "Notification"
    local content = ""
    local duration = 3

    if typeof(opts) == "table" then
        title = opts.Title or opts.Name or "Notification"
        content = opts.Content or opts.Text or opts.Description or ""
        duration = opts.Duration or 3
    elseif typeof(opts) == "string" then
        if contentArg then
            title = opts
            content = tostring(contentArg)
            duration = tonumber(durationArg) or 3
        else
            content = opts
        end
    end

    local parentGui = getGuiParent()
    local notifGui = parentGui:FindFirstChild("TDTNotificationsGui")
    if not notifGui then
        notifGui = create("ScreenGui", {
            Name = "TDTNotificationsGui",
            ResetOnSpawn = false,
            IgnoreGuiInset = true,
            DisplayOrder = 999999,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            Parent = parentGui,
        })
    end

    local container = notifGui:FindFirstChild("Container")
    if not container then
        container = create("Frame", {
            Name = "Container",
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -20, 1, -24),
            Size = UDim2.fromOffset(280, 500),
            BackgroundTransparency = 1,
            ZIndex = 1000,
            Parent = notifGui,
        })
        create("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = container,
        })
    end

    local notifCard = create("Frame", {
        Name = "NotifCard",
        Size = UDim2.fromOffset(270, 68),
        BackgroundColor3 = Library.Theme.Surface,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 1001,
        Parent = container,
    })
    addCorner(notifCard, 8)
    addStroke(notifCard, Library.Theme.Accent, 1, 0.3)

    -- Lucide Bell icon
    local icon = create("ImageLabel", {
        Position = UDim2.fromOffset(12, 12),
        Size = UDim2.fromOffset(18, 18),
        BackgroundTransparency = 1,
        Image = resolveIcon("bell"),
        ImageColor3 = Library.Theme.Accent,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 1002,
        Parent = notifCard,
    })

    makeText(notifCard, {
        Position = UDim2.fromOffset(36, 10),
        Size = UDim2.new(1, -44, 0, 18),
        Text = title,
        TextColor3 = Library.Theme.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 1002,
    })
    makeText(notifCard, {
        Position = UDim2.fromOffset(12, 32),
        Size = UDim2.new(1, -24, 0, 26),
        Text = content,
        TextColor3 = Library.Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 1002,
    })

    -- Slide in animation
    notifCard.Position = UDim2.fromOffset(80, 0)
    notifCard.BackgroundTransparency = 1
    tween(notifCard, 0.22, {
        Position = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 0,
    }, Enum.EasingStyle.Back)

    task.delay(duration, function()
        if notifCard and notifCard.Parent then
            tween(notifCard, 0.2, {
                Position = UDim2.fromOffset(80, 0),
                BackgroundTransparency = 1,
            })
            task.delay(0.22, function()
                notifCard:Destroy()
            end)
        end
    end)
end

return Library
