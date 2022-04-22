function user_job_setup()

	state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Tank', 'DDTank', 'Normal')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD')
	state.Passive:options('None', 'AbsorbMP')
    state.PhysicalDefenseMode:options('PDT_HP', 'PDT','PDT_Reraise')
    state.MagicalDefenseMode:options('MDT_HP', 'MDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA_HP', 'MEVA')
	state.IdleMode:options('Tank', 'Kiting', 'PDT', 'Block', 'MDT', 'Normal')
	state.Weapons:options('SakPriwen', 'NaeglingBlurred', 'MalevPriwen')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Twilight'}
	
	gear.fastcast_jse_back = {name="Rudianos's Mantle", augments={'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', '"Fast Cast"+10'}}
	gear.enmity_jse_back = {name="Rudianos's Mantle", augments={'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', 'Enmity+10'}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind ^q gs c set IdleMode Kiting')
	send_command('bind !q gs c set IdleMode PDT')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()

	--------------------------------------
	-- Base sets
	--------------------------------------
	-- HP (/WAR): 3198        
	                               -- +105
    sets.Enmity = {                -- Enmity
		ammo="Staunch Tathlum +1",
		head="Souveran Schaller +1",
		neck="Moonlight Necklace", -- +15
		ear1="Odnowa Earring +1",
		ear2="Cryptic Earring",     -- +4
        body="Souveran Cuirass +1", -- +20
		hands="Souveran Handschuhs +1",   -- +9
		ring1="Apeile Ring +1",     -- +9
		ring2="Apeile Ring",        -- +9
        back=gear.enmity_jse_back,  -- +10
		waist="Creed Baudrier",     -- +5
		legs="Souv. Diechlings +1", -- +9
		feet="Eschite Greaves",     -- +15
        --TODO: head="Loess Barbuta +1", -- +24
		--TODO: ear1="Trux Earring" -- (DM2)
		--TODO: legs="Odyssean Cuisses" -- +14 (Fern: Enm+8)
	}

	sets.Enmity.SIRD = set_combine(sets.Enmity, {})
		
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity, {legs="Caballarius Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, {feet="Reverence Leggings +1"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, {feet="Caballarius Leggings +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity, {"Caballarius Coronet +1"})
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity, {body="Caballarius Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, {feet="Chevalier's Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {head="Reverence Coronet +1", body="Caballarius Surcoat +1"})
	
    -- Chivalry (MND)
    sets.precast.JA['Chivalry'] = {ammo="Paeapua",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Rev. Surcoat +3",hands="Cab. Gauntlets +1",ring1="Stikini Ring +1",ring2="Rufescent Ring",
		back=gear.enmity_jse_back,waist="Luminary Sash",legs="Nyame Flanchard",feet="Carmine Greaves +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +1"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +1"})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})


    -- Fast cast sets for spells
    sets.precast.FC = {
		main="Sakpata's Sword",
		sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Voltsurge Torque",
		waist="Flume Belt",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Kishar Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}},
		-- TODO: Rev+3 body
	}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	-- TODO: precast cure?
  
    -- Weaponskill sets
    sets.precast.WS = {
		ranged=empty,
		ammo="Ginsen",
		head="Nyame Helm",
		neck="Asperity Necklace",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Regal Ring",
		ring2="Rufescent Ring",
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
	}

    sets.precast.WS['Aeolian Edge'] = {
		ranged=empty,
		ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		neck="Sanctity Necklace",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ear1="Moonshade Earring",
		ear2="Friomisi Earring",
		ring1="Shiva Ring +1",
		ring2="Acumen Ring",
		waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring"})
	sets.precast.WS['Flat Blade'] = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"}
    sets.precast.WS['Sanguine Blade'] = {ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",neck="Fotia Gorget",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Metamor. Ring +1",
        back="Toro Cape",waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    sets.precast.WS['Atonement'] = {ammo="Paeapua",
        head="Loess Barbuta +1",neck="Moonlight Necklace",ear1="Friomisi Earring",ear2="Trux Earring",
        body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back=gear.enmity_jse_back,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Eschite Greaves"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
    sets.midcast.FastRecast = {main="Sakpata's Sword",sub="Chanter's Shield",ammo="Hasty Pinion +1",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Rev. Surcoat +3",hands="Leyline Gloves",ring1="Gelatinous Ring +1",ring2="Kishar Ring",
		back=gear.fastcast_jse_back,waist="Creed Baudrier",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1",neck="Sacro Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Jumalik Mail",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.enmity_jse_back,waist="Creed Baudrier",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
		
	-- TODO: This gear probably sucks
    sets.midcast.Reprisal = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Sakpata's Cuisses",
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Baetyl Pendant",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Tuisto Earring",
		right_ear="Etiolation Earring",
		left_ring="Kishar Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}},
	}

	sets.Self_Healing = {main="Deacon Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Sacro Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

	sets.Cure_Received = {hands="Souv. Handsch. +1", feet="Souveran Schuhs +1"}

    sets.midcast['Enhancing Magic'] = {main="Colada",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",neck="Incanter's Torque",ear1="Mimir Earring",ear2="Andoaa Earring",
		body="Shab. Cuirass +1",hands="Regal Gauntlets",ring1="Defending Ring",ring2="Kishar Ring",
		back="Merciful Cape",waist="Olympus Sash",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Shell = {ring2="Sheltered Ring"}
	
	-- HP (/WAR): 3147
	-- PDT: 56, MDT: 44, BDT: 40
	                               -- +31 (+33)   +60 (+66)  360 (next: 386)
	sets.midcast.Phalanx = {       -- Phalanx     SIRD       Enhancing
		main="Sakpata's Sword",    -- +5
		sub="Priwen",              -- +2
		ammo="Staunch Tathlum +1", --             +11
		head="Yorium Barbuta",     -- +3          +5 (+10)
		neck="Moonlight Necklace", --             +15
		ear1="Tuisto Earring",
		ear2="Mimir Earring",      --                        +10
		body="Yorium Cuirass",     -- +3          +9 (+10)
		hands="Souv. Handsch. +1", -- +5
		ring1="Gelatinous Ring +1",
		ring2="Moonlight Ring",
		back="Weard Mantle",       -- +3 (+5)
		waist="Audumbla Sash",     --             +10
		legs="Sakpata's Cuisses",  -- +5
		feet="Souveran Schuhs +1", -- +5
		-- merits                                 +10
	}
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast.Phalanx, {
	})
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})	
	sets.Phalanx_Received = sets.midcast.Phalanx -- TODO: can remove all enhancing+

	--------------------------------------
	-- Idle
	--------------------------------------
	-- HP (/WAR): 3118
    sets.idle = {
		main="Sakpata's Sword",
		sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Sanctity Necklace",
		waist="Carrier's Sash",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Chance of successful block +5',}},
		-- TODO: Thureus Earring
		-- TODO: Unmoving Neck +1 R15
	}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}

	--------------------------------------
    -- Defense 
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.MP = {head="Chev. Armet +1", neck="Coatl Gorget +1", waist="Flume Belt"}
	sets.passive.AbsorbMP = set_combine(sets.MP, {})
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	--------------------------------------
	-- Weapons
	--------------------------------------
	sets.weapons.SakPriwen = {main="Sakpata's Sword", sub="Priwen"}
	sets.weapons.NaeglingBlurred = {main="Naegling", sub="Blurred Shield +1"}
	sets.weapons.MalevPriwen = {main="Malevolence", sub="Priwen"}
		
	--------------------------------------
	-- Engaged
	--------------------------------------
	sets.engaged = {
	}
	sets.engaged.DDTank = {
		head="Sakpata's Helm",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Lissome Necklace",
		ear1="Brutal Earring",
		ear2="Telos Earring",
		ammo="Ginsen",
		waist="Sailfi Belt +1",
		ring1="Petrov Ring",
		ring2="Moonlight Ring",
	}

	--------------------------------------
	-- Buffs / Debuffs
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4) --War/Etc
    end
end