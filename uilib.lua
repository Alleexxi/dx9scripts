--// Supg's DX9Ware UI Win | Open Source //--
local game = dx9.GetDatamodel();
local Workspace = dx9.FindFirstChild(game,"Workspace");
local Mouse = dx9.GetMouse();
local LocalPlayer = dx9.get_localplayer();
local Players = dx9.get_players();

--[[
ADD SUPPORT FOR ROUNDING (for now it only supports 0)

]]

--[[
 ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗         ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║         ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
██║  ███╗██║     ██║   ██║██████╔╝███████║██║         █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║         ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗    ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
 ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
]]


--// Log Function
local log = "_LOG_\n"
function Log(...)
    local temp = ""
    for i,v in pairs({...}) do
        temp = temp..tostring(v).." "
    end
    log = log..temp.."\n"
    dx9.DrawString({1700,800}, {255,255,255}, log);
end
Log("X:", dx9.GetMouse().x, "Y:", dx9.GetMouse().y)


--// Boundary Check
function mouse_in_boundary(v1, v2)
    if Mouse.x > v1[1] and Mouse.y > v1[2] and Mouse.x < v2[1] and Mouse.y < v2[2] then
        return true
    else
        return false
    end
end


--[[
██╗   ██╗ █████╗ ██████╗ ██╗ █████╗ ██████╗ ██╗     ███████╗███████╗
██║   ██║██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝
██║   ██║███████║██████╔╝██║███████║██████╔╝██║     █████╗  ███████╗
╚██╗ ██╔╝██╔══██║██╔══██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ╚════██║
 ╚████╔╝ ██║  ██║██║  ██║██║██║  ██║██████╔╝███████╗███████╗███████║
  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
]]


--// Global Dynamic Values
if _G.Lib == nil then
    _G.Lib = {
        FontColor = {255,255,255}; -- Static + [Changeable]
        MainColor = {28,28,28}; -- Static + [Changeable]
        BackgroundColor = {20,20,20}; -- Static + [Changeable]
        AccentColor = {0,85,255}; -- Static + [Changeable]
        OutlineColor = {50,50,50}; -- Static + [Changeable]

        Black = {0,0,0}; -- Static

        RainbowHue = 0; -- Dynamic
        CurrentRainbowColor = {0,0,0}; -- Dynamic

        FocusedWindow = nil; -- Dynamic

        WindowCount = 0; -- Dynamic

        Watermark = {
            Text = "";
            Visible = true;
        }
    };
end
local Lib = _G.Lib



--[[
██╗   ██╗██╗    ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
██║   ██║██║    ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
██║   ██║██║    █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
██║   ██║██║    ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
╚██████╔╝██║    ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
 ╚═════╝ ╚═╝    ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
]]

