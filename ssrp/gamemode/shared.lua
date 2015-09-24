-- TODO: Rewrite this whole file

GM.Name = "SSRP"
GM.Author = "Frank Paschen & Pedro Safi"
GM.Website = "https://berniesanders.com/"

DeriveGamemode( "sandbox" )

function GM:Initialize( )
	print( "[SSRP] Initializing SSRP v " .. "nil" .. "...")
end

function GM:PhysgunPickup( ply, ent )
	if (ent:GetClass() == "func_door" or ent:GetClass() == "prop_door_rotating" or ent:GetClass() == "func_door_rotating") then
		return false
	end
	return true;
end

function GM:GravGunPunt( ply,  ent )
	if !ply:IsUserGroup("superadmin") then
		return false
	else
		return true
	end
end

-- Money System
SSRP = {}
local Player = FindMetaTable("Player")
if !Player then return end

function Player:GetMoney()
        return self:GetNWInt("money")
end
 
function Player:CanAfford(num)
        return (self:GetMoney()-num) >= 0 -- true or false
end
 
if SERVER then
        util.AddNetworkString("ply_Money")
        function Player:SetMoney(num)
                self:SetNWInt("money", num)
        end
       
        function Player:AddMoney(num)
                self:SetNWInt("money", self:GetMoney()+num)
        end
		
		function Player:TakeMoney(num)
				self:SetNWInt("money", self:GetMoney()-num)
		end
 
        local mysql_hostname = '' -- Your MySQL server address.
        local mysql_username = '' -- Your MySQL username.
        local mysql_password = '' -- Your MySQL password.
        local mysql_database = '' -- Your MySQL database.
        local mysql_port = 3306 -- Your MySQL port. Most likely is 3306.
        local startoutmoney = 20000 -- Money to start out with.
		
		require('mysqloo')

		local db = mysqloo.connect(mysql_hostname, mysql_username, mysql_password, mysql_database, mysql_port)
        local queue = {}
        SSRP.Logs = {}
 
        function SSRP.AddLog( log )
                SSRP.Logs[#SSRP.Logs+1] = {os.date(), "[SSRP Logger]: "..log}
                ServerLog("[SSRP Logger]: "..log.."\n")
        end
 
        concommand.Add( "ssrp_logs", function( ply, cmd, args )
                if IsValid(ply) then return end
                print("SSRP Logs:")
                for i=1,#SSRP.Logs do
                        print(unpack(SSRP.Logs[i]))
                end
        end )
 
        function SSRP.Query( str, callback )
                local q = db:query( str )
               
                if not q then
                        table.insert( queue, { str, callback } )
                        db:connect()
                        return
                end
               
                function q:onSuccess( data )
                        callback( data )
                end
               
                function q:onError( err )
                        if db:status() ~= mysqloo.DATABASE_CONNECTED then
                                table.insert( queue, { str, callback } )
                                db:connect()
                                return
                        end
                       
                        SSRP.AddLog("[SSRP] Error! Query failed: " .. err )
                end
               
                q:start();
                q:wait();
        end
 
        function db:onConnected()
                SSRP.AddLog('[SSRP] Connected!')
				for k, ply in pairs( player.GetAll() ) do
					ply:ChatPrint( "[SSRP] Database connection successful!" )
				end
               
                for k, v in pairs( queue ) do
                        SSRP.Query( v[ 1 ], v[ 2 ] )
                end
                queue = {}
        end
 
        function db:onConnectionFailed(err)
                SSRP.AddLog('[SSRP] Connection Failed, please check your settings: ' .. err)
        end
 
        db:connect()
        db:wait()
       
        function SSRP.GetMoneyForPlayer( ply )
                SSRP.Query("SELECT money FROM `players` WHERE steamid = '" .. ply:SteamID() .. "'", function(data)
                        if data and data[1] then
                                ply:SetNWInt("money", data[1].money)
                        else
                                ply:SetNWInt("money", startoutmoney)
                        end
                end)
        end
 
        function SSRP.SaveMoneyForPlayer( ply )
                if not IsValid(ply) then return end
                SSRP.Query("INSERT INTO `players` (steamid, name, money) VALUES ('" .. ply:SteamID() .. "', '" .. ply:Nick() .. "', '" .. ply:GetMoney() .. "') ON DUPLICATE KEY UPDATE name = VALUES(name), money = VALUES(money)", function() end)
        end
		
		-- We're not gonna use networkedints 
		function SSRP.GetJobFromTable( ply )
			if not IsValid(ply) then return end
			
			local job_id = 0
			
			SSRP.Query("SELECT `job` FROM `players` WHERE `steamid` = '" .. ply:SteamID() .. "'", function(data)
				job_id = data[1].job
			end)
			
			return job_id
		end
 
        --[[DELETE UNTIL THE NEXT NOTICE AFTER USING THE SSRP_CREATETABLE COMMAND!
        function SSRP.CreateTable( ply, command, args )
                SSRP.Query("CREATE TABLE IF NOT EXISTS `players` ( `steamid` varchar(30) NOT NULL, `name` varchar(255) NOT NULL, `money` int(11) DEFAULT NULL `job` int(2) NOT NULL DEFAULT 1, PRIMARY KEY (`steamid`) )", function(data)
                        SSRP.AddLog("[SSRP] Successfully created the table. Please don't forget to delete this command!")
                end)
        end
        concommand.Add( "ssrp_createtable", SSRP.CreateTable )
        --DELETION STOPS HERE]]
       
        function SSRP.InitiatePlayerData( ply )
                SSRP.GetMoneyForPlayer( ply )
        end      
        hook.Add( "PlayerInitialSpawn", "SSRP.InitiatePlayerData", SSRP.InitiatePlayerData )
 
        function SSRP.SaveAllPlayers()
            for k,v in pairs(player.GetHumans()) do
                SSRP.SaveMoneyForPlayer(v)
            end
			SSRP.AddLog("[SSRP] Syncing userdata with the database...\n")
        end
       
	    timer.Create( "failsafe", 300, 0, SSRP.SaveAllPlayers )
	   
        --Hooks
        hook.Add( "ShutDown", "SSRP.SaveAllPlayers", SSRP.SaveAllPlayers )
        hook.Add( "PlayerDisconnected", "SSRP.SaveMoneyForPlayer", SSRP.SaveMoneyForPlayer )
end