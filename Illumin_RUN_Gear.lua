function user_setup()

	state.OffenseMode:options('Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('PDT','DD','SuperTank','MDT','MEva')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.CastingMode:options('Normal','SIRD','Resistant')
	state.PhysicalDefenseMode:options('SuperTank', 'PDT', 'PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm','DTCharm')
	state.IdleMode:options('Normal','Tank','KiteTank','Sphere')
	state.Weapons:options('Epeolatry','Epeo/Utu','Epeo/Irenic','Lionheart','HepatizonAxe','KajaChopper','Naegling')

	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	--send_command('bind !r gs c weapons Lionheart;gs c update')
	
	select_default_macro_book()
end

function init_gear_sets()

	Ogma_Tank = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}
	Ogma_FC = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	Ogma_TP = { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	Ogma_WS = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}}

	HerculeanBoots_TP = { name="Herculean Boots", augments={'Attack+30','"Triple Atk."+3','DEX+6','Accuracy+7',}}

	-- XXX: STR+15, Acc/Atk+, TA+3
    HerculeanGloves_Reso = { name="Herculean Gloves", augments={'"Triple Atk."+3','STR+11',}}
	
	sets.Enmity = {
		head="Halitus Helm", -- +8
		neck="Moonlight Necklace", -- +15
		left_ear="Friomisi Earring", -- +2 -- XXX: Trux
		right_ear="Cryptic Earring", -- +4
		body="Emet Harness +1", -- +10
		hands="Kurys Gloves", -- +9
		legs="Eri. Leg Guards +1", -- +11
		feet="Ahosi Leggings", -- +6
		left_ring="Supershear Ring", -- +5
		right_ring="Eihwaz Ring", -- +5
		waist="Kasiri Belt", -- +3
		ammo="Aqreqaq Bomblet", -- +2 
		back=Ogma_Tank, -- +10
	}

	-- 101% SIRD (10% from merits)
	-- +72 Enmity
	-- -48 PDT (incl. Epeo)
    sets.Enmity.SIRD = {
		-- +23 from Epeolatry
		head="Agwu's Cap",
		body="Emet Harness +1", -- +10 Enmity
		neck="Moonlight Necklace", -- +15 Enmity, 15% SIRD
    	hands={ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}}, -- +15% SIRD
		legs="Carmine Cuisses +1", -- +20% SIRD
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','HP+45',}}, -- +10% SIRD
		left_ring="Supershear Ring", -- +5 Enmity
		right_ring="Eihwaz Ring", -- +5 Enmity
		left_ear="Cryptic Earring", -- +4 Enmity
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		waist="Audumbla Sash", -- 10% SIRD
		ammo="Staunch Tathlum +1", -- 11% SIRD
		back=Ogma_Tank, -- +10 Enmity
	}

    sets.Enmity.DT = {
		head="Futhark Bandeau +3",
		body="Futhark Coat +3",
		neck="Moonlight Necklace", -- +15 Enmity, 15% SIRD
		hands="Rawhide Gloves", -- +15 SIRD
		legs="Eri. Leg Guards +1", -- +11 Enmity
		feet="Ahosi Leggings", -- +6 Enmity
		left_ring="Defending Ring", -- 10% DT
		right_ring="Eihwaz Ring", -- +5 Enmity
		left_ear="Cryptic Earring", -- +4 Enmity
		right_ear="Genmei Earring", -- 2% PDT
		waist="Audumbla Sash", -- 10% SIRD
		ammo="Staunch Tathlum +1", -- 3% DT, 11% SIRD
		back=Ogma_Tank, -- +10 Enmity
	}
	
	-- (10% from merits)
	-- total: 104%
    sets.SIRD = {
		head="Futhark Bandeau +3",
		neck="Moonlight Necklace", -- 15% SIRD
		ear1="Halasz Earring", -- 5% SIRD
		ear2="Magnetic Earring", -- 8% SIRD
		body="Futhark Coat +3",
		hands="Rawhide Gloves", -- 15% SIRD
		ring1="Defending Ring",
		ring2="Moonlight Ring",
		legs="Carmine Cuisses +1", -- 20% SIRD
		feet="Erilaz Greaves +1",
		waist="Audumbla Sash", -- 10% SIRD
		ammo="Staunch Tathlum +1", -- 11% SIRD
		back=Ogma_FC, -- 10% SIRD
	}
	
	sets.Enmity.DT = set_combine(sets.Enmity, {
		body="Futhark Coat +3",
		waist="Flume Belt",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",		
	})

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{body="Runeist's Coat +3",legs="Futhark Trousers +3"})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist Bottes +1"})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist's Mitons +3"})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{feet="Futhark Boots +1"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{hands="Futhark Mitons +3"})
    sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{})
    sets.precast.JA['One For All'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{body="Runeist's Coat +3", legs="Futhark Trousers +3"})
    sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
    sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist Bottes +1"})
    sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist's Mitons +2"})
    sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{feet="Futhark Boots +1"})
    sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{hands="Futhark Mitons +3"})
    sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['One For All'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})

    sets.precast.JA['Lunge'] = {}

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	-- Gear for specific elemental nukes.
	sets.element.Dark = {}

	-- Pulse sets, different stats for different rune modes, stat aligned.
    sets.precast.JA['Vivacious Pulse'] = set_combine(sets.Enmity, {
		head="Erilaz Galea +1",
		legs="Rune. Trousers +3",
		neck="Incanter's Torque",
		waist="Bishop's Sash",
		right_ear="Beatific Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
	})
		
	-- Fast cast sets for spells
	-- 67%
    sets.precast.FC = {
		head="Runeist's Bandeau +3", -- 14%
		body={ name="Taeon Tabard", augments={'"Fast Cast"+3','Phalanx +3',}}, -- XXX: Augment up to 5%
		neck="Voltsurge Torque", -- 4%
		legs="Ayanmo Cosciales +2", -- 6%
		feet="Carmine Greaves +1", -- 8%
		hands="Leyline Gloves", -- 8%
		left_ring="Kishar Ring", -- 4%
		right_ring="Prolix Ring", -- 4%
		left_ear="Loquacious Earring", -- 2%
		right_ear="Etiolation Earring", -- 1%
		back=Ogma_FC, -- 10%
	}
			
	sets.precast.FC.DT = set_combine(sets.precast.FC, {})
			
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +3"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	
	-- ****

	-- Weaponskill sets
	sets.precast.WS = {
		head="Futhark Bandeau +3",
		body="Adhemar Jacket +1",
		hands=HerculeanGloves_Reso,
		legs="Meg. Chausses +2",
		feet="Lustratio Leggings +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=Ogma_WS,
		ammo="Knobkierrie",
	}
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS['Resolution'] = {
		head="Futhark Bandeau +3",
		body="Adhemar Jacket +1",
		hands=HerculeanGloves_Reso,
		legs="Meg. Chausses +2",
		feet="Lustratio Leggings +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=Ogma_WS,
		ammo="Knobkierrie",
	}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'],{})
    sets.precast.WS['Resolution'].HighAcc = set_combine(sets.precast.WS['Resolution'],{})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'],{})

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		--head="Adhemar Bonnet +1",
		--body="Adhemar Jacket +1",
		hands="Meg. Gloves +2",
		neck="Caro Necklace",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		--legs="Lustratio Subligar +1",
		--feet="Lustratio Leggings +1",
		waist="Grunfeld Rope",
		ring1="Ilabrat Ring",
		ring2="Niqmaddu Ring",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		back=Ogma_WS,
	})
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'],{})
	sets.precast.WS['Dimidiation'].HighAcc = set_combine(sets.precast.WS['Dimidiation'],{})
	sets.precast.WS['Dimidiation'].FullAcc = set_combine(sets.precast.WS['Dimidiation'],{})
		
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast['Lunge'], {})

	sets.precast.WS['Full Break'] = {
		ammo="Yamarang",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Moonlight Necklace",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Odnowa Earring +1",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Stikini Ring +1",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}

	sets.precast.WS['Steel Cyclone'] = {
		ammo="Yamarang",
		head="Turms Cap +1",
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs="Rune. Trousers +3",
		feet="Turms Leggings +1",
		neck="Sanctity Necklace",
		waist="Grunfeld Rope",
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Supershear Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		head="Futhark Bandeau +3"
	})
			
	sets.midcast.FastRecast.DT = {
		ammo="Staunch Tathlum +1",
        head="Futhark Bandeau +3",
        body="Runeist's Coat +3",
		waist="Flume Belt",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1"
	}

    sets.midcast['Enhancing Magic'] = set_combine(sets.SIRD, {
		head="Erilaz Galea +1",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Mimir Earring",
		hands="Runeist's Mitons +3",
		waist="Olympus Sash",
		legs="Futhark Trousers +3",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
	})

	-- Phalanx +19 (Total: Damage -53)
	-- SIRD 59%, PDT 23%
	-- 473 Enhancing Skill (443 = Damage-33, 472 = Damage-34, 500 = Damage-35)
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		-- main="Deacon Sword" -- XXX: AAEV, Phalanx+4
		head="Futhark Bandeau +3",
		body={ name="Taeon Tabard", augments={'"Fast Cast"+3','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Spell interruption rate down -8%','Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		neck="Incanter's Torque",
		left_ear="Andoaa Earring",
		right_ear="Mimir Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
		waist="Audumbla Sash", -- SIRD 10%, PDT-4%
		ammo="Staunch Tathlum +1",
	})

	-- drop down to 443 skill (Total: Damage -52)
	-- SIRD 67%, PDT 38%
	sets.midcast['Phalanx'].SIRD = set_combine(sets.midcast['Phalanx'], {
		neck="Loricate Torque +1",
		left_ear="Genmei Earring",
		right_ear="Magnetic Earring", -- SIRD 8%
	})

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{head="Rune. Bandeau +3"}) 
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{head="Erilaz Galea +1"}) 
	sets.midcast.Aquaveil = set_combine(sets.SIRD, {})
	sets.midcast.Poisonga = set_combine(sets.SIRD, {})
    sets.midcast.Stoneskin = set_combine(sets.SIRD, sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring", waist="Siegel Sash"})
	sets.midcast.Flash = set_combine(sets.Enmity.DT, {})
	sets.midcast.Foil = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity.DT, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Crusade'] = set_combine(sets.SIRD, {legs="Futhark Trousers +3"})

    sets.midcast.Cure = {ring2="Janniston Ring",waist="Luminary Sash",legs="Carmine Cuisses +1"}
		
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})
		
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	sets.Phalanx_Received = {}
	
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		neck="Futhark Torque +1",
		ear1="Cryptic Earring",
		ear2="Odnowa Earring +1",
		body="Nyame Mail",
		hands="Turms Mittens +1",
		ring1="Moonlight Ring",
		ring2="Gelatinous Ring +1",
		back=Ogma_Tank,
		waist="Engraved Belt",
		legs="Nyame Flanchard",
		feet="Turms Leggings +1",
	}
	sets.defense.PDT_HP = set_combine(sets.defense.PDT, {})
	sets.idle = sets.defense.PDT
	sets.idle.PDT = sets.defense.PDT

    sets.idle.DD = {
		ammo="Yamarang",
		head="Turms Cap +1",
		body="Futhark Coat +3",
		waist="Engraved Belt",
		legs="Eri. Leg Guards +1",
		hands="Turms Mittens +1",
		feet="Turms Leggings +1",
		neck="Futhark Torque +1",
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=Ogma_Tank,
	}
		
    sets.idle.Sphere = set_combine(sets.idle,{})
			
	sets.idle.Tank = set_combine(sets.idle,{})
		
	sets.idle.KiteTank = set_combine(sets.idle.Tank, {legs="Carmine Cuisses +1"})
	sets.idle.Weak = set_combine(sets.idle,{})

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {head="Futhark Bandeau +3", waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {body="Erilaz Surcoat +1",waist="Flume Belt"}
	sets.TreasureHunter = {
		head="Volte Cap",
		hands="Volte Bracers",
		waist="Chaac Belt",
		body={ name="Herculean Vest", augments={'Crit.hit rate+3','Rng.Atk.+7','"Treasure Hunter"+1','Accuracy+3 Attack+3','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
	}
	
	-- Weapons sets
	sets.weapons["Epeolatry"] = {main="Epeolatry",sub="Refined Grip +1"}
	sets.weapons["Epeo/Utu"] = {main="Epeolatry",sub="Utu Grip"}
	sets.weapons["Epeo/Irenic"] = {main="Epeolatry",sub="Irenic Strap +1"}
	sets.weapons["Lionheart"] = {main="Lionheart",sub="Utu Grip"}
	sets.weapons["HepatizonAxe"] = {main="Hepatizon Axe",sub="Utu Grip"}
	sets.weapons["KajaChopper"] = {main="Kaja Chopper",sub="Utu Grip"}
	sets.weapons["Naegling"] = {main="Naegling",sub="Sors Shield"}
	--sets.weapons.DualWeapons = {main="Firangi",sub="Reikiko"}
	
	-- Defense Sets
	
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		neck="Futhark Torque +1",
		ear1="Cryptic Earring",
		ear2="Odnowa Earring +1",
		body="Nyame Mail",
		hands="Turms Mittens +1",
		ring1="Moonlight Ring",
		ring2="Gelatinous Ring +1",
		back=Ogma_Tank,
		waist="Engraved Belt",
		legs="Nyame Flanchard",
		feet="Turms Leggings +1",
	}
	sets.defense.PDT_HP = set_combine(sets.defense.PDT, {})

	sets.defense.SuperTank = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +1",
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Erilaz Gauntlets +1",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
	}
	
	sets.defense.MEVA = {
		ammo="Yamarang",
		head="Futhark Bandeau +3",
		body="Futhark Coat +3",
		hands="Erilaz Gauntlets +1",
		legs="Rune. Trousers +3",
		feet="Turms Leggings +1",
		neck="Futhark Torque +1",
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear="Genmei Earring", -- XXX: Sanare
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back=Ogma_Tank,
	}
	sets.defense.MEVA_HP = set_combine(sets.defense.MEVA, {})
		
	sets.defense.MDT = set_combine(sets.defense.MEVA, {})
	sets.defense.MDT_HP = set_combine(sets.defense.MEVA, {})
	
	sets.defense.BDT = set_combine(sets.defense.MEVA, {})
	sets.defense.BDT_HP = set_combine(sets.defense.MEVA, {})
		
	sets.defense.Death = set_combine(sets.defense.MEVA, {
		ring1="Purity Ring",
		legs="Rune. Trousers +3",
	})

	sets.defense.DTCharm = sets.defense.Death
	sets.defense.Charm = sets.defense.Death
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Telos Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {
		ammo="Yamarang",
		head="Adhemar Bonnet +1",
		body="Ayanmo Corazza +2",
		hands="Adhemar Wristbands +1",
		legs="Meg. Chausses +2",
		feet=HerculeanBoots_TP,
		neck="Futhark Torque +1",
		waist="Sailfi Belt +1",
		ear1="Telos Earring",
		ear2="Sherida Earring",
		ring1="Defending Ring",
		ring2="Niqmaddu Ring",
		back=Ogma_TP,
	}
	sets.engaged.Lionheart = set_combine(sets.engaged, {
		ring2="Epona's Ring",
	})
    sets.engaged.SomeAcc = set_combine(sets.engaged, {
		neck="Lissome Necklace",
	})
	sets.engaged.Acc = set_combine(sets.engaged, {
		neck="Lissome Necklace",
	})
	sets.engaged.HighAcc = set_combine(sets.engaged, {
		neck="Lissome Necklace",
	})
	sets.engaged.FullAcc = set_combine(sets.engaged, {
		neck="Lissome Necklace",
	})
	
    sets.engaged.PDT = set_combine(sets.defense.PDT, {})
    sets.engaged.SomeAcc.PDT = sets.engaged.PDT
	sets.engaged.Acc.PDT = sets.engaged.PDT
	sets.engaged.HighAcc.PDT = sets.engaged.PDT
	sets.engaged.FullAcc.PDT = sets.engaged.PDT
	
    sets.engaged.MDT = set_combine(sets.defense.MDT, {})
    sets.engaged.SomeAcc.MDT = sets.engaged.MDT
	sets.engaged.Acc.MDT = sets.engaged.MDT
	sets.engaged.HighAcc.MDT = sets.engaged.MDT
	sets.engaged.FullAcc.MDT = sets.engaged.MDT
	
    sets.engaged.MEva = set_combine(sets.defense.MEva, {})
    sets.engaged.SomeAcc.MEva = sets.engaged.MEva
	sets.engaged.Acc.MEva = sets.engaged.MEva
	sets.engaged.HighAcc.MEva = sets.engaged.MEva
	sets.engaged.FullAcc.MEva = sets.engaged.MEva
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = {ring2="Purity Ring",waist="Gishdubar Sash"}
	sets.buff.Sleep = {}
	sets.buff.Battuta = {}
	sets.buff.Embolden = {}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'BLU' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'DRK' then
		set_macro_page(2, 4)
	elseif player.sub_job == 'WAR' then
		set_macro_page(3, 4)
	else
		set_macro_page(4, 4)
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end