local WindUI = loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/latest/download/main.lua'))()
local Window = WindUI:CreateWindow({
	Title = 'Universal SynSaveInstance',Icon='usb',
	Author = 'Save The Games You Are Playing In',
	Size = UDim2.fromOffset(710, 350),
	MinSize = Vector2.new(250, 250),
	MaxSize = Vector2.new(1000, 1000),
	ToggleKey = Enum.KeyCode.RightControl,
	Transparent = true,
	Theme = 'Dark',
	Resizable = true,
	SideBarWidth = 200,
	BackgroundImageTransparency = 0,
	HideSearchBar = true,
	HidePanelBackground = false,
	ScrollBarEnabled = true,
	OpenButton = {Title='USSI',Icon='expand',CornerRadius=UDim.new(0, 10),StrokeThickness=2.5,Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(200,200,200)),OnlyMobile=false,Enabled=true,Draggable=true}
})

local Options = {
	mode = 'full',
	FilePath = '',
	AvoidFileOverwrite = true,
	Binary = true,
	CompressionMode = 'none',
	CompressionLevel = 9,
	CopyToClipboard = false,
	ShowStatus = true,
	ShutdownWhenDone = false,
	AntiIdle = true,
	SafeMode = true,
	KillAllScripts = false,
	BoostFPS = false,
	Anonymous = false,
	RiskyServicesDisabled = {UGC=true,Encoding=false,Reflection=false},
	Decompile = true,
	scriptcache = true,
	DecompileTimeout = 10,
	BytecodeTimeout = 3,
	SaveBytecode = false,
	DecompileJobless = false,
	IgnoreDefaultPlayerScripts = false,
	NilInstances = true,
	IsolateStarterPlayer = false,
	IsolatePlayers = false,
	IsolateLocalPlayer = false,
	IsolateLocalPlayerCharacter = false,
	SavePlayerCharacters = true,
	SaveNotCreatable = true,
	IgnoreDefaultProperties = true,
	IgnoreNotArchivable = false,
	IgnoreSpecialProperties = false,
	AlternativeWritefile = false,
	SharedBinaryStrings = false,
	TreatUnionsAsParts = false,
	__DEBUG_MODE = false,
	ReadMe = true
}

local PTag=Window:Tag({Title='Ping: Error',Icon='gauge',Radius=10})
local FTag,LUpdates,FCounts=Window:Tag({Title='FPS: Error',Icon='activity',Radius=10}),os.clock(),0
local AD=Window:Dialog({Icon='badge-check',Title='Community Advertisement',Content='Join The Official Abaui Discord Server',Buttons={{Title='Copy The Invite Link',Callback=function()setclipboard('https://discord.gg/hnq9AGVMwq')end},{Title='No Thanks Later',Callback=function()--[[]]end}}})
local GTab=Window:Tab({Title='General',Icon='file-text'})
Window:Tag({Title='v1.0.0',Icon='history',Radius=10})
task.spawn(function()while true do local s,p=pcall(function()return game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()end)if s and type(p)=='number'then PTag:SetTitle('Ping: '..math.floor(p+0.5)..'ms')end task.wait(2.5)end end)
game:GetService('RunService').RenderStepped:Connect(function()FCounts=FCounts+1 local N=os.clock()if N-LUpdates>=1 then FTag:SetTitle('FPS: '..math.floor(FCounts/(N-LUpdates)+0.5))FCounts=0 LUpdates=N end end)
GTab:Dropdown({
	Title = 'Choose A Save Mode For The Game',
	Values = {'optimized','full','scripts'},
	Value = 'full',
	Callback = function(value)Options.mode=value end
})

GTab:Input({
	Title = 'Put Your File Path / Name',
	Placeholder = 'Optional Custom Filename Here',
	Value = '',
	Callback = function(value)Options.FilePath=value end
})

GTab:Toggle({
	Title = 'Avoid The File From Being Overwriten',
	Value = Options.AvoidFileOverwrite,
	Callback = function(value)Options.AvoidFileOverwrite=value end
})

GTab:Toggle({
	Title = 'Save As Binary Frmat (.rbxl)',
	Value = Options.Binary,
	Callback = function(value)Options.Binary=value end
})

GTab:Dropdown({
	Title = 'The Compression Modes (Default: none)',
	Values = {'zstd','lz4','none'},
	Value = 'none',
	Callback = function(value)Options.CompressionMode=value end
})