--// Create Window Function
function Lib:CreateWindow(index)
    Log(index, " Created")
    -- If indexed window missing, create a new one
    if _G[index] == nil then
        _G[index] = {
            Location = {1300, 300}; -- Dynamic

            Size = {550, 600}; -- Static

            Rainbow = false; -- Dynamic + [Changeable]
    
            Name = index; -- Dynamic + [Changeable]

            ID = index; -- Static

            WinMouseOffset = nil; -- Dynamic

            WindowNum = Lib.WindowCount + 1; -- Static

            Tabs = {}; -- Dynamic

            CurrentTab = nil; -- Dynamic

            TabMargin = 0; -- REALLY DYNAMIC OMG

            Tools = {};
        }
        Lib.WindowCount = Lib.WindowCount + 1
    end
    local Win = _G[index]


    --// Left Click Held
    if dx9.isLeftClickHeld() then

        --// Drag Func
        if mouse_in_boundary({Win.Location[1] - 5, Win.Location[2] - 10}, {Win.Location[1] + Win.Size[1] + 5, Win.Location[2] + 30}) then
            if Lib.FocusedWindow == nil or Lib.FocusedWindow == Win.ID then
                Lib.FocusedWindow = Win.ID
                if Win.WinMouseOffset == nil then
                    Win.WinMouseOffset = {Mouse.x - Win.Location[1], Mouse.y - Win.Location[2]}
                end
                Win.Location = {Mouse.x - Win.WinMouseOffset[1], Mouse.y - Win.WinMouseOffset[2]}
            else
                if Win.WindowNum > _G[Lib.FocusedWindow].WindowNum then
                    Lib.FocusedWindow = Win.ID
                else
                    Win.WinMouseOffset = nil
                    Lib.FocusedWindow = nil
                end
            end
        end
        
        --// Tab Click Func
        for _, t in next, Win.Tabs do
            if mouse_in_boundary({t.Boundary[1], t.Boundary[2]}, {t.Boundary[3], t.Boundary[4]}) then
                Log("TAB CLICK:", t.Name)
                Win.CurrentTab = t.Name;
            end
        end
    else
        Win.WinMouseOffset = nil
        Lib.FocusedWindow = nil
    end


    --// Display Window //--

    --// Main Window
    dx9.DrawFilledBox({Win.Location[1] - 1, Win.Location[2] - 1}, {Win.Location[1] + Win.Size[1] + 1, Win.Location[2] + Win.Size[2] + 1}, Lib.Black) --// Outline
    if Win.Rainbow == true then
        dx9.DrawFilledBox(Win.Location, {Win.Location[1] + Win.Size[1], Win.Location[2] + Win.Size[2]}, Lib.CurrentRainbowColor) --// Accent (Rainbow)
    else
        dx9.DrawFilledBox(Win.Location, {Win.Location[1] + Win.Size[1], Win.Location[2] + Win.Size[2]}, Lib.AccentColor) --// Accent
    end
    dx9.DrawFilledBox({Win.Location[1] + 1, Win.Location[2] + 1}, {Win.Location[1] + Win.Size[1] - 1, Win.Location[2] + Win.Size[2] - 1}, Lib.MainColor) --// Main Outer (light gray)
    dx9.DrawFilledBox({Win.Location[1] + 5, Win.Location[2] + 20}, {Win.Location[1] + Win.Size[1] - 5, Win.Location[2] + Win.Size[2] - 5}, Lib.BackgroundColor) --// Main Inner (dark gray)
    dx9.DrawBox({Win.Location[1] + 5, Win.Location[2] + 20}, {Win.Location[1] + Win.Size[1] - 5, Win.Location[2] + Win.Size[2] - 5}, Lib.OutlineColor) --// Main Inner Outline
    dx9.DrawString(Win.Location, Lib.FontColor, " "..Win.Name)
    dx9.DrawFilledBox({Win.Location[1] + 10, Win.Location[2] + 49}, {Win.Location[1] + Win.Size[1] - 10, Win.Location[2] + Win.Size[2] - 10}, Lib.Black) --// Main Tab Box Outline
    dx9.DrawFilledBox({Win.Location[1] + 11, Win.Location[2] + 50}, {Win.Location[1] + Win.Size[1] - 11, Win.Location[2] + Win.Size[2] - 11}, Lib.MainColor) --// Main Tab Box


    --// Change Name Function
    function Win:SetWindowTitle(title)
        Win.Name = title
    end

    --// Set Window to RGB Function
    function Win:SetRGB(bool)
        Win.Rainbow = bool
    end
    
    --// Add Tab Function
    function Win:AddTab(TabName, TabLength)
        local Tab = {}
        if Win.Tabs[TabName] == nil then
            Tab = {
                Name = TabName;
                Boundary = {0,0,0,0};
                Length = TabLength;
                Groupboxes = {};

                rightstack = 60;
                leftstack = 60;
            };
            Win.Tabs[TabName] = Tab;
        end
        Win.Tabs[TabName].Length = TabLength;
        Win.Tabs[TabName].Name = TabName;

        Tab = Win.Tabs[TabName];
        
        --// Display Tab
        if Win.CurrentTab ~= nil and Win.CurrentTab == Tab.Name then
            dx9.DrawFilledBox({Win.Location[1] + 10 + Win.TabMargin, Win.Location[2] + 26}, {Win.Location[1] + 14 + Tab.Length + Win.TabMargin, Win.Location[2] + 50}, Lib.Black)
            dx9.DrawFilledBox({Win.Location[1] + 11 + Win.TabMargin, Win.Location[2] + 27}, {Win.Location[1] + 13 + Tab.Length + Win.TabMargin, Win.Location[2] + 50}, Lib.MainColor)
            dx9.DrawFilledBox({Win.Location[1] + 12 + Win.TabMargin, Win.Location[2] + 28}, {Win.Location[1] + 12 + Tab.Length + Win.TabMargin, Win.Location[2] + 50}, Lib.MainColor)
        else
            dx9.DrawFilledBox({Win.Location[1] + 10 + Win.TabMargin, Win.Location[2] + 26}, {Win.Location[1] + 14 + Tab.Length + Win.TabMargin, Win.Location[2] + 50}, Lib.Black)
            dx9.DrawFilledBox({Win.Location[1] + 11 + Win.TabMargin, Win.Location[2] + 27}, {Win.Location[1] + 13 + Tab.Length + Win.TabMargin, Win.Location[2] + 49}, Lib.MainColor)
            dx9.DrawFilledBox({Win.Location[1] + 12 + Win.TabMargin, Win.Location[2] + 28}, {Win.Location[1] + 12 + Tab.Length + Win.TabMargin, Win.Location[2] + 48}, Lib.BackgroundColor)
        end
        
        dx9.DrawString({Win.Location[1] + 12 + Win.TabMargin, Win.Location[2] + 28}, Lib.FontColor, " "..Tab.Name)
        
        Win.Tabs[TabName].Boundary = {Win.Location[1] + 10 + Win.TabMargin, Win.Location[2] + 26, Win.Location[1] + 14 + Tab.Length + Win.TabMargin, Win.Location[2] + 50}
        Win.TabMargin = Win.TabMargin + Tab.Length + 4

        --// Add Groupbox to Tab
        function Tab:AddGroupbox(name, side)
            local Groupbox = {}
            if  Tab.Groupboxes[name] == nil then
                Groupbox = {
                    Name = name; -- Static + [Changeable]
                    Side = side; -- Static + [Changeable]
                    Vertical = 30; -- Dynamic
                    ToolSpacing = 0;

                    Tools = {};
                    Root = {};
                };
                Tab.Groupboxes[name] = Groupbox
            end
            Tab.Groupboxes[name].Name = name
            Groupbox = Tab.Groupboxes[name]

            --// Display Groupbox
            if Win.CurrentTab ~= nil and Win.CurrentTab == Tab.Name then
                if Groupbox.Side == "Left" then 
                    dx9.DrawFilledBox({Win.Location[1] + 20, Win.Location[2] + Tab.leftstack}, {Win.Location[1] + 270, Win.Location[2] + Tab.leftstack + Groupbox.Vertical}, Lib.Black)
                    if Win.Rainbow == true then 
                        dx9.DrawFilledBox({Win.Location[1] + 21, Win.Location[2] + Tab.leftstack + 1}, {Win.Location[1] + 269, Win.Location[2] + Tab.leftstack + 3}, Lib.CurrentRainbowColor)
                    else
                        dx9.DrawFilledBox({Win.Location[1] + 21, Win.Location[2] + Tab.leftstack + 1}, {Win.Location[1] + 269, Win.Location[2] + Tab.leftstack + 3}, Lib.AccentColor)
                    end
                    dx9.DrawFilledBox({Win.Location[1] + 21, Win.Location[2] + Tab.leftstack + 4}, {Win.Location[1] + 269, Win.Location[2] + Tab.leftstack + Groupbox.Vertical - 1}, Lib.BackgroundColor)
                    dx9.DrawString({Win.Location[1] + 21, Win.Location[2] + Tab.leftstack + 4}, Lib.FontColor, " "..Groupbox.Name)

                    Groupbox.Root = {Win.Location[1] + 21, Win.Location[2] + Tab.leftstack + 10}
                    Tab.leftstack = Tab.leftstack + Groupbox.Vertical + 10
                else
                    dx9.DrawFilledBox({Win.Location[1] + 280, Win.Location[2] + Tab.rightstack}, {Win.Location[1] + 530, Win.Location[2] + Tab.rightstack + Groupbox.Vertical}, Lib.Black)
                    if Win.Rainbow == true then 
                        dx9.DrawFilledBox({Win.Location[1] + 281, Win.Location[2] + Tab.rightstack + 1}, {Win.Location[1] + 529, Win.Location[2] + Tab.rightstack + 3}, Lib.CurrentRainbowColor)
                    else
                        dx9.DrawFilledBox({Win.Location[1] + 281, Win.Location[2] + Tab.rightstack + 1}, {Win.Location[1] + 529, Win.Location[2] + Tab.rightstack + 3}, Lib.AccentColor)
                    end
                    dx9.DrawFilledBox({Win.Location[1] + 281, Win.Location[2] + Tab.rightstack + 4}, {Win.Location[1] + 529, Win.Location[2] + Tab.rightstack + Groupbox.Vertical - 1}, Lib.BackgroundColor)
                    dx9.DrawString({Win.Location[1] + 281, Win.Location[2] + Tab.rightstack + 4}, Lib.FontColor, " "..Groupbox.Name)

                    Groupbox.Root = {Win.Location[1] + 281, Win.Location[2] + Tab.rightstack + 10}
                    Tab.rightstack = Tab.rightstack + Groupbox.Vertical + 10
                end
            end

            --// Add Button to Groupbox
            function Groupbox:AddButton(btn_name, func)
                local idx = "btn_"..btn_name
                local Button = {}
                
                if Groupbox.Tools[idx] == nil then
                    Button = {
                        Name = btn_name;
                        Function = func;
                        Boundary = {0,0,0,0};
                        Holding = false;
                    }
                    Groupbox.Tools[idx] = Button
                end
                Groupbox.Tools[idx].Name = btn_name
                Groupbox.Tools[idx].Function = func

                Button = Groupbox.Tools[idx]

                --// Draw Button in Groupbox
                if Win.CurrentTab ~= nil and Win.CurrentTab == Tab.Name then
                    Groupbox.Vertical = Groupbox.Vertical + 25

                    dx9.DrawFilledBox({Groupbox.Root[1] + 4, Groupbox.Root[2] + 19 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 243, Groupbox.Root[2] + 40 + Groupbox.ToolSpacing}, Lib.Black)
                    if Win.Rainbow == true then 
                        dx9.DrawFilledBox({Groupbox.Root[1] + 5, Groupbox.Root[2] + 20 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 242, Groupbox.Root[2] + 39 + Groupbox.ToolSpacing}, Lib.CurrentRainbowColor)
                    else
                        dx9.DrawFilledBox({Groupbox.Root[1] + 5, Groupbox.Root[2] + 20 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 242, Groupbox.Root[2] + 39 + Groupbox.ToolSpacing}, Lib.AccentColor)
                    end
                    if Button.Holding == true then
                        dx9.DrawFilledBox({Groupbox.Root[1] + 6, Groupbox.Root[2] + 21 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 241, Groupbox.Root[2] + 38 + Groupbox.ToolSpacing}, Lib.OutlineColor)
                    else
                        dx9.DrawFilledBox({Groupbox.Root[1] + 6, Groupbox.Root[2] + 21 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 241, Groupbox.Root[2] + 38 + Groupbox.ToolSpacing}, Lib.MainColor)
                    end

                    dx9.DrawString({Groupbox.Root[1] + 6, Groupbox.Root[2] + 20 + Groupbox.ToolSpacing}, Lib.FontColor, " "..Button.Name)

                    Button.Boundary = {Groupbox.Root[1] + 4, Groupbox.Root[2] + 19 + Groupbox.ToolSpacing, Groupbox.Root[1] + 243, Groupbox.Root[2] + 40 + Groupbox.ToolSpacing}

                    Groupbox.ToolSpacing = Groupbox.ToolSpacing + 25

                    --// Click Detect
                    if dx9.isLeftClickHeld() then
                        if mouse_in_boundary({Button.Boundary[1], Button.Boundary[2]}, {Button.Boundary[3], Button.Boundary[4]}) then
                            Button.Holding = true;
                        else
                            Button.Holding = false;
                        end
                    else
                        if Button.Holding == true then
                            Button.Function();
                            Button.Holding = false;
                        end
                    end
                end

                --// Closing Difines and Resets | Button
                Groupbox.Tools[idx] = Button;
                return Button;
            end


            --// Add Slider to Groupbox
            function Groupbox:AddSlider(index, params)
                local Slider = {}
                
                if Groupbox.Tools[index] == nil then
                    Slider = {
                        Text = params.Text;
                        Boundary = {0,0,0,0};
                        Holding = false;
                        Value = (1 / (params.Max/tonumber(params.Default)));
                        Rounding = (params.Rounding or 0);
                        Suffix = (params.Suffix or "");

                        StoredVal = nil;
                    }
                    Groupbox.Tools[index] = Slider
                end
                Slider = Groupbox.Tools[index]
                Slider.Text = params.Text;
                Slider.Rounding = (params.Rounding or 0);
                Slider.Suffix = (params.Suffix or "");
    
                function Slider:SetValue(num)
                    if Slider.StoredVal ~= num then
                        Slider.Value = 1 / (params.Max/tonumber(num))
                        Slider.StoredVal = num 

                        function Slider:OnChanged(func)
                            func()
                        end
                    end
                end
                function Slider:OnChanged(func)
                end


                --// Draw Slider in Groupbox
                if Win.CurrentTab ~= nil and Win.CurrentTab == Tab.Name then
                    local temp = math.floor((((params.Max - params.Min) * Slider.Value) + params.Min))..Slider.Suffix.."/"..params.Max..Slider.Suffix
                    local bar_length = 235

                    Groupbox.Vertical = Groupbox.Vertical + 40

                    dx9.DrawFilledBox({Groupbox.Root[1] + 4, Groupbox.Root[2] + 34 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 243, Groupbox.Root[2] + 55 + Groupbox.ToolSpacing}, Lib.Black)

                    dx9.DrawFilledBox({Groupbox.Root[1] + 5, Groupbox.Root[2] + 35 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 242, Groupbox.Root[2] + 54 + Groupbox.ToolSpacing}, Lib.OutlineColor)

                    if Slider.Holding == true then
                        dx9.DrawFilledBox({Groupbox.Root[1] + 6, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 241, Groupbox.Root[2] + 53 + Groupbox.ToolSpacing}, Lib.OutlineColor)
                    else
                        dx9.DrawFilledBox({Groupbox.Root[1] + 6, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 241, Groupbox.Root[2] + 53 + Groupbox.ToolSpacing}, Lib.MainColor)
                    end

                    if Win.Rainbow == true then 
                        dx9.DrawFilledBox({Groupbox.Root[1] + 6, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 6 + (bar_length * Slider.Value), Groupbox.Root[2] + 53 + Groupbox.ToolSpacing}, Lib.CurrentRainbowColor)
                    else
                        dx9.DrawFilledBox({Groupbox.Root[1] + 6, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 6 + (bar_length * Slider.Value), Groupbox.Root[2] + 53 + Groupbox.ToolSpacing}, Lib.AccentColor)
                    end

                    dx9.DrawString({Groupbox.Root[1] + 4, Groupbox.Root[2] + 18 + Groupbox.ToolSpacing}, Lib.FontColor, params.Text)

                    dx9.DrawString({Groupbox.Root[1] + 8, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing}, Lib.FontColor, temp)

                    Slider.Boundary = {Groupbox.Root[1] + 6, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing, Groupbox.Root[1] + 241, Groupbox.Root[2] + 53 + Groupbox.ToolSpacing}

                    Groupbox.ToolSpacing = Groupbox.ToolSpacing + 40

                    Log(Slider.Value)
                    --// Click Detect
                    if dx9.isLeftClickHeld() then
                        if mouse_in_boundary({Slider.Boundary[1], Slider.Boundary[2]}, {Slider.Boundary[3], Slider.Boundary[4]}) then
                            Slider.Holding = true;
                            local bar_length = 235
                            local cursor = (Mouse.x) - (Groupbox.Root[1] + 6)
                            local val = 1 / (bar_length/cursor)
                            if val >= .98 then val = 1 end
                            if val <= .02 then val = 0 end
                            Slider.Value = val
                            Slider.StoredVal = cursor
                            function Slider:OnChanged(func)
                                func()
                            end
                        else
                            Slider.Holding = false;
                        end
                    else
                        if Slider.Holding == true then
                            Slider.Holding = false;
                        end
                    end
                end

                --// Closing Difines and Resets | Slider
                Groupbox.Tools[index] = Slider;
                Win.Tools[index] = Slider;
                return Slider;
            end


            --// Add Toggle to Groupbox | :AddToggle(index, {Default = true, Text = "Toggle"})
            function Groupbox:AddToggle(index, params) 
                local Toggle = {}
                
                if Groupbox.Tools[index] == nil then
                    Toggle = {
                        Text = params.Text;
                        Boundary = {0,0,0,0};
                        Value = params.Default or false;
                        Holding = false;
                    }
                    Groupbox.Tools[index] = Toggle
                end
                Groupbox.Tools[index].Text = params.Text
                Toggle = Groupbox.Tools[index]


                function Toggle:SetValue(value)
                    Toggle.Value = value;

                    function Toggle:OnChanged(func)
                        func()
                    end
                end
                function Toggle:OnChanged(func)
                end
                

                --// Draw Toggle in Groupbox
                if Win.CurrentTab ~= nil and Win.CurrentTab == Tab.Name then
                    Groupbox.Vertical = Groupbox.Vertical + 25

                    dx9.DrawFilledBox({Groupbox.Root[1] + 6, Groupbox.Root[2] + 21 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 23, Groupbox.Root[2] + 38 + Groupbox.ToolSpacing}, Lib.Black)

                    if Win.Rainbow then 
                        dx9.DrawFilledBox({Groupbox.Root[1] + 7, Groupbox.Root[2] + 22 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 22, Groupbox.Root[2] + 37 + Groupbox.ToolSpacing}, Lib.CurrentRainbowColor)
                    else
                        dx9.DrawFilledBox({Groupbox.Root[1] + 7, Groupbox.Root[2] + 22 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 22, Groupbox.Root[2] + 37 + Groupbox.ToolSpacing}, Lib.AccentColor)
                    end

                    if Toggle.Value then
                        if Win.Rainbow then 
                            dx9.DrawFilledBox({Groupbox.Root[1] + 8, Groupbox.Root[2] + 23 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 21, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing}, Lib.CurrentRainbowColor)
                        else
                            dx9.DrawFilledBox({Groupbox.Root[1] + 8, Groupbox.Root[2] + 23 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 21, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing}, Lib.AccentColor)
                        end
                    else
                        dx9.DrawFilledBox({Groupbox.Root[1] + 8, Groupbox.Root[2] + 23 + Groupbox.ToolSpacing}, {Groupbox.Root[1] + 21, Groupbox.Root[2] + 36 + Groupbox.ToolSpacing}, Lib.MainColor)
                    end

                    dx9.DrawString({Groupbox.Root[1] + 23, Groupbox.Root[2] + 19 + Groupbox.ToolSpacing}, Lib.FontColor, " "..Toggle.Text)

                    Toggle.Boundary = {Groupbox.Root[1] + 4, Groupbox.Root[2] + 19 + Groupbox.ToolSpacing, Groupbox.Root[1] + 243, Groupbox.Root[2] + 40 + Groupbox.ToolSpacing}

                    Groupbox.ToolSpacing = Groupbox.ToolSpacing + 25


                    --// Click Detect
                    if dx9.isLeftClickHeld() then
                        if mouse_in_boundary({Toggle.Boundary[1], Toggle.Boundary[2]}, {Toggle.Boundary[3], Toggle.Boundary[4]}) then
                            Toggle.Holding = true;
                        else
                            Toggle.Holding = false;
                        end
                    else
                        if Toggle.Holding == true then
                            Toggle:SetValue(not Toggle.Value)
                            Toggle.Holding = false;
                        end
                    end
                end

                --// Closing Difines and Resets | Toggle
                Groupbox.Tools[index] = Toggle;
                Win.Tools[index] = Toggle;
                return Toggle;
            end

            --// Closing Difines and Resets | Groupbox
            Groupbox.Vertical = 30;
            Groupbox.ToolSpacing = 0;

            Tab.Groupboxes[name] = Groupbox;
            return Groupbox;
        end


        --// Add Left Groupbox Function
        function Tab:AddLeftGroupbox(name)
            return Tab:AddGroupbox(name, "Left")
        end

        --// Add Right Groupbox Function
        function Tab:AddRightGroupbox(name)
            return Tab:AddGroupbox(name, "Right")
        end

        --// Closing Difines and Resets | Tab
        Win.Tabs[TabName] = Tab;

        Tab.leftstack = 60;
        Tab.rightstack = 60;
        
        return Tab;
    end

    --// Closing Difines and Resets | Window
    Win.TabMargin = 0
    Win.Tools = {};

    return(Win)
