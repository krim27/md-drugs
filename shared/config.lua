Config = {} --Ignore.

Config.oxtarget = true --- turn to true if you use oxtarget
Config.respawnTime = 150 -- Seconds
Config.Fuel = "Renewed-Fuel" -- type the name of script you use i.e. ps-fuel, cdn-fuel, LegacyFuel
Config.TierSystem = true -- allows for three tiers of certain drugs ( coke, heroin, crack, lsd)
Config.StupidassNewQbItemName = true -- true if you have updated your items.lua from base qb after november 2023 because changing item names this far in a framework is 3 IQ points total
Config.RequestModelTime = 30000 -- if you need more time than this, uhhhh wow

----------------------------------- TierSystem levels ** ONLY IN USE IF CONFIG.TIERSYTEM IS TRUE
Config.Tier1 = 100 -- amount to hit for level 2
Config.Tier2 = 300 -- amount to hit for level 3

---------------------------------- BRIDGE 
Config.progressbartype = 'oxcir' -- either 'qb', 'oxcir', 'oxbar'
Config.minigametype = 'ox' -- either 'ps' or 'ox' or 'none'
Config.Notify = 'ox' -- -- either 'qb' or 'ox' or 'okok'
Config.Phone = 'qb' -- either 'qb' or 'yflip' or 'qs'
Config.Dispatch = 'cd' -- either 'ps', 'cd', 'core', 'aty'

------------- you can either set a gang or leave it blank, if blank it will autopopulate data to not require it :)
------------- Cocaine -- new animations require to be in a certain spot or they get fucky. uses bob74 ipl if you turn Config.FancyCokeAnims you can put it anywhere :) 
Config.FancyCokeAnims = true -- if you want multi location this needs to be false

Config.CokeTeleIn = vector3(5137.7734375, -5123.6967773438, 2.9413630962372)-- where you target to go inside

Config.CokeTeleOut = vector3(1088.81, -3187.57, -38.99) -- where you target to leave