GTab:Slider({
	Title = 'The Compression Levels (Default: 9)',
	Value = {Min=-7,Max=22,Default=9},
	Step = 1,
	Callback = function(value)Options.CompressionLevel=math.floor(value)end
})

GTab:Toggle({
	Title = 'Copy It To The Clipboard (Under 2MB Recommended)',
	Value = Options.CopyToClipboard,
	Callback = function(value)Options.CopyToClipboard=value end
})

GTab:Toggle({
	Title = 'Show The Status GUI (Top-Right)',
	Value = Options.ShowStatus,
	Callback = function(value)Options.ShowStatus=value end
})

GTab:Toggle({
	Title = 'Anti-Idle Timeouts (Optional)',
	Value = Options.AntiIdle,
	Callback = function(value)Options.AntiIdle=value end
})

GTab:Toggle({
	Title = 'Leave The Game When Its Completed',
	Value = Options.ShutdownWhenDone,
	Callback = function(value)Options.ShutdownWhenDone=value end
})

GTab:Button({
	Title = 'Start Saving The Game Now',
	Callback = function()
		task.spawn(function()
			local gg,ss=pcall(function()return loadstring(game:HttpGet('https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/saveinstance.luau',true),'saveinstance')()end)
			if gg and type(ss)=='function'then
				if Options.FilePath==''then Options.FilePath=nil end
				local s,bg=pcall(function()ss(Options)end)
				if not s then WindUI:Notify({Title='USSI Failed',Content=tostring(bg),Duration=15})end
			else WindUI:Notify({Title='Couldmt Load USSI',Content=tostring(ss),Duration=10})end
		end)
	end
})

local STab=Window:Tab({Title='The Safety',Icon='shield'})
STab:Toggle({
	Title = 'The Safe Mode (Highly Recommended)',
	Desc = 'Kicks You Before Saving Game To Block The Server Telemetry',
	Value = Options.SafeMode,
	Callback = function(value)Options.SafeMode=value end
})

STab:Toggle({
	Title = 'Kill All Localscripts (Enabled By Safe Mode)',
	Desc = 'Disables Every LocalScript Before Saving The Game',
	Value = Options.KillAllScripts,
	Callback = function(value)Options.KillAllScripts=value end
})

STab:Toggle({
	Title = 'Boost Your Average FPS (Enabled By Safe Mode)',
	Desc = 'Disables 3D Rendering To Optimize The Memory (RAM)',
	Value = Options.BoostFPS,
	Callback = function(value)Options.BoostFPS=value end
})

STab:Toggle({
	Title = 'Anonymous Mode (Unrecommended)',
	Desc = 'Strips Names & UserID From The Saved Game',
	Value = Options.Anonymous,
	Callback = function(value)Options.Anonymous=value end
})

STab:Toggle({
	Title = 'Disable The UGC Service (Recommended)',
	Value = Options.RiskyServicesDisabled.UGC,
	Callback = function(value)Options.RiskyServicesDisabled.UGC=value end
})

STab:Toggle({
	Title = 'Disable The Encoding Service',
	Value = Options.RiskyServicesDisabled.Encoding,
	Callback = function(value)Options.RiskyServicesDisabled.Encoding=value end
})

STab:Toggle({
	Title = 'Disable The Reflection Service',
	Value = Options.RiskyServicesDisabled.Reflection,
	Callback = function(value)Options.RiskyServicesDisabled.Reflection=value end
})

local DTab=Window:Tab({Title='Decompilers',Icon='code'})
DTab:Toggle({
	Title = 'Decompile All LocalScripts',
	Value = Options.Decompile,
	Callback = function(value)Options.Decompile=value end
})

DTab:Toggle({
	Title = 'Use The Scripts Cache',
	Value = Options.scriptcache,
	Callback = function(value)Options.scriptcache=value end
})

DTab:Slider({
	Title = 'Decompiler Timeout (Seconds)',
	Value = {Min=1,Max=60,Default=10},
	Step = 1,
	Callback = function(value)Options.DecompileTimeout=math.floor(value)end
})

DTab:Slider({
	Title = 'Bytecodes Timeout (Seconds)',
	Value = {Min=1,Max=30,Default=5},
	Step = 1,
	Callback = function(value)Options.BytecodeTimeout=math.floor(value)end
})

