-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT','MDT','MEva')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurorastorm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

function init_gear_sets()
    sets.Kiting = { feet = "Herald's Gaiters" }
    sets.latent_refresh = {body="Theo. Briault +3", waist="Fucho-no-obi",ammo="Homiliary",legs="Assiduity Pants +1"}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist="Chaac Belt"})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	-- Conserve MP set for spells that don't need anything else, for set_combine.
	-- Gear: 76%
	-- /SCH: 25%
	-- 100% cap = 28.125% MP reduction
	sets.ConserveMP = {
		main="Sucellus", -- 5
		sub="Thuellaic Ecu +1", -- 4
		ammo="Pemphredo Tathlum", -- 4
		head={ name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}, -- 12
		body="Vedic Coat", -- 10
		hands="Shrieker's Cuffs", -- 7
		neck="Reti Pendant", -- 4
		ear1="Magnetic Earring", -- 5
		ear2="Calamitous Earring", -- 4
		legs="Vanya Slops", -- 12
		waist="Austerity Belt +1", -- 9
	}

	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="C. Palug Hammer",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="C. Palug Hammer",sub="Sindri"}
	
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
    -- Precast Sets

    -- Fast cast sets for spells
	-- /SCH with correct Arts: 10%
	-- Gear: 80%
    sets.precast.FC = {
		main="C. Palug Hammer", -- 7%
		sub="Genmei Shield",
		ammo="Incantor Stone", -- 2%
		head="Bunzi's Hat", -- 10%
		neck="Orison Locket", -- 5% <-- fully aug'd Cleric's Torque (NQ) = 6
		body="Inyanga Jubbah +2", -- 14% 
		hands="Gendewitha Gages +1", -- 7% (and -5% CCT)
		legs="Ayanmo Cosciales +2", -- 6%
		feet="Regal Pumps +1", -- 5% (up to 7%) 
		waist="Embla Sash", -- 5%
		left_ear="Malignance Earring", -- 4% 
		right_ear="Etiolation Earring", -- 1%
		left_ring="Defending Ring",
		right_ring="Kishar Ring", -- 4%
		back="Alaunus's Cape", -- 10%
	}
	
	-- caps at 10%
	-- Gear: 11%
	sets.precast.QuickMagic = set_combine(sets.precast.FC, {
		ammo="Impatiens", -- 2%
		right_ring="Lebeche Ring", -- 2%
		waist="Witful Belt", -- 3%
		back="Perimede Cape", -- 4%
	})
	
	sets.precast.Teleport = sets.precast.QuickMagic
	sets.precast['Raise'] = sets.precast.QuickMagic
	sets.precast['Raise II'] = sets.precast.QuickMagic
	sets.precast['Raise III'] = sets.precast.QuickMagic
	sets.precast['Arise'] = sets.precast.QuickMagic
	sets.precast['Reraise IV'] = sets.precast.QuickMagic

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		-- 85% CCT, so we can take off 5%
	})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		body="Piety Briault +3",
		waist="Chaac Belt"
	}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Hasty Pinion +1",
		head="Befouled Crown",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		waist="Fotia Belt",legs="Assid. Pants +1"}

    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
		left_ring="Rufescent Ring",
	})
    --sets.precast.WS['Flash Nova'] = {}
    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {}
	
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
		
    -- Cure sets
	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	-- Cure
	-- Cure Potency: (52%/50%)
	-- Cure Potency II: 20%
	sets.midcast.Cure = {
        main="Queller Rod", -- 10% (I), 2% (II)
		sub="Thuellaic Ecu +1",
		head="Kaykaus Mitra +1", -- 11% (I), 2% (II, set)
		body="Theophany Bliaut +3", -- 3% (II)
		hands="Theophany Mitts +3", -- 4% (II)
		legs="Ebers Pantaloons +1", -- Convert to MP
		feet="Kaykaus Boots +1", -- 17% (I), 2% (II, set)
		left_ear="Glorious Earring", -- 2% (II)
		right_ear="Mendicant's Earring", -- 5% (I)
		left_ring="Menelaus's Ring", -- 5% (I)
		right_ring="Janniston Ring", -- 5% (II)
		back="Alaunus's Cape",
		waist="Embla Sash", -- Recast
		ammo="Hasty Pinion +1", -- Recast
		neck="Orison Locket", -- Recast, HP
	}
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {
		body="Ebers Bliaut +1",
		back="Alaunus's Cape",
	})

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff",
		sub="Enki Strap",
		waist="Hachirin-no-Obi",
		back="Twilight Cape",
	})
	sets.midcast.LightDayCure = sets.midcast.LightWeatherCure

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff",
		sub="Enki Strap",
		waist="Hachirin-no-Obi",
		back="Alaunus's Cape",
	})
	sets.midcast.LightDayCureSolace = sets.midcast.LightWeatherCureSolace

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
		body="Theophany Bliaut +3", -- 3% (II)
	})
		
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Curaga, {
		main="Chatoyant Staff",
		sub="Enki Strap",
		waist="Hachirin-no-Obi",
		back="Twilight Cape",
	})
	sets.midcast.LightDayCuraga = sets.midcast.LightWeatherCuraga

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = set_combine(sets.midcast.Cure, {
		main="",
		sub="",
		ranged="",
		ammo="",
	})
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	-- Cursna (Total: ~30% + 92% = ~122%)
	--   +Cursna: 116%
	--   Healing Skill: +107
	--   Success Rate: 65.376% 
	-- Base success rate: (Healing Skill: 609)
	--   500 skill: 26%
    --   600 skill: 30%
	--  1000 skill: 43%
	sets.midcast.Cursna = {
		main="Yagrush", -- but Gada has 18 skill
		sub="Thuellaic Ecu +1", -- 2% haste
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, -- +20 Healing
		neck="Debilis Medallion", -- +15%
		body="Ebers Bliaut +1", -- +24 Skill
		hands="Fanatic Gloves", -- +15%, +10 Healing
		legs="Theophany Pantaloons +3", -- +21%
		feet="Vanya Clogs", -- +5%, +20 Healing
		back="Alaunus's Cape", -- +25%
		left_ring="Menelaus's Ring", -- +20%, +15 Healing
		right_ring="Haoma's Ring", -- +15%
		left_ear="Meili Earring", -- +10 Healing
		right_ear="Beatific Earring", -- +4 Healing
		ammo="Hasty Pinion +1", -- 2% haste
		waist="Bishop's Sash", -- +5 Healing
	}

	sets.midcast.StatusRemoval = set_combine(sets.precast.FC, {
		main="Yagrush",
		sub="Thuellaic Ecu +1", -- 2% haste
		hands="Ebers Mitts +1",
		back={name="Mending Cape", augments={'Healing magic skill +3', 'Enha.mag. skill +7', 'Mag. Acc.+6', '"Cure" potency +1%'}}, -- +3
	})
		
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	-- only need 80 in Light Arts
	sets.midcast['Enhancing Magic'] = {
		main="Gada", -- +18, 5% duration
		sub="Ammurapi Shield", -- 10% duration
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}, -- 10% duration
		neck="Incanter's Torque", -- +10 Enhancing
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}, -- 10% duration
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}}, -- 10% duration
		legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}, -- 10% duration
		--legs="Piety Pantaloons +3", -- +26 skill
		feet="Theophany Duckbills +3", -- +21 Enhancing, 10% duration
		waist="Embla Sash", -- 10% duration
		left_ring="Stikini Ring", -- +5 Enhancing
		right_ring="Stikini Ring +1", -- +8 Enhancing
		left_ear="Andoaa Earring", -- +5 Enhancing
		right_ear="Mimir Earring", -- +10 Enhancing
		ammo="Hasty Pinion +1",
		back="Mending Cape", -- +7 Enhancing
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear1="Earthcry Earring",waist="Siegel Sash"})
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +1"})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",head="Chironic Hat",hands="Regal Cuffs",waist="Emphatikos Rope"})

	-- Potency: +76%
	-- Duration: +76%
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga", -- +10% potency
		sub="Ammurapi Shield", -- +10% duration
		head="Inyanga Tiara +2", -- +14% potency
		body="Piety Briault +3", -- +52% potency
		hands="Ebers Mitts +1", -- +22% duration
		legs="Theophany Pantaloons +3", -- +24% duration
		feet="Theophany Duckbills +3", -- +10% duration
		waist="Embla Sash", -- +10% duration
	})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.BarElement = {
		main="Beneficus", -- +5 MDB
		sub="Ammurapi Shield",
		head="Ebers Cap +1", -- set bonus
		body="Ebers Bliaut +1", -- set bonus
		hands="Ebers Mitts +1", -- set bonus
		legs="Piety Pantaloons +3", -- +36
		neck="Incanter's Torque", -- +10
		left_ear="Andoaa Earring", -- +5
		waist="Olympus Sash",
		feet="Ebers Duckbills +1", -- set bonus
		back="Alaunus's Cape", 
		ammo="Hasty Pinion +1"
	}
	
	sets.midcast.Impact = {}
		
	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast['Divine Magic'] = {
		main="Chatoyant Staff",
		head="Befouled Crown",
		neck="Incanter's Torque",
		body="Inyanga Jubbah +2",
		waist="Luminary Sash",
		right_ear="Regal Earring",
	}
		
	sets.midcast.Holy = sets.midcast['Divine Magic']

	sets.midcast['Dark Magic'] = {head="Befouled Crown",neck="Erra Pendant",body="Inyanga Jubbah +2",right_ear="Regal Earring"}
    sets.midcast.Drain = {neck="Erra Pendant",body="Inyanga Jubbah +2",waist="Fucho-no-obi"}
    sets.midcast.Drain.Resistant = sets.midcast.Drain

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}

	sets.midcast.Stun.Resistant = {}

	sets.midcast.Dispel = {neck="Erra Pendant",ear1="Regal Earring",body="Inyanga Jubbah +2"}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})

	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ranged=empty,
		ammo="Hydrocera",
		head="Theophany Cap +3",
		neck="Incanter's Torque",
		body="Theophany Bliaut +3",
		hands="Regal Cuffs",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		ring1="Kishar Ring", -- Duration +10%
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
		waist="Obstinate Sash",
		--waist="Luminary Sash",
		legs="Chironic Hose", -- Aug: Macc+40
		feet="Theophany Duckbills +3",
	}
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
		hands="Kaykaus Cuffs +1",
		legs="Theophany Pantaloons +3",
		ring1="Stikini Ring",
		wait="Acuity Belt +1",
	})
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back="Alaunus's Cape"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back="Alaunus's Cape"})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {main="Chatoyant Staff",ammo="Homiliary",
		head="Befouled Crown",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Ebers Bliaut +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		waist="Fucho-no-obi",legs="Assid. Pants +1"}

	-- PDT: -58%
	-- MDT: -52%
	-- BDT: -38%
	-- Refresh+3
	-- MEva+710
	-- Status Resist+16%; Resist Silence+31% (or +46% if /SCH)
	-- Elements+35
	sets.idle = {
		main="Daybreak", -- Refresh+1
		sub="Genmei Shield", -- PDT-10%
		--main="Malignance Pole", -- DT-20%
		--sub="Irenic Strap +1", -- MEva, MDT-5%
		ammo="Staunch Tathlum +1", -- DT-3%
		--head="Bunzi's Hat",
		--body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		head={name="Inyanga Tiara +2", priority=2}, -- Refresh+0 (Inyanga base)
		body="Theophany Bliaut +3", -- Refresh+3
		--hands="Inyan. Dastanas +2", -- Refresh+1 (Inyanga)
		legs="Inyanga Shalwar +2", -- Refresh+1 (Inyanga)
		feet="Inyan. Crackows +2", -- Refresh+1 (Inyanga)
		--feet={ name="Chironic Slippers", augments={'Pet: CHR+1','STR+10','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
		--neck="Warder's Charm +1",
		neck="Loricate Torque +1", -- DT-6%
		waist={name="Carrier's Sash",priority=1}, -- Elemental Resistance
		left_ear="Hearty Earring", -- Status Resistance
		right_ear={name="Etiolation Earring",priority=1},
		left_ring="Defending Ring", -- DT-10%
		right_ring="Inyanga Ring", -- Refresh+1 (Inyanga)
		back="Alaunus's Cape", -- DT-10%
	}
	
	sets.idle.Town = set_combine(sets.idle, {
		main="Yagrush",
		sub="Ammurapi Shield",
		feet="Herald's Gaiters",
	})

	sets.idle.PDT = {
	    main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Piety Briault +3",
		hands="Ayanmo Manopolas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2", 
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Ethereal Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back="Alaunus's Cape",
	}
	
	-- 4/5 Inyanga + Inyanga Ring
	sets.idle.MDT = {
		main="Daybreak",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Shrieker's Mitts",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Etiolation Earring", 
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Inyanga Ring", 
		back="Alaunus's Cape",
	}	
		
	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",head="Befouled Crown",neck="Loricate Torque +1",
		ear1="Etiolation Earring",ear2="Ethereal Earring",ring1="Defending Ring",ring2="Gelatinous Ring +1",waist="Witful Belt",legs="Assid. Pants +1",}

    -- Defense sets

	sets.defense.PDT = {
	    main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Ayanmo Zucchetto +2",
		body="Piety Briault +3",
		hands="Ayanmo Manopolas +2",
		legs="Assid. Pants +1",
		feet="Inyanga Crackows +1", 
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Ethereal Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back="Alaunus's Cape",
	}

	sets.defense.MDT = {
		main="Malignance Pole",
		sub="Irenic Strap +1",
		ammo="Staunch Tathlum +1",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Inyanga Dastanas +2",
		legs="Assid. Pants +1",
		feet="Inyanga Crackows +2",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Ethereal Earring", 
		right_ear="Eabani Earring",
		left_ring="Defending Ring", -- DT-10%
		right_ring="Inyanga Ring", -- MEva+12 MDT-2%
		back="Moonbeam Cape",
	}	

    sets.defense.MEVA = set_combine(sets.defense.MDT, {neck="Warder's Charm +1",ear1="Etiolation Earring",hands="Shrieker's Cuffs",
		ear2="Eabani Earring",body="Inyanga Jubbah +2",ring1="Inyanga Ring",ring2="Purity Ring"})
		
		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		main={ name="Sindri", augments={'Accuracy+50','Attack+30','"Dbl.Atk."+5',}},
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Brutal Earring",
		right_ear="Dignitary's Earring",
		left_ring="Petrov Ring",
		right_ring="Rufescent Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.Acc = set_combine(sets.engaged.Acc, {})

	sets.engaged.DW = {
		main={ name="Sindri", augments={'Accuracy+50','Attack+30','"Dbl.Atk."+5',}},
		sub={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		ammo="Hasty Pinion +1",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Brutal Earring",
		right_ear="Suppanomimi",
		left_ring="Defending Ring",
		right_ring="Rufescent Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
	
	})
		
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.MaxTP.Dagan = {ear1="Etiolation Earring",ear2="Evans Earring"}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

	sets.HPDown = {}
	sets.HPCure = {}

		
	sets.buff.Doom = {ring2="Purity Ring",waist="Gishdubar Sash"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end