end


--// Watermark
if Lib.Watermark.Visible then
    dx9.DrawFilledBox({150, 10}, {500, 32}, Lib.Black)
    dx9.DrawFilledBox({151, 11}, {499, 31}, Lib.CurrentRainbowColor)
    dx9.DrawFilledBox({152, 12}, {498, 30}, Lib.MainColor)

    dx9.DrawString({152, 11}, Lib.FontColor, " "..Lib.Watermark.Text)
end

function Lib:SetWatermarkVisibility(bool)
    Lib.Watermark.Visible = bool
end

function Lib:SetWatermark(text)
    Lib.Watermark.Text = text;
end

--// Rainbow Tick
do
    if Lib.RainbowHue >= 765 then
        Lib.RainbowHue = 0
    else
        Lib.RainbowHue = Lib.RainbowHue + 1
    end

    if Lib.RainbowHue <= 255 then
        Lib.CurrentRainbowColor = {255 - Lib.RainbowHue, Lib.RainbowHue, 0}
    elseif Lib.RainbowHue <= 510 then
        Lib.CurrentRainbowColor = {0, 510 - Lib.RainbowHue, Lib.RainbowHue - 255}
    else
        Lib.CurrentRainbowColor = {Lib.RainbowHue - 510, 0, 765 - Lib.RainbowHue}
    end