DTab:Toggle({
	Title = 'Include The Scripts Bytecode',
	Value = Options.SaveBytecode,
	Callback = function(value)Options.SaveBytecode=value end
})

DTab:Toggle({
	Title = 'Decompile The Jobless Stuff',
	Value = Options.DecompileJobless,
	Callback = function(value)Options.DecompileJobless=value end
})

DTab:Toggle({
	Title = 'Ignore The Default PlayerScripts',
	Value = Options.IgnoreDefaultPlayerScripts,
	Callback = function(value)Options.IgnoreDefaultPlayerScripts=value end
})

local ITab=Window:Tab({Title='Filtration',Icon='folder'})
ITab:Toggle({
	Title = 'Include The Nil Instances',
	Value = Options.NilInstances,
	Callback = function(value)Options.NilInstances=value end
})

ITab:Toggle({
	Title = 'Isolate The StarterPlayer',
	Value = Options.IsolateStarterPlayer,
	Callback = function(value)Options.IsolateStarterPlayer=value end
})

ITab:Toggle({
	Title = 'Isolate Other Players',
	Value = Options.IsolatePlayers,
	Callback = function(value)Options.IsolatePlayers=value end
})

ITab:Toggle({
	Title = 'Isolate The LocalPlayer',
	Value = Options.IsolateLocalPlayer,
	Callback = function(value)Options.IsolateLocalPlayer=value end
})

ITab:Toggle({
	Title = 'Isolate The LocalPlayer Character',
	Value = Options.IsolateLocalPlayerCharacter,
	Callback = function(value)Options.IsolateLocalPlayerCharacter=value end
})

ITab:Toggle({
	Title = 'Include The Player Characters',
	Value = Options.SavePlayerCharacters,
	Callback = function(value)Options.SavePlayerCharacters=value end
})

ITab:Toggle({
	Title = 'Include Not-Creatable Stuff',
	Value = Options.SaveNotCreatable,
	Callback = function(value)Options.SaveNotCreatable=value end
})

local ATab=Window:Tab({Title='Advanced',Icon='wrench'})
ATab:Toggle({
	Title = 'Ignore Default Properties',
	Value = Options.IgnoreDefaultProperties,
	Callback = function(value)Options.IgnoreDefaultProperties=value end
})

ATab:Toggle({
	Title = 'Ignore Not Archivable',
	Value = Options.IgnoreNotArchivable,
	Callback = function(value)Options.IgnoreNotArchivable=value end
})

ATab:Toggle({
	Title = 'Ignore Special Properties',
	Value = Options.IgnoreSpecialProperties,
	Callback = function(value)Options.IgnoreSpecialProperties=value end
})

ATab:Toggle({
	Title = 'Alternative Writefile()',
	Value = Options.AlternativeWritefile,
	Callback = function(value)Options.AlternativeWritefile=value end
})

ATab:Toggle({
	Title = 'Shared Binary Strings',
	Value = Options.SharedBinaryStrings,
	Callback = function(value)Options.SharedBinaryStrings=value end
})

ATab:Toggle({
	Title = 'Treat Unions As Parts',
	Value = Options.TreatUnionsAsParts,
	Callback = function(value)Options.TreatUnionsAsParts=value end
})

ATab:Toggle({
	Title = 'The Debugging Mode',
	Value = Options.__DEBUG_MODE,
	Callback = function(value)Options.__DEBUG_MODE=value end
})

ATab:Toggle({
	Title = 'Include The README Script',
	Value = Options.ReadMe,
	Callback = function(value)Options.ReadMe=value end
})

local themes={}
local SSTab=Window:Tab({Title='UI Settings',Icon='settings'})
for themeName in pairs(WindUI:GetThemes()) do table.insert(themes,themeName)end
table.sort(themes)
SSTab:Dropdown({
	Title = 'Select An UI Theme',
	Values = themes,
	Value = WindUI:GetCurrentTheme(),
	SearchBarEnabled = true,
	Callback = function(value)WindUI:SetTheme(value)end
})

SSTab:Toggle({
	Title = 'Window Transparency',
	Value = WindUI:GetTransparency(),
	Callback = function(value)Window:ToggleTransparency(value)end
})

SSTab:Input({
	Title = 'Background Image URL / Asset ID',
	Placeholder = 'rbxassetid://...',
	Callback = function(value)if value and value~=''then Window:SetBackgroundImage(value)end end
})

