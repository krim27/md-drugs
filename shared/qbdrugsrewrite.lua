QBConfig = {}
-----------  qb-drugs update built in here below
----------- Everything is now a target and not displaytext. Dealers are no longer just doors, they will spawn peds where you place your dealer. This is a literally qb-drugs with SLIGHT edits. mainly added peds for deliveries, made everything a target
------------ and changed the range a ped will walk up to you to be a bigger radius. 

QBConfig.MinimumDrugSalePolice = 0
QBConfig.MarkedBills = false -- if false on both options below then it auto converts selling to give cash
QBConfig.CustomDirtyMoney = false
QBConfig.CustomDirtyMoneyitem = ''

QBConfig.DrugsPrice = {
    -- base qb
    ["weed_white-widow"] =          {min = 15, max = 24 },
    ["weed_og-kush"] =              {min = 15, max = 28},
    ["weed_skunk"] =                {min = 15, max = 31 },
    ["weed_amnesia"] =              {min = 18, max = 34},
    ["weed_purple-haze"] =          {min = 18, max = 37},
    ["weed_ak47"] =                 {min = 18, max = 40},
    ["crack_baggy"] =               {min = 18, max = 34},
    ["cokebaggy"] =                 {min = 18, max = 37},
    -- coke
    ["cokebaggystagetwo"] =         {min = 18, max = 40},
	["cokebaggystagethree"] =       {min = 18, max = 40},
    -- heroin 
	["heroin_ready"] =              {min = 18, max = 40},
	["heroin_readystagetwo"] =      {min = 18, max = 40},
	["heroin_readystagethree"] =    {min = 18, max = 40},
    -- crack
	["baggedcracked"] =             {min = 18, max = 40},
	["baggedcrackedstagetwo"] =     {min = 18, max = 40},
	["baggedcrackedstagethree"] =   {min = 18, max = 40},
    -- xtc 
	["white_playboys"] =            {min = 18, max = 40},
	["white_playboys2"] =           {min = 18, max = 40},
	["white_playboys3"] =           {min = 18, max = 40},
	["white_playboys4"] =           {min = 18, max = 40},
	["blue_playboys"] =             {min = 18, max = 40},
	["blue_playboys2"] =            {min = 18, max = 40},
	["blue_playboys3"] =            {min = 18, max = 40},
	["blue_playboys4"] =            {min = 18, max = 40},
	["red_playboys"] =              {min = 18, max = 40},
	["red_playboys2"] =             {min = 18, max = 40},
	["red_playboys3"] =             {min = 18, max = 40},
	["red_playboys4"] =             {min = 18, max = 40},
	["orange_playboys"] =           {min = 18, max = 40},
	["orange_playboys2"] =          {min = 18, max = 40},
	["orange_playboys3"] =          {min = 18, max = 40},
	["orange_playboys4"] =          {min = 18, max = 40},
	["white_aliens"] =              {min = 18, max = 40},
	["white_aliens2"] =             {min = 18, max = 40},
	["white_aliens3"] =             {min = 18, max = 40},
	["white_aliens4"] =             {min = 18, max = 40},
	["blue_aliens"] =               {min = 18, max = 40},
	["blue_aliens2"] =              {min = 18, max = 40},
	["blue_aliens3"] =              {min = 18, max = 40},
	["blue_aliens4"] =              {min = 18, max = 40},
	["red_aliens"] =                {min = 18, max = 40},
	["red_aliens2"] =               {min = 18, max = 40},
	["red_aliens3"] =               {min = 18, max = 40},
	["red_aliens4"] =               {min = 18, max = 40},
	["orange_aliens"] =             {min = 18, max = 40},
	["orange_aliens2"] =            {min = 18, max = 40},
	["orange_aliens3"] =            {min = 18, max = 40},
	["orange_aliens4"] =            {min = 18, max = 40},
	["white_pl"] =                  {min = 18, max = 40},
	["white_pl2"] =                 {min = 18, max = 40},
	["white_pl3"] =                 {min = 18, max = 40},
	["white_pl4"] =                 {min = 18, max = 40},
	["blue_pl"] =                   {min = 18, max = 40},
	["blue_pl2"] =                  {min = 18, max = 40},
	["blue_pl3"] =                  {min = 18, max = 40},
	["blue_pl4"] =                  {min = 18, max = 40},
	["red_pl"] =                    {min = 18, max = 40},
	["red_pl2"] =                   {min = 18, max = 40},
	["red_pl3"] =                   {min = 18, max = 40},
	["red_pl4"] =                   {min = 18, max = 40},
	["orange_pl"] =                 {min = 18, max = 40},
	["orange_pl2"] =                {min = 18, max = 40},
	["orange_pl3"] =                {min = 18, max = 40},
	["orange_pl4"] =                {min = 18, max = 40},
	["white_trolls"] =              {min = 18, max = 40},
	["white_trolls2"] =             {min = 18, max = 40},
	["white_trolls3"] =             {min = 18, max = 40},
	["white_trolls4"] =             {min = 18, max = 40},
	["blue_trolls"] =               {min = 18, max = 40},
	["blue_trolls2"] =              {min = 18, max = 40},
	["blue_trolls3"] =              {min = 18, max = 40},
	["blue_trolls4"] =              {min = 18, max = 40},
	["red_trolls"] =                {min = 18, max = 40},
	["red_trolls2"] =               {min = 18, max = 40},
	["red_trolls3"] =               {min = 18, max = 40},
	["red_trolls4"] =               {min = 18, max = 40},
	["orange_trolls"] =             {min = 18, max = 40},
	["orange_trolls2"] =            {min = 18, max = 40},
	["orange_trolls3"] =            {min = 18, max = 40},
	["orange_trolls4"] =            {min = 18, max = 40},
	["white_cats"] =                {min = 18, max = 40},
	["white_cats2"] =               {min = 18, max = 40},
	["white_cats3"] =               {min = 18, max = 40},
	["white_cats4"] =               {min = 18, max = 40},
	["blue_cats"] =                 {min = 18, max = 40},
	["blue_cats2"] =                {min = 18, max = 40},
	["blue_cats3"] =                {min = 18, max = 40},
	["blue_cats4"] =                {min = 18, max = 40},
	["red_cats"] =                  {min = 18, max = 40},
	["red_cats2"] =                 {min = 18, max = 40},
	["red_cats3"] =                 {min = 18, max = 40},
	["red_cats4"] =                 {min = 18, max = 40},
	["orange_cats"] =               {min = 18, max = 40},
	["orange_cats2"] =              {min = 18, max = 40},
	["orange_cats3"] =              {min = 18, max = 40},
	["orange_cats4"] =              {min = 18, max = 40},	
    -- weed stuff
	["blunts"] =                    {min = 18, max = 40},
	["leanblunts"] =                {min = 18, max = 40},
	["dextroblunts"] =              {min = 18, max = 40},
    ["chewyblunt"] =                {min = 18, max = 40},
    ["blunt"] =                     {min = 18, max = 40},
    ["specialchocolate"] =          {min = 18, max = 40},
    ["specialbrownie"] =            {min = 18, max = 40},
    ["specialcookie"] =             {min = 18, max = 40},
    ["specialmuffin"] =             {min = 18, max = 40},
	["shatter"] =                   {min = 18, max = 40},
	["ciggie"] =                    {min = 18, max = 40},
    -- meth
	["methbags"] =                  {min = 18, max = 40},	
    -- mescaline
	["driedmescaline"] =            {min = 18, max = 40},
	-- shrooms
	["shrooms"] =                   {min = 18, max = 40},
    -- LSD
	["gratefuldead_tabs"] =         {min = 18, max = 40},
	["bart_tabs"] =                 {min = 18, max = 40},
	["pineapple_tabs"] =            {min = 18, max = 40},
	["yinyang_tabs"] =              {min = 18, max = 40},
	["wildcherry_tabs"] =           {min = 18, max = 40},	
	["smiley_tabs"] =               {min = 18, max = 40},
	-- lean
    ["cupoflean"] =                 {min = 18, max = 40},
    ["cupofdextro"] =                 {min = 18, max = 40},
}

	Debug = false -- true / false - Currently prints the vector3 and label of locations when requesting a delivery
    NearbyDeliveries = false -- true / false - Do you want deliveries to be within a certain amount of units?
    DeliveryWithin = 2000 -- int (Default 2000) - How many units do you want the delivery location to be within from the player when making a delivery request?
    QBConfig.Dealers = {}


    -- Shop QBConfig
