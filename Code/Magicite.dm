obj/item/magicite
	icon='Icons/Items/Magicite.dmi'
	var/obj/prop/glyphico
	var/obj/npc/scion
	verb/Summon()
		var/obj/prop/magiciteprop/p=new
		p.alpha =0
		p.loc=locate(usr.x,usr.y,usr.z)
		step(p,NORTH,0)
		step(p,NORTH,0)
		animate(p,alpha=255,time=10)
		sleep(20)
		var/obj/prop/p2 = copyatom(src.glyphico)
		p2.loc=locate(p.x,p.y,p.z)
		del(p)
		sleep(20)
		var/obj/npc/n= copyatom(src.scion)
		n.loc=locate(p2.x,p2.y,p2.z)
		n.owner=usr.key
		n.archived=0
		del(p2)
	Belias
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Belias
	Mateus
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Mateus
	Adramalech
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Adramalech
	Hashmal
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Hashmal
	Zalera
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Zalera
	Shemhazai
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Shemhazai
	Cuchulainn
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Cuchulainn
	Zeromus
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Zeromus
	Exodus
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Exodus
	Famfrit
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Famfrit
	Chaos
		glyphico= new /obj/prop/beliasglyph
		scion = new /obj/npc/Summons/ARank/Chaos

obj/prop
	magiciteprop
		icon='Icons/Items/Magicite.dmi'
	beliasglyph
		icon='Icons/Summon/Scionglyphs/belias.png'
		pixel_x=-30
		pixel_y=-20

obj/npc
	var/scion
	var/materiasummon