SSTab:Slider({
	Title = 'Background Image Transparency',
	Value = {Min=0,Max=1,Default=0},
	Step = 0.1,
	Callback = function(value)Window:SetBackgroundImageTransparency(value)end
})

SSTab:Keybind({
	Title = 'Toggle UI Keybind',
	Value = 'RightControl',
	Callback = function(value)if Enum.KeyCode[value] then Window:SetToggleKey(Enum.KeyCode[value])end end
})

SSTab:Toggle({
	Title = 'Resizable Window',
	Value = true,
	Callback = function(value)Window:IsResizable(value)end
})

SSTab:Slider({
	Title = 'Window Icon Size',
	Value = {Min=1,Max=60,Default=30},
	Step = 1,
	Callback = function(value)Window:SetIconSize(math.floor(value))end
})

SSTab:Input({
	Title = 'Custom Font Asset ID',
	Placeholder = 'rbxassetid://...',
	Callback = function(value)if value and value~=''then WindUI:SetFont(value)end end
})

SSTab:Toggle({
	Title = 'Notifications At Bottom',
	Value = false,
	Callback = function(value)WindUI:SetNotificationLower(value)end
})

SSTab:Input({
	Title = 'Open Button Title',
	Value = 'USSI',
	Callback = function(value)Window:EditOpenButton({Title=value})end
})

SSTab:Input({
	Title = 'Open Button Icon',
	Value = 'expand',
	Callback = function(value)if value and value~=''then Window:EditOpenButton({Icon=value})end end
})

SSTab:Toggle({
	Title = 'Draggable Open Button',
	Value = true,
	Callback = function(value)Window:EditOpenButton({Draggable=value})end
})

SSTab:Slider({
	Title = 'Open Button Corner Radius',
	Value = {Min=0,Max=50,Default=10},
	Step = 1,
	Callback = function(value)Window:EditOpenButton({CornerRadius=UDim.new(0,math.floor(value))})end
})

SSTab:Slider({
	Title = 'Open Button Stroke Thickness',
	Value = {Min=0,Max=10,Default=2.5},
	Step = 0.5,
	Callback = function(value)Window:EditOpenButton({StrokeThickness=math.floor(value)})end
})

SSTab:Colorpicker({
	Title = 'Open Button Color',
	Default = Color3.fromRGB(255,255,255),
	Callback = function(color)Window:EditOpenButton({Color=ColorSequence.new(color,color)})end
})

SSTab:Button({
	Title = 'Show Current Window Size',
	Callback = function()
		WindUI:Notify({
			Title = 'Current Window Size',
			Content = tostring(WindUI:GetWindowSize().X.Offset)..' x '..tostring(WindUI:GetWindowSize().Y.Offset),
			Duration = 5
		})
	end
})

local CTab=Window:Tab({Title='Credits',Icon='heart'})
CTab:Button({
	Title = 'Abaui Discord Server',
	Desc = 'Copies The Discord Server URL',
	Callback = function()
		setclipboard('https://discord.gg/hnq9AGVMwq')
		WindUI:Notify({Title='Discord Server URL Copied!',Duration=5})
	end
})

CTab:Paragraph({Title='The UI & Options Infomation',Desc='The UI & Options Were Constructed By aabbaaii13 (me) From Discord'})
CTab:Paragraph({Title='The Original Script Infomation',Desc='UniversalSynSaveInstance Was Created By The Original Developers'})
CTab:Button({
	Title = 'USSI Discord Server URL',
	Desc = 'Copies The Discord Server URL',
	Callback = function()
		setclipboard('https://discord.gg/saveinstance')
		WindUI:Notify({Title='Discord Server URL Copied!',Duration=5})
	end
})

CTab:Button({
	Title = 'USSI Repository Link',
	Desc = 'Copies The Repository Link',
	Callback = function()
		setclipboard('https://github.com/luau/UniversalSynSaveInstance')
		WindUI:Notify({Title='Repository Link Copied!',Duration=5})
	end
})

CTab:Button({
	Title = 'USSI License Link',
	Desc = 'Copies The License Link',
	Callback = function()
		setclipboard('https://github.com/luau/UniversalSynSaveInstance/blob/main/LICENSE')
		WindUI:Notify({Title='License Link Copied!',Duration=5})
	end
})