Config.MakePowder = { -- where you chop your coca leaves to make powder
    {loc = vector3(1086.20, -3195.30, -39.20), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}
Config.CuttingCoke = { -- only active if Config.FancyCokeAnims = false
    {loc = vector3(1095.66, -3195.4, -39.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}
Config.BaggingCoke = { -- only active if Config.FancyCokeAnims = false
    {loc = vector3(1100.34, -3199.44, -39.19), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}
---------------- Crack locations
Config.makecrack = { -- make crack with baking soda with cut coke 1-3
    {loc = vector3(5212.4892578125, -5125.904296875, 6.0086817741394), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.bagcrack = { ---  bag crack 1-3 stages
    {loc = vector3(5212.9262695312, -5130.9248046875, 6.0081081390381), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}
------------------------- LSD Locations
Config.lysergicacid = { -- get lysergic acid
    {loc = vector3(4926.4580078125, -5244.6723632812, 1.5189210176468), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    {loc = vector3(4924.4521484375, -5246.0708007812, 1.5189210176468), l = 1.0, w = 1.0, rot = 45.0, gang = ""},

}

Config.diethylamide = { -- get diethylamide
    {loc = vector3(4962.7270507812, -5106.5791015625, 2.9696220159531), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    {loc = vector3(4964.0698242188, -5109.3100585938, 2.9696220159531), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    {loc = vector3(4959.6337890625, -5107.0400390625, 2.9696220159531), l = 1.0, w = 1.0, rot = 45.0, gang = ""},

}

Config.gettabs = { -- buy tab paper
    {loc = vector3(5215.890625, -5129.7817382812, 6.3030982017517), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.buylsdlabkit = vector4(4956.3984375, -5321.4736328125, 8.4885377883911, 81.771034240723)--  buy lab kit
Config.tabcost = 100 -- price per piece of tab paper event does 10 at a time
Config.lsdlabkitcost = 10000 -- price of the lsd lab kit
------------------------- Heroin Locations

Config.dryplant = { -- turn resin into powder
    {loc = vector3(5133.1923828125, -4616.7294921875, 2.375616312027), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.cutheroinone = { -- cut heroin stage 1-3 with baking soda
    {loc = vector3(5131.6279296875, -4612.6728515625, 2.4604970216751), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.fillneedle = { -- fill needles with heroin
    {loc = vector3(5136.3349609375, -4613.8120117188, 2.4586030244827), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.buyheroinlabkit = vector4(4957.4155273438, -5315.4130859375, 8.497857093811, 79.387092590332) -- buy heroin lab kit
Config.heroinlabkitprice = 10000 -- price of the lsd lab kit

------------ XTC
Config.isosafrole = { -- where to steal isosafrole
    {loc = vector3(844.39, -902.92, 25.42), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.mdp2p = {  -- where to steal mdp2p
    {loc = vector3(844.4, -898.79, 25.23), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.rawxtcloc = { --  where to combine the 2 ingridents to make raw xtc
    {loc = vector3(844.71, -910.33, 25.37), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.stamp = { --  where to stamp pills
    {loc = vector3(844.71, -900.56, 25.43), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.buypress = vector3(845.82, -884.79, 25.18)--  Where you buy your presses

----- mescaline
Config.DryOut = vector3(2622.6, 4222.57, 43.6) -- Place to dry out mescaline into usuable drug
Config.Badtrip = 20 -- number means % chance to spawn a clone that chases and attacks while on mescaline


-------------- lean
Config.SyrupVendor = vector4(365.21, -578.77, 39.30, 347.23) -- where the mission ped starts

Config.StartLoc = {
    vector3(-2307.22, 434.77, 174.47), -- where the truck spawns
    vector3(614.75, 1786.26, 199.39),
    vector3(-224.89, 6388.32, 31.59)
}


---------- Pharma

Config.FillPrescription = {---------- this is where you want people to take their prescription to get a bottle of pills. They use bottle to get a random amount of prescription pills
    {loc = vector3(2432.89, 4252.2, 36.35), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

Config.PharmaJob = "ems" -- what TYPE role you need to be on to get the command


-------------- weed
Config.Teleout = vector3(1066.31, -3183.36, -39.16) -- where you target to tele in
Config.Telein = vector3(4954.498046875, -5107.5981445312, 3.8888311386108) -- where you target to tele out
Config.MakeButter = vector3(1045.48, -3198.49, -38.22) -- where you make cannabutter and baked edibles
Config.MakeOil = vector3(1038.90, -3198.66, -38.17) -- where you make shatter
Config.WeedSaleman = vector4(1030.46, -3203.63, -38.2, 180.0)

Config.WeedDry = { -- where you dry leaves 
    vector3(1038.8780517578, -3191.9577636719, -38.39),
    vector3(1040.0979003906, -3191.9577636719, -38.39),
    vector3(1041.4091796875, -3191.9577636719, -38.39),
    vector3(1042.4180908203, -3191.9577636719, -38.39),
    vector3(1043.5423583984, -3191.9577636719, -38.39),
    vector3(1044.7006835938, -3191.9184570312, -38.39),
    vector3(1045.640625, -3191.9421386719, -38.39),
    
}

Config.Joblock = false -- if you want weed to be a job
Config.weedjob = "" -- what the job name is
Config.Weed = { --- this is the store for the weed ingridients
    label = "Weed Shop",
    slots = 8,
    items = {
        {name = "weedgrinder", 	price = 25, 	amount = 50, },
		{name = "mdbutter", 	price = 25, 	amount = 50, },
		{name = "flour", 		price = 25, 	amount = 50, },
		{name = "chocolate",  	price = 25, 	amount = 50, },
		{name = "butane", 		price = 25, 	amount = 50, },
		{name = "butanetorch", 	price = 2, 		amount = 1000,},
		{name = "dabrig", 		price = 2, 		amount = 1000,},
		{name = "mdwoods", 		price = 2, 		amount = 1000,},	
	}
}

----------------- Wholesale
Config.SuccessfulChance = 90 --- this is the chance of a Success wholesale 1-100
Config.AlertPoliceWholesale = 90 -- 1-100 of how often it will alert police
Config.WholesaleTimeout = 0 -- time in seconds to get to the location
Config.PoliceCount = 0-- Amount of police required
Config.Wcoke =  { min = 20, max = 60} -- pricings per item
Config.Wcrack = { min = 20, max = 60}
Config.Wlsd = { min = 20, max = 60}
Config.WXTC = { min = 20, max = 60}


--- travelling merchant

Config.Travellingmerchant = { ------------ these are the random locations the merchant can spawn on script start. whatever you want for the merchant is in Config.Items right below
    vector4(5265.4526367188, -5418.78125, 65.59708404541, 230.43617248535),
    vector4(5273.5122070312, -5425.69140625, 65.59708404541, 56.710403442383),
    vector4(5270.4580078125, -5428.1840820312, 65.597114562988, 88.37092590332),
    vector4(5267.7075195312, -5429.310546875, 65.59708404541, 25.729537963867),
}
Config.Items = {
    categories = {
        ["Supplies"] = {
            icon = "fas fa-tools", -- Example icon for Supplies category
            items = {
                {name = "tab_paper", price = 50, amount = 50},
                {name = "bakingsoda", price = 25, amount = 50},
                {name = "isosafrole", price = 25, amount = 50},
                {name = "mdp2p", price = 25, amount = 50},
            }
        },
        ["Chemicals"] = {
            icon = "fas fa-tools", -- Example icon for Supplies category
            items = {
                {name = "lysergic_acid", price = 25, amount = 50},
                {name = "diethylamide", price = 25, amount = 50},
                {name = "empty_weed_bag", price = 2, amount = 1000},
                {name = "empty_crack_bag", price = 2, amount = 1000},
                {name = "empty_meth_bag", price = 2, amount = 1000},
                {name = "emptyvial", price = 2, amount = 1000},
            }
        },
        ["Tools"] = {
            icon = "fas fa-tools", -- Example icon for Supplies category
            items = {
                {name = "needle", price = 2, amount = 1000},
                {name = "cokeburner", price = 25, amount = 50},
                {name = "crackburner", price = 2, amount = 50},
                {name = "lsdburner", price = 2, amount = 50},
            }
        },
        ["Miscellaneous"] = {
            icon = "fas fa-tools", -- Example icon for Supplies category
            items = {
                {name = "heroinburner", price = 2, amount = 50},
                {name = "mdlean", price = 50, amount = 50},
                {name = "weedgrinder", price = 25, amount = 50},
                {name = "mdbutter", price = 25, amount = 50},
                {name = "flour", price = 25, amount = 50},
                {name = "chocolate", price = 25, amount = 50},
                {name = "butane", price = 25, amount = 50},
                {name = "butanetorch", price = 2, amount = 1000},
                {name = "dabrig", price = 2, amount = 1000},
                {name = "mdwoods", price = 2, amount = 1000},
                {name = "leancup", price = 25, amount = 50},
                {name = "xtcburner", price = 25, amount = 50},
            }
        },
        ["Tables"] = {
            icon = "fas fa-table", -- Example icon for Supplies category
            items = {
                {name = "lsdlabkit", price = 2, amount = 15000},
                {name = "heroinlabkit", price = 50, amount = 10000},
                {name = "weedlabkit", price = 25, amount = 1000},
            }
        }
    }
}

--------------------------------------- oxy runs
---- How oxyruns work. You pay for a truck, you get in it and it gives a route. There is a 20% chance that the car will be "hot" and you have to ditch it. No Routes will spawn if that pops up
----- when you get to the drop off point third eye the truck. You will carry a box to the ped. He will give you cash, some oxy and maybe a random item. Rinse and repeat


Config.truckspawn = vector4(1449.65, -1486.0, 63.22, 342.58) --- where the truck will spawn when you pay for it 
Config.Payfortruck = vector3(1437.64, -1491.91, 63.62) --- where you pay for the truck
Config.TruckPrice = 500 -- amount the truck will cost to rent
Config.OxyRunCompleteCash = 200 -- base price you get for completeing a run. 50% if the car needs to be ditched
Config.OxyRunDitchChance = 20 -- % of a fail mission and having to ditch the car and not get a new order
Config.OxyItemChance = 50 -- chance to recieve an item from the OxyRandItems list below 
Config.OxyItemAmount = 1 -- amount of the item you recieve when you get an item from OxyRandItems
Config.PoliceAlertOxy = 90 -- This is a % out of 100 to alert police

Config.oxylocations = { -- These are different locations where a ped spawns.
    vector4(-2352.32, 266.78, 165.3, 23.46),
    vector4(-1467.49, 874.01, 183.59, 298.45),
    vector4(-856.71, 874.26, 202.85, 205.3),
    vector4(950.58, -128.49, 74.42, 205.3),
    vector4(1152.71, -328.43, 69.21, 205.3),
	vector4(112.66, -1955.67, 20.75, 37.94),
	vector4(-544.4, -1684.8, 19.89, 252.07),
	vector4(-1185.02, -1805.4, 3.91, 184.83),
	vector4(-1641.4, -981.99, 7.58, 35.38),
	vector4(-1827.93, 782.36, 138.29, 219.99),
	vector4(-320.84, 2818.73, 59.45, 337.22),
	vector4(474.88, 2609.56, 44.48, 357.0),
}

Config.OxyRandItems = { -- random items you get for completing the mission
    "oxy",
    "lockpick",
    "cryptostick",
}


---------------------- Meth Config
Config.MethTeleIn = vector3(5095.2705078125, -4607.2075195312, 3.2549197673798) -- where you target to tele in
Config.MethTeleOut = vector3(996.91, -3200.83, -36.39) -- where you target to tele out
Config.MethHeist = false
Config.MethHeistStart = vector3(-1102.93, -3066.76, 14.00) -- where you get the mission to get ingridients if meth heist = true
Config.MethEph = {
    {loc = vector3(5000.4458007812, -5163.1728515625, 2.7560039758682), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}
Config.Methace = {
    {loc = vector3(5196.8701171875, -5133.8969726562, 3.3416209220886), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
}

----------------------------- these are the locations where props will be spawned to be picked 
Config.CocaPlant = {
    { location = vector3(5302.6518554688, -5189.5209960938, 19.304306411743),    heading = 334.49,     model = "prop_plant_01a" },
    { location = vector3(5305.7138671875, -5192.9458007812, 30.05358543396),     heading = 329.56,     model = "prop_plant_01a" }, 
    { location = vector3(5310.310546875, -5197.1352539062, 30.480686569214),       heading = 25.16,      model = "prop_plant_01a" }, 
    { location = vector3(5315.0678710938, -5201.6801757812, 30.556211853027),     heading = 21.52,      model = "prop_plant_01a" }, 
    { location = vector3(5322.0375976562, -5208.302734375, 30.642078781128),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5329.1450195312, -5215.1323242188, 30.727989578247),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5334.705078125, -5220.724609375, 30.851147079468),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5333.2075195312, -5222.7758789062, 30.99321975708),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5327.8588867188, -5217.3095703125, 30.864330673218),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5322.4204101562, -5212.01953125, 30.746151351929),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5318.0571289062, -5207.8427734375, 30.740816497803),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5312.9487304688, -5202.8725585938, 30.621393585205),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5307.5473632812, -5197.4462890625, 30.487539672852),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5301.046875, -5191.3920898438, 29.371130371094),     heading = 202.97,     model = "prop_plant_01a" },

    { location = vector3(5331.9223632812, -5225.26953125, 31.117227935791),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5327.6752929688, -5221.17578125, 31.120508575439),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5321.146484375, -5214.25390625, 30.845150375366),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5316.0546875, -5209.9184570312, 30.863914871216),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5310.982421875, -5204.6733398438, 30.68985786438),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5304.2827148438, -5198.7314453125, 30.457384490967),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5298.4423828125, -5192.7177734375, 29.215591812134),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5295.3125, -5196.5400390625, 29.293882751465),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5299.3686523438, -5200.3247070312, 30.170484924316),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5302.1635742188, -5203.2265625, 30.555250549316),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5306.7104492188, -5207.8129882812, 30.768591308594),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5311.1923828125, -5212.08203125, 30.982901000977),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5314.9291992188, -5215.484375, 31.015604400635),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5319.4721679688, -5219.8217773438, 31.00884475708),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5324.224609375, -5224.2993164062, 31.1956199646),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5328.5385742188, -5228.3583984375, 31.21436920166),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5327.193359375, -5230.6645507812, 31.236536407471),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5322.435546875, -5226.310546875, 31.240492248535),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5318.318359375, -5222.205078125, 31.109163665771),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5313.6284179688, -5217.7509765625, 31.116354370117),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5307.9731445312, -5212.1459960938, 30.954187774658),     heading = 202.97,     model = "prop_plant_01a" },

    { location = vector3(5303.482421875, -5207.8486328125, 30.700355911255),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5300.05859375, -5204.6025390625, 30.45474281311),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5295.6684570312, -5200.3291015625, 29.698921585083),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5291.8232421875, -5200.013671875, 29.037542724609),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5295.6469726562, -5203.8930664062, 29.909847640991),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5299.47265625, -5207.7719726562, 30.502712631226),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5303.328125, -5211.4858398438, 30.832147979736),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5307.8447265625, -5215.76953125, 31.167791748047),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5312.05859375, -5219.4716796875, 31.221815490723),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5315.4106445312, -5222.7358398438, 31.220487976074),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5318.9624023438, -5226.3139648438, 31.285234832764),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5323.4477539062, -5230.6723632812, 31.325323486328),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5325.376953125, -5232.9072265625, 31.346212768555),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5318.2631835938, -5232.4018554688, 31.561861419678),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5314.2314453125, -5228.6381835938, 31.498819732666),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5310.294921875, -5224.869140625, 31.418257141113),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5305.8784179688, -5220.5297851562, 31.357141876221),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5300.564453125, -5215.5732421875, 30.896683120728),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5296.2270507812, -5211.2763671875, 30.330637359619),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5292.9853515625, -5208.189453125, 29.766828918457),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(5288.4965820312, -5204.015625, 28.606016540527),     heading = 202.97,     model = "prop_plant_01a" },

}