QBConfig.Products = {
        [1] = {name = "weed_white-widow_seed",  price = 15, amount = 150,  minrep = 0},
        [2] = {name = "weed_skunk_seed", 		price = 15, amount = 150,  minrep = 0},
        [3] = {name = "weed_purple-haze_seed",	price = 15, amount = 150,  minrep = 0},
		[4] = {name = "weed_og-kush_seed", 	    price = 15, amount = 150,  minrep = 0},
		[5] = {name = "weed_amnesia_seed", 		price = 15, amount = 150,  minrep = 0},
}

QBConfig.ProductsStupidNameRewrite = {
        [1] = {name = "weed_whitewidow_seed",   price = 15, amount = 150, minrep = 0},
        [2] = {name = "weed_skunk_seed", 		price = 15, amount = 150, minrep = 0},
        [3] = {name = "weed_purplehaze_seed",	price = 15, amount = 150, minrep = 0},
		[4] = {name = "weed_ogkush_seed", 	    price = 15, amount = 150, minrep = 0},
		[5] = {name = "weed_amnesia_seed", 		price = 15, amount = 150, minrep = 0},
}

QBConfig.UseMarkedBills = false -- true for marked bills, false for cash
QBConfig.DeliveryRepGain = 1 -- amount of rep gained per delivery
QBConfig.DeliveryRepLoss = 1 -- amount of rep lost if delivery wrong or late
QBConfig.PoliceDeliveryModifier = 2 -- amount to multiply active cop count by
QBConfig.WrongAmountFee = 2 -- divide the payout by this value for wrong delivery amount
QBConfig.OverdueDeliveryFee = 4 -- divide the payout by this value for overdue delivery

QBConfig.DeliveryItems = {
   [1] = {    ["item"] = "weed_brick",    ["minrep"] = 0,    ['payout'] = 1000},
   [2] = {    ["item"] = "coke_brick",    ["minrep"] = 0,    ['payout'] = 1000},
}

QBConfig.DeliveryLocations = {
    [1] = {     ["label"] = "Pork Factory",             ["coords"] = vector3(-296.27, -1300.54, 31.31),},
    
 }