obj/npc/Summons/ARank
	Belias
		icon='Icons/Summon/belias.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=20
		strmod=5
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=4
		mdb=5
		pab=6
		pdb=16
		basedr=0
		baseac=18
		speed=5
		New()
			var/obj/perk/Abilities/BlackMagic/Flame/Fira/a=new
			var/obj/perk/Abilities/BlackMagic/Flame/Firaga/b=new
			var/obj/perk/Abilities/BlackMagic/Flame/Firaja/c=new
			var/obj/item/Weapon/Melee/Axe/Orichalcum/wep=new
			var/obj/perk/SummonPassives/Belias/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c

	Mateus
		icon='Icons/Summon/Mateus.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=9
		mdb=14
		pab=6
		pdb=6
		basedr=0
		baseac=18
		speed=5
		New()
			var/obj/perk/Abilities/BlackMagic/Ice/Blizzara/a=new
			var/obj/perk/Abilities/BlackMagic/Ice/Blizzaga/b=new
			var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/c=new
			var/obj/item/Weapon/Melee/Spear/Orichalcum/wep=new
			var/obj/perk/SummonPassives/Mateus/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Adramalech
		icon='Icons/Summon/Adramalech.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=10
		mdb=5
		pab=5
		pdb=5
		basedr=0
		baseac=18
		speed=5
		New()
			var/obj/perk/Abilities/BlackMagic/Lightning/Thunder/a=new
			var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/b=new
			var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/c=new
			var/obj/item/Weapon/NPCWeapons/Claw/wep=new
			var/obj/perk/SummonPassives/Adramalech/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Hashmal
		icon='Icons/Summon/Hashmal.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=20
		strmod=5
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=5
		mdb=5
		pab=9
		pdb=10
		basedr=3
		baseac=20
		speed=5
		New()
			var/obj/perk/Abilities/Geomancer/Earth/Stonra/a=new
			var/obj/perk/Abilities/Geomancer/Earth/Stoneaga/b=new
			var/obj/perk/Abilities/Geomancer/Earth/Stonaja/c=new
			var/obj/item/Weapon/Melee/Dagger/Orichalcum/wep=new
			var/obj/perk/SummonPassives/Hashmal/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Zalera
		icon='Icons/Summon/Zalera.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=9
		mdb=2
		pab=6
		pdb=16
		basedr=0
		baseac=21
		speed=5
		New()
			var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkra/a=new
			var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Blindga/b=new
			var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Sleepga/c=new
			var/obj/item/Weapon/NPCWeapons/Claw/wep=new
			var/obj/perk/SummonPassives/Zalera/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Shemhazai
		icon='Icons/Summon/Shemhazai.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=20
		intmod=5
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=9
		mdb=10
		pab=6
		pdb=16
		basedr=5
		baseac=20
		speed=5
		New()
			var/obj/perk/Abilities/GeneralMagicAbilities/Fogga/a=new
			var/obj/perk/Abilities/GeneralMagicAbilities/Jolt/b=new
			var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/c=new
			var/obj/item/Weapon/Ranged/Bow/Orichalcum/wep=new
			var/obj/perk/SummonPassives/Shemhazai/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Cuchulainn
		icon='Icons/Summon/Cuchulainn.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=22
		wismod=6
		cha=16
		chamod=3
		mab=8
		mdb=5
		pab=2
		pdb=5
		basedr=0
		baseac=20
		speed=5
		New()
			var/obj/perk/Abilities/ArcaneMagic/Bios/Bioara/a=new
			var/obj/perk/Abilities/ArcaneMagic/Bios/Bioaga/b=new
			var/obj/perk/Abilities/ArcaneMagic/Bios/Scourge/c=new
			var/obj/item/Weapon/NPCWeapons/Punch/wep=new
			var/obj/perk/SummonPassives/Cuchulainn/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Zeromus
		icon='Icons/Summon/Zeromus.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=6
		mdb=10
		pab=6
		pdb=16
		basedr=0
		baseac=20
		speed=5
		New()
			var/obj/perk/Abilities/TimeMage/Times/Slowga/a=new
			var/obj/perk/Abilities/TimeMage/Times/Warp/b=new
			var/obj/perk/Abilities/TimeMage/Gravitys/Graviga/c=new
			var/obj/item/Weapon/NPCWeapons/Claw/wep=new
			var/obj/perk/SummonPassives/Zeromus/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Exodus
		icon='Icons/Summon/Exodus.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=22
		wismod=6
		cha=16
		chamod=3
		mab=15
		mdb=15
		pab=6
		pdb=16
		basedr=0
		baseac=20
		speed=5
		New()
			var/obj/perk/Abilities/TimeMage/Comets/Comet/a=new
			var/obj/perk/Abilities/TimeMage/Comets/Meteor/b=new
			var/obj/perk/Abilities/TimeMage/Gravitys/Graviga/c=new
			var/obj/perk/SummonPassives/Exodus/summpass=new
			src.contents+=summpass
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Famfrit
		icon='Icons/Summon/Famfrit.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=7
		mdb=10
		pab=7
		pdb=10
		basedr=5
		baseac=22
		speed=5
		New()
			var/obj/perk/Abilities/BlackMagic/Hydro/Water/a=new
			var/obj/perk/Abilities/BlackMagic/Hydro/Watera/b=new
			var/obj/perk/Abilities/BlackMagic/Hydro/Waterga/c=new
			var/obj/perk/Abilities/BlackMagic/Hydro/Tsunami/d=new
			var/obj/item/Weapon/NPCWeapons/Ewer/wep=new
			var/obj/perk/SummonPassives/Famfrit/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
			src.contents+=d
	Chaos
		icon='Icons/Summon/Chaos.png'
		scion=1
		mhp=220
		hp=220
		mmp=300
		mp=300
		msp=250
		sp=250
		str=18
		strmod=4
		dex=14
		dexmod=2
		con=14
		conmod=2
		int=12
		intmod=1
		wis=20
		wismod=5
		cha=16
		chamod=3
		mab=8
		mdb=12
		pab=8
		pdb=12
		basedr=5
		baseac=20
		speed=5
		New()
			var/obj/perk/Abilities/WhiteMagic/Wind/Aerora/a=new
			var/obj/perk/Abilities/WhiteMagic/Wind/Aeroga/b=new
			var/obj/perk/Abilities/WhiteMagic/Wind/Aeroja/c=new
			var/obj/perk/Abilities/WhiteMagic/Wind/Tornado/d=new
			var/obj/perk/Abilities/GeneralMagicAbilities/Fleche/f=new
			var/obj/perk/SummonPassives/Chaos/summpass=new
			src.contents+=summpass
			src.contents+=a
			src.contents+=b
			src.contents+=c
			src.contents+=d
			src.contents+=f
