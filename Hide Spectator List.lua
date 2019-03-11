function hidespec()
if entities.GetLocalPlayer() ~= nil then
gui.SetValue("msc_showspec", 1) 
else
gui.SetValue("msc_showspec", 0) 
end end

callbacks.Register("Draw", "a", hidespec);
