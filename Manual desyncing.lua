local gui_set = gui.SetValue;
local gui_get = gui.GetValue;
local LeftKey = 0;
local RightKey = 0;
local rage_ref = gui.Reference("RAGE", "MAIN", "Anti-Aim Main");
local check_indicator = gui.Checkbox( rage_ref, "Enable", "Manual DESYNC", false)
local AntiAimleft = gui.Keybox(rage_ref, "Anti-Aim_left", "Left Keybind", 0);
local AntiAimRight = gui.Keybox(rage_ref, "Anti-Aim_Right", "Right Keybind", 0);
 
local rifk7_font = draw.CreateFont("Verdana", 20, 700)
local damage_font = draw.CreateFont("Verdana", 15, 700)
 
local arrow_font = draw.CreateFont("Tahoma", 45, 700)
local normal = draw.CreateFont("Arial")
 
local function main()
    if AntiAimleft:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimleft:GetValue()) then
            LeftKey = LeftKey + 1;
            RightKey = 0;
        end
    end
    if AntiAimRight:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimRight:GetValue()) then
            RightKey = RightKey + 1;
            LeftKey = 0;
        end
    end
	end
 
 
function CountCheck()
   if ( LeftKey == 1 ) then
        RightKey = 0;
    elseif ( RightKey == 1 ) then
        LeftKey = 0;
        BackKey = 0;
    elseif ( LeftKey == 2 ) then
        LeftKey = 0;
        RightKey = 0;
   elseif ( RightKey == 2 ) then
        LeftKey = 0;
        RightKey = 0;
   end        
end
 
function SetLeft()
   gui_set("rbot_antiaim_stand_desync", 2);
    gui_set("rbot_antiaim_move_desync", 2);
end
 
 
function SetRight()
   gui_set("rbot_antiaim_stand_desync", 3);
    gui_set("rbot_antiaim_move_desync", 3);
end
 
 
function draw_indicator()
 
    local active = check_indicator:GetValue()
 
    if active then
 
 
        local w, h = draw.GetScreenSize();
        draw.SetFont(rifk7_font)
        if (LeftKey == 1) then
            SetLeft();
            draw.Color(249, 0, 0, 255);
            draw.SetFont(arrow_font)
            draw.Text( w/2 - 100, h/2 - 21, "(");
            draw.TextShadow( w/2 - 100, h/2 - 21, "(");
            draw.Color(47, 54, 66, 255);
            draw.SetFont(arrow_font)
            draw.Text( w/2 + 100, h/2 - 21, ")");
            draw.TextShadow( w/2 + 100, h/2 - 21, ")");
            draw.SetFont(rifk7_font)
        elseif (RightKey == 1) then
            SetRight();
            draw.Color(249, 0, 0, 255);
            draw.SetFont(arrow_font)
            draw.Text( w/2 + 100, h/2 - 21, ")");
            draw.TextShadow( w/2 + 100, h/2 - 21, ")");
            draw.Color(47, 54, 66, 255);
            draw.SetFont(arrow_font)
            draw.Text( w/2 - 100, h/2 - 21, "(");
            draw.TextShadow( w/2 - 100, h/2 - 21, "(");
            draw.Color(47, 54, 66, 255);
        end
        draw.SetFont(normal)
    end
end
 
callbacks.Register( "Draw", "main", main);
callbacks.Register( "Draw", "CountCheck", CountCheck);
callbacks.Register( "Draw", "SetLeft", SetLeft);
callbacks.Register( "Draw", "SetRight", SetRight);
callbacks.Register( "Draw", "draw_indicator", draw_indicator);
