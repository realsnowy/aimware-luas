--Ragdoll Manipulation by Cheeseot
local ragdollref = gui.Reference("Misc", "General", "Main")
local ragdollwindowactive = gui.Checkbox(ragdollref, "lua_ragdollwindowtoggle", "Ragdoll manipulation", 0)
local ragdollwindow = gui.Window("lua_ragdolls", "Ragdoll manipulation", 250,250,390,300);
local pushbox = gui.Groupbox( ragdollwindow, "Push Scale", 10, 10, 180, 120 )
local pushslider = gui.Slider(pushbox, "lua_pushscale", "Base value", 1, 0, 10)
local pushmult = gui.Checkbox(pushbox, "lua_pushmult", "10x multiplier", 0)
local pushneg = gui.Checkbox(pushbox, "lua_pushneg", "Negative", 0)
local hsbox = gui.Groupbox( ragdollwindow, "Headshot Scale", 200, 10, 180, 120 )
local hsslider = gui.Slider(hsbox, "lua_hsscale", "Base value", 1.3, 0, 10)
local hsmult = gui.Checkbox(hsbox, "lua_hsmult", "10x multiplier", 0)
local hsneg = gui.Checkbox(hsbox, "lua_hsneg", "Negative", 0)
local gravbox = gui.Groupbox( ragdollwindow, "Gravity", 10, 140, 180, 120 )
local gravslider = gui.Slider(gravbox, "lua_grav", "Base value", 600, 0, 1000)
local gravmult = gui.Checkbox(gravbox, "lua_gravmult", "10x multiplier", 0)
local gravneg = gui.Checkbox(gravbox, "lua_gravneg", "Negative", 0)
local miscbox = gui.Groupbox( ragdollwindow, "Info", 200, 140, 180, 120 )
local pushtext = gui.Text(miscbox,"Push scale: ERR")
local hstext = gui.Text(miscbox,"Headshot scale: ERR")
local gravtext = gui.Text(miscbox,"Gravity: ERR")
local resetcheck = gui.Checkbox(miscbox, "lua_resetbutton", "Reset to default", 0)
local pushfinal = 0
local hsfinal = 0
local gravfinal = 0
local windowdrawn = 0
local makewindow = 0
local pushchange = 0
local hschange = 0
local gravchange = 0

--Ragdoll Manipulation by Cheeseot

function ragdollmeme()
makewindow = ragdollwindowactive:GetValue()
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
            windowdrawn = not windowdrawn;
    end

    if (makewindow and windowdrawn) then
            ragdollwindow:SetActive(1);
        else
            ragdollwindow:SetActive(0);
    end

pushfinal = pushslider:GetValue();
pushfinal = round(pushfinal, 1);

    if pushmult:GetValue() then
        pushfinal = pushfinal * 10;
    end
    
    if pushneg:GetValue() then
        pushfinal = pushfinal * -1;
    end
    
    if pushfinal == -0.0 then pushfinal = 0.0 end

hsfinal = hsslider:GetValue();
hsfinal = round(hsfinal, 1);

    if hsmult:GetValue() then
        hsfinal = hsfinal * 10;
    end
    
    if hsneg:GetValue() then
        hsfinal = hsfinal * -1;
    end
    
    if hsfinal == -0.0 then hsfinal = 0.0 end

gravfinal = gravslider:GetValue();
gravfinal = round(gravfinal, 1);

    if gravmult:GetValue() then
        gravfinal = gravfinal * 10;
    end
    
    if gravneg:GetValue() then
        gravfinal = gravfinal * -1;
    end
    
    if gravfinal == -0.0 then gravfinal = 0.0 end

    if resetcheck:GetValue() then
        pushslider:SetValue(1);
        pushmult:SetValue(0);
        pushneg:SetValue(0);
        hsslider:SetValue(1.3);
        hsmult:SetValue(0);
        hsneg:SetValue(0);
        gravslider:SetValue(600);
        gravmult:SetValue(0);
        gravneg:SetValue(0);
        resetcheck:SetValue(0);
    end

if pushchange ~= pushfinal then
    client.SetConVar("phys_pushscale", pushfinal, true );
    pushchange = pushfinal;
end

if hschange ~= hsfinal then
    client.SetConVar("phys_headshotscale", hsfinal, true );
    hschange = hsfinal;
end

if gravchange ~= gravfinal then
    client.SetConVar("cl_ragdoll_gravity", gravfinal, true );
    gravchange = gravfinal;
end

local pushtextmeme = "Push scale: " .. pushfinal;
pushtext:SetText(pushtextmeme);
local hstextmeme = "Headshot scale: " .. hsfinal;
hstext:SetText(hstextmeme);
local gravtextmeme = "Gravity: " .. gravfinal;
gravtext:SetText(gravtextmeme);
end

function round(num, numDecimalPlaces)
 local mult = 10^(numDecimalPlaces or 0)
 return math.floor(num * mult + 0.5) / mult
end

callbacks.Register("Draw","ragdollmeme",ragdollmeme)
--Ragdoll Manipulation by Cheeseot
