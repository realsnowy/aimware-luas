function Sounds( Event, Entity )
	if ( Event:GetName() == 'player_hurt' ) then
		local ME = client.GetLocalPlayerIndex();
		
		local INT_UID = Event:GetInt( 'userid' );
		local INT_ATTACKER = Event:GetInt( 'attacker' );
		
		local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
		local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
		
		local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
		local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
		
		if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
			client.Command("playvol buttons\\arena_switch_press_02.wav 1", true);
		end
	end
	
	if ( Event:GetName() == 'player_death' ) then
	
		local ME = client.GetLocalPlayerIndex();
		
		local INT_UID = Event:GetInt( 'userid' );
		local INT_ATTACKER = Event:GetInt( 'attacker' );
		
		local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
		local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
		
		local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
		local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
		
		if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
			client.Command("playvol buttons\\light_power_on_switch_01.wav 1", true);
		end
	end
end

client.AllowListener( 'player_hurt' );
client.AllowListener( 'player_death' );
callbacks.Register( 'FireGameEvent', 'Hitsound', Sounds );