Config.WeedPlant = {
    { location = vector3(1049.63, -3202.12, -39.15),    heading = 334.49,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.85, -3202.15, -39.15),    heading = 329.56,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.01, -3202.22, -39.13),    heading = 25.16,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.99, -3202.15, -39.15),    heading = 21.52,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.08, -3201.11, -39.13),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.91, -3199.99, -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.02, -3198.97, -39.11),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.95, -3198.93, -39.11),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.96, -3199.86, -39.12),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.93, -3201.17, -39.12),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.98, -3201.13, -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.89, -3200.07, -39.12),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.89, -3198.95, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.72, -3198.95, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.98, -3200.1,  -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.82, -3201.01, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.07, -3194.51, -39.15),    heading = 334.49,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.97, -3195.55, -39.15),    heading = 329.56,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.82, -3196.58, -39.15),    heading = 25.16,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.94, -3197.59, -39.15),    heading = 21.52,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.92, -3197.54, -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.88, -3196.61, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.82, -3195.52, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.95, -3194.38, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.88, -3194.31, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.78, -3195.29, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.76, -3196.49, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.77, -3197.62, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.64, -3197.61, -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.64, -3196.59, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.62, -3195.51, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.66, -3194.36, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},

    { location = vector3(1049.822021484375, -3207.239990234375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.9901123046875, -3207.27734375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.1343994140625, -3207.29541015625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.324462890625, -3207.225341796875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.3887939453125, -3206.060791015625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.867919921875, -3206.323974609375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.1156005859375, -3206.100341796875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.124267578125, -3206.233154296875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.966064453125, -3205.183349609375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.897216796875, -3205.19677734375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.2203369140625, -3205.1435546875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.2662353515625, -3205.119140625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.4124755859375, -3204.10546875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.4058837890625, -3204.04638671875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.910400390625, -3203.91845703125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.9676513671875, -3203.879150390625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},

    { location = vector3(1056.3638916015625, -3204.62744140625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1055.1378173828125, -3204.55712890625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1059.8094482421875, -3207.55224609375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1058.6412353515625, -3207.512939453125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.49951171875, -3207.460205078125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.3214111328125, -3207.333740234375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1055.0546875, -3207.291748046875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1054.926025390625, -3205.81787109375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.3385009765625, -3205.95166015625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.6214599609375, -3206.045166015625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1058.810302734375, -3206.1123046875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1059.901123046875, -3206.289306640625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1060.0142822265625, -3204.830078125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.7276611328125, -3204.795654296875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1058.86767578125, -3204.828857421875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},

    { location = vector3(1064.6993408203125, -3206.545654296875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.7269287109375, -3205.447021484375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.81640625, -3204.067626953125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.781494140625, -3202.713134765625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.8494873046875, -3201.531982421875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.38037109375, -3201.509521484375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.2974853515625, -3202.658935546875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.4078369140625, -3204.05078125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.4263916015625, -3205.206298828125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.4266357421875, -3206.423583984375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.10791015625, -3206.417236328125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.114990234375, -3205.14990234375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.17626953125, -3204.04443359375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.0491943359375, -3202.732666015625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.16015625, -3201.48291015625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},

    { location = vector3(1058.8536376953125, -3197.483642578125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1058.6407470703125, -3198.7001953125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1058.6597900390625, -3199.952880859375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1058.5205078125, -3201.18212890625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1058.4501953125, -3202.35107421875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.9869384765625, -3202.248046875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.1719970703125, -3201.182861328125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.24560546875, -3199.9345703125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.3621826171875, -3198.660888671875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.509521484375, -3197.432373046875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.040283203125, -3197.374267578125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.0570068359375, -3198.48291015625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.0006103515625, -3199.75830078125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1055.8624267578125, -3200.9716796875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1055.766845703125, -3202.1474609375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},

    { location = vector3(1050.0692138671875, -3192.95361328125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.1173095703125, -3191.818603515625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.118408203125, -3190.551513671875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.1739501953125, -3189.155517578125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.25, -3187.876953125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.8359375, -3187.929931640625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.710693359375, -3189.2333984375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.657470703125, -3190.51123046875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.59326171875, -3191.72314453125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.4185791015625, -3192.988037109375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.70703125, -3192.99365234375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.7037353515625, -3191.779052734375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.8226318359375, -3190.574951171875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.8800048828125, -3189.302734375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.951171875, -3188.047607421875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},

    { location = vector3(1054.770263671875, -3191.447509765625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1054.75732421875, -3190.335205078125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1054.8323974609375, -3189.218505859375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1054.8541259765625, -3188.037109375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1055.8951416015625, -3191.452880859375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1055.888427734375, -3190.386474609375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1055.8861083984375, -3189.33154296875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1055.9161376953125, -3188.147216796875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.9627685546875, -3190.380615234375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.9937744140625, -3188.190673828125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.9652099609375, -3189.380126953125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.9818115234375, -3190.354736328125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1056.9456787109375, -3191.481201171875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.9991455078125, -3191.4814453125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.9791259765625, -3189.3232421875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1057.9761962890625, -3188.171630859375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},

    { location = vector3(1064.79541015625, -3199.800537109375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.800537109375, -3198.658447265625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.864013671875, -3198.697509765625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.7364501953125, -3199.823486328125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.7957763671875, -3197.705322265625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.7972412109375, -3196.509521484375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.87841796875, -3197.699951171875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.93408203125, -3196.56103515625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.8060302734375, -3196.557861328125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.752197265625, -3197.70361328125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.65625, -3198.765380859375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.5694580078125, -3199.74560546875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.6226806640625, -3199.728271484375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.5799560546875, -3198.6630859375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.675, -3197.498, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.8023681640625, -3196.412841796875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},

    { location = vector3(1062.4697265625, -3192.94140625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.5438232421875, -3192.880615234375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.5694580078125, -3191.785888671875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.6387939453125, -3193.98828125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.5478515625, -3195.06298828125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.5692138671875, -3194.01953125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.6063232421875, -3195.069091796875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.5311279296875, -3192.85009765625, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.5113525390625, -3191.81591796875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.453125, -3195.08349609375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.5791015625, -3194.046630859375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.3590087890625, -3191.83984375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.3763427734375, -3193.94091796875, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.3765869140625, -3192.936767578125, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.254150390625, -3191.95458984375, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.26, -3195.049, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
}


Config.PoppyPlants = {
    { location = vector3(5450.4423828125, -5954.181640625, 14.932999801636),    heading = 334.49,    model = "prop_plant_01b"},
    { location = vector3(5446.8286132812, -5945.376953125, 14.895823669434),    heading = 329.56,    model = "prop_plant_01b"},
    { location = vector3(5454.9970703125, -5936.2080078125, 15.903340530396),    heading = 25.16,     model = "prop_plant_01b"},
    { location = vector3(5463.7592773438, -5934.8510742188, 15.72845954895),   heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(5454.5922851562, -5927.7099609375, 16.297562789917),   heading = 334.49,    model = "prop_plant_01b"},
    { location = vector3(5452.3637695312, -5917.5673828125, 16.53812713623),    heading = 329.56,    model = "prop_plant_01b"},
    { location = vector3(5463.3374023438, -5919.068359375, 18.392663192749),   heading = 25.16,     model = "prop_plant_01b"},
    { location = vector3(5473.7241210938, -5921.7524414062, 16.508855056763),   heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(5482.2768554688, -5911.251953125, 14.068372917175),   heading = 334.49,    model = "prop_plant_01b"},
    { location = vector3(5493.2734375, -5905.3833007812, 14.521575164795),   heading = 329.56,    model = "prop_plant_01b"},
    { location = vector3(5491.4711914062, -5899.0219726562, 15.817477416992),   heading = 25.16,     model = "prop_plant_01b"},
    { location = vector3(5491.4711914062, -5899.0219726562, 15.817477416992),   heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(5476.5751953125, -5886.8588867188, 17.923363876343),    heading = 21.52,     model = "prop_plant_01b"},

    { location = vector3(5471.58203125, -5885.21484375, 19.299332809448),    heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(5464.2719726562, -5881.0805664062, 20.507037353516),    heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(5457.2084960938, -5877.8881835938, 20.730128479004),    heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(5449.9721679688, -5873.1533203125, 20.578480911255),    heading = 21.52,     model = "prop_plant_01b"},
}

Config.shrooms = {
    { location = vector3(2185.14, 5183.81, 57.48),    heading = 334.49,    model = "mushroom"},
    { location = vector3(2174.45, 5187.85, 57.43),    heading = 329.56,    model = "mushroom"},
    { location = vector3(2166.22, 5196.56, 58.0),     heading = 25.16,     model = "mushroom"},
    { location = vector3(2166.82, 5204.83, 58.63),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2174.84, 5205.82, 59.19),    heading = 334.49,    model = "mushroom"},
    { location = vector3(2184.46, 5201.23, 59.2),     heading = 329.56,    model = "mushroom"},
    { location = vector3(2192.45, 5194.89, 58.86),    heading = 25.16,     model = "mushroom"},
    { location = vector3(2207.53, 5187.81, 58.95),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2213.46, 5191.11, 59.81),    heading = 334.49,    model = "mushroom"},
    { location = vector3(2218.31, 5180.0, 58.18),     heading = 329.56,    model = "mushroom"},
    { location = vector3(2212.75, 5172.35, 57.2),     heading = 25.16,     model = "mushroom"},
    { location = vector3(2208.56, 5167.06, 56.34),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2196.9, 5158.59, 54.84),     heading = 21.52,     model = "mushroom"},
    { location = vector3(2191.62, 5174.91, 56.68),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2190.18, 5182.54, 57.47),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2185.85, 5190.49, 58.1),     heading = 21.52,     model = "mushroom"},
    { location = vector3(2179.95, 5194.19, 58.26),    heading = 21.52,     model = "mushroom"},
}

Config.Mescaline = {
    { location = vector3(2598.73, 4207.89, 41.02),    heading = 334.49,    model = "prop_cactus_03"},
    { location = vector3(2601.46, 4199.34, 40.62),    heading = 329.56,    model = "prop_cactus_03"},
    { location = vector3(2611.63, 4194.18, 41.18),    heading = 25.16,     model = "prop_cactus_03"},
    { location = vector3(2620.18, 4202.69, 41.5),     heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2624.26, 4211.75, 42.34),    heading = 334.49,    model = "prop_cactus_03"},
    { location = vector3(2635.21, 4207.5, 42.49),     heading = 329.56,    model = "prop_cactus_03"},
    { location = vector3(2644.97, 4193.51, 42.11),    heading = 25.16,     model = "prop_cactus_03"},
    { location = vector3(2654.21, 4195.31, 41.23),    heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2653.32, 4206.49, 41.62),    heading = 334.49,    model = "prop_cactus_03"},
    { location = vector3(2647.45, 4213.94, 42.49),    heading = 329.56,    model = "prop_cactus_03"},
    { location = vector3(2636.3, 4218.49, 43.03),     heading = 25.16,     model = "prop_cactus_03"},
    { location = vector3(2627.37, 4223.2, 42.88),     heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2617.86, 4230.38, 42.63),    heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2609.8, 4222.12, 41.19),     heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2602.96, 4194.05, 41.01),    heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2614.39, 4188.3, 41.68),     heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2623.82, 4189.97, 41.44),    heading = 21.52,     model = "prop_cactus_03"},
}

