local c_reg = callbacks.Register
local c_var = client.SetConVar

function PostProcess()
    c_var("mat_postprocess_enable", 0, true)
end

c_reg("Draw", "PostProcess", PostProcess)