end



--[[
██╗   ██╗██╗    ████████╗███████╗███████╗████████╗██╗███╗   ██╗ ██████╗ 
██║   ██║██║    ╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝██║████╗  ██║██╔════╝ 
██║   ██║██║       ██║   █████╗  ███████╗   ██║   ██║██╔██╗ ██║██║  ███╗
██║   ██║██║       ██║   ██╔══╝  ╚════██║   ██║   ██║██║╚██╗██║██║   ██║
╚██████╔╝██║       ██║   ███████╗███████║   ██║   ██║██║ ╚████║╚██████╔╝
 ╚═════╝ ╚═╝       ╚═╝   ╚══════╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
]]



--[[ --// UI
Lib:SetWatermark("Watermark Text")

local Window = Lib:CreateWindow("Window Name")

local Tab1 = Window:AddTab("Tab 1", 50)
local Tab2 = Window:AddTab("Tab 2", 50)

local Groupbox1 = Tab1:AddLeftGroupbox("GroupBox 1") 
local Groupbox2 = Tab1:AddRightGroupbox("GroupBox 2")


Groupbox1:AddButton("Randomize Window Name", function()
    Window:SetWindowTitle("Random Title "..math.random(1000, 9999))
end)

local Toggle = Groupbox1:AddToggle("rgbtoggle", {Default = false, Text = "Toggle RGB UI"})

Toggle:OnChanged(function()
    Window:SetRGB(Toggle.Value)
end)

local Toggle2 = Groupbox2:AddToggle("watermarktoggle", {Default = true, Text = "Toggle Watermark"})

Toggle2:OnChanged(function()
    Lib:SetWatermarkVisibility(Toggle2.Value)
end)

local slider = Groupbox1:AddSlider("slider1", {Default = 0, Text = "Test Slider", Min = 1, Max = 100, Rounding = 0})
local slider2 = Groupbox1:AddSlider("slider2", {Default = 69, Text = "Second Slider", Min = 1, Max = 100, Rounding = 0})

Groupbox2:AddButton("Set Slider to 1%", function() 
    Window.Tools.slider1:SetValue(1)
end)

Groupbox2:AddButton("Set Slider to 100%", function() 
    slider:SetValue(100)
end)
 ]]





--[[
--// USEAGE //--

local Window1 = Lib:CreateWindow("Window Name")

Window1:SetRGB(true) -- Enables RGB Scheme
Window1:SetWindowTitle("New Name") -- Changes Window Name

local Tab1 = Window1:AddTab("Tab Name", tab_length)

]]



Log("FINISHED")
