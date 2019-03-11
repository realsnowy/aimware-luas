local totalDamage = {}
local totalKills = {}
local totalSuicides = {}
local names = {}

local lastServerIP, lastMapName

local x = 20;
local y = 350;

function getTeamNumberByPlayerIndex(index)
    local player = entities.GetByIndex(index)
    if (player == nil) then return end
    return player:GetTeamNumber()
end

local function OnDraw()
    if (input.IsButtonDown(9) == false) then return end
    local listY = 28
    local listItemHigh = 21
    local w = 224;
    
    local n = 0;
    for index, name in pairs(names) do
        if (entities.GetByIndex(attackerIndex) ~= nil and (totalDamage[index] ~= 0 or totalKills[index] ~= 0 or totalSuicides[index] ~= 0)) then
            draw.Color(gui.GetValue("clr_gui_groupbox_background"))
            draw.FilledRect(x, y+listY+listItemHigh*n, x+w, y+listY+listItemHigh*(1+n)-1)
            draw.Color(gui.GetValue("clr_gui_text2"))
            draw.SetFont(draw.CreateFont("Lucida Console", 14));
            local formatedName = name
            if (string.len(name) > 16) then
                formatedName = string.sub(name, 0, 15) .. ">"
            end
            draw.Text( x+7, y+listY+listItemHigh*n+3, string.format("%3d %1d %1d %s", totalDamage[index], totalKills[index], totalSuicides[index], formatedName));
            draw.Color(gui.GetValue("clr_gui_window_background"))
            draw.Line(x, y+listY+listItemHigh*(1+n)-1, x+w, y+listY+listItemHigh*(1+n)-1)
            n = n + 1
        end
    end
    -- if n > 0 then 
        local h = listY+listItemHigh*n
        draw.Color(gui.GetValue("clr_gui_window_header"))
        draw.FilledRect(x, y, x+w, y+24)
        draw.Color(18,18,18,100)
        draw.OutlinedRect(x, y, x+w, y+h+4)
        draw.Color(gui.GetValue("clr_gui_window_header_tab2"))
        draw.FilledRect(x, y+24, x+w, y+28)
        draw.Color(gui.GetValue("clr_gui_window_footer"))
        draw.FilledRect(x, y+h, x+w, y+h+4)
        draw.Color(gui.GetValue("clr_gui_text1"))
        draw.SetFont(draw.CreateFont("Lucida Console", 14));
        draw.Text( x+7, y+5, "  D K S Player" );
    -- end
end

function gameEventHandler(event)
    local eName = event:GetName()
    if(eName == "player_hurt" or eName == "player_death") then
        local victimIndex = client.GetPlayerIndexByUserID(event:GetInt('userid'))
        local attackerIndex
        if (event:GetInt('attacker') == 0) then
            if (event:GetString('weapon') ~= "worldspawn" or event:GetString('weapon') ~= "trigger_hurt") then
                attackerIndex = victimIndex
            end
        else
            attackerIndex = client.GetPlayerIndexByUserID(event:GetInt('attacker'))
        end
        if (attackerIndex == nil or victimIndex == nil) then
            return
        end
        if (totalDamage[attackerIndex] == nil) then 
            totalDamage[attackerIndex] = 0
        end
        if (totalKills[attackerIndex] == nil) then 
                    totalKills[attackerIndex] = 0
        end
        if (totalSuicides[attackerIndex] == nil) then 
            totalSuicides[attackerIndex] = 0
        end
        if (names[attackerIndex] == nil) then 
            names[attackerIndex] = client.GetPlayerNameByIndex(attackerIndex)
        end
        if (attackerIndex == victimIndex and eName == "player_death") then
            totalSuicides[attackerIndex] = totalSuicides[attackerIndex] + 1;
        end
        
        local attackerTeamNumber = getTeamNumberByPlayerIndex(attackerIndex)
        local victimTeamNumber = getTeamNumberByPlayerIndex(victimIndex)
        
        if (attackerIndex ~= victimIndex and attackerTeamNumber == victimTeamNumber) then
            if (eName == "player_hurt") then
                local teamDamage = event:GetInt('dmg_health')
                totalDamage[attackerIndex] = totalDamage[attackerIndex] + teamDamage
            end
            if (eName == "player_death") then
                totalKills[attackerIndex] = totalKills[attackerIndex] + 1
            end
            
        end
    elseif (eName == "round_announce_match_start" or (eName == "round_start" and lastServerIP ~= engine.GetServerIP() and lastMapName ~= engine.GetMapName())) then
        totalDamage = {}
        totalKills = {}
        totalSuicides = {}
        names = {}
        
        lastServerIP = engine.GetServerIP()
        lastMapName = engine.GetMapName()
    end
end

client.AllowListener('player_death');
client.AllowListener('round_announce_match_start');
callbacks.Register("FireGameEvent", gameEventHandler);
callbacks.Register("Draw", "TeamkillGui", OnDraw);
