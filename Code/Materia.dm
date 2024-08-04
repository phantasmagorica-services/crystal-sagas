obj
	perk
		MateriaAbilities
			icon='Icons/Perk/GeneralWeapon.png'
			TigerStrike
				name="Tiger's Strike"
				desc="The user of this technique harnesses their inner strength, and combines it with whatever weapon they are using. They then make a thrusting attack, dealing augmented damage and prompting a Fortitude saving throw, DC 18. On a failed save, the target is inflicted with Weakness. This attack gains +1 to hit, and 1d12+10 additional damage."
				rank="C"
				rpcost=3
				technique=1
				mcost=20
				cat="specialab"
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 1
				attack_roll_damage_upper = 12
				attack_roll_dice_sides = 12
				adddam=10
				addhit=1
				damsource="str"
				range="Melee"
				ability=1
				atype="weapon"
				ptype="spell"
				costtype="Stamina"
			RabbitDash
				name="Rabbit's Dash"
				desc="The user of this technique harnesses their inner speed, and utilizes it to escape an incoming attack. As a reaction to an incoming attack or DC effect, this ability may be used to incur disadvantage on an attack roll, or grant advantage on a saving throw, whilst also allowing the user of this technique to move +3 tiles at the end of that opponent’s turn. Costs 20 Stamina to use."
				costtype="Stamina"
				rank="C"
				ability=0
			TurtleStance
				name="Turtle's Stance"
				desc="The user of this technique harnesses their inner vitality, and utilizes it to bolster their survivability. In doing so, they gain a +3 bonus to their AC, and +5 to Damage Reduction for 3 rounds. Bonus action. Cost: 20 Stamina."
				costtype="Stamina"
				rank="C"
				ability=0
			DragonSong
				name="Dragon's Song"
				desc="The user of this technique harnesses their inner wisdom, and then releases it in a burst of magical power. All party members in view including the user gain +2 magical attack bonus, and +10 magical damage bonus for 3 rounds. Cost: 20 Mana."
				costtype="Stamina"
				rank="C"
				ability=0
			SnakeFang
				name="Snake's Fang"
				desc="The user of this technique harnesses their inner cunning, and then releases it in a fang-shaped burst of magical power, as a projectile. A target hit by this attack will take 2d20+5 dark damage. The user will be healed for the damage dealt. This also inflicts 'Poison' on hit."
				ability=0
				rank="C"
				technique=1
				mcost=30
				cat="specialab"
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 2
				attack_roll_damage_upper = 20
				attack_roll_dice_sides = 20
				adddam=5
				addhit=0
				damsource="INT"
				range="7"
				ability=1
				typing="magical"
				atype="standard"
				ptype="spell"
				costtype="Mana"
			PhoenixBlaze
				name="Phoenix's Blaze"
				desc="The user of this technique harnesses their inner leader, and then releases it in a blazing burst of phoenix flames. This targets a 7x7 AoE around the user. All allies in this AoE including the caster are healed for 40 HP. All enemies are aggressed against with an attack roll of 2d12, dealing fire damage, and inflicting 'burn' on a hit."
				ability=0
				rank="C"
				technique=1
				mcost=40
				cat="specialab"
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 2
				attack_roll_damage_upper = 12
				attack_roll_dice_sides = 12
				adddam=5
				addhit=0
				damsource="CHA"
				range="7x7 AoE"
				ability=1
				typing="magical"
				atype="standard"
				ptype="spell"
				costtype="Mana"





obj
	item
		Materia
			Materia=1
			equipped=0
			icon='Icons/Materia.dmi'
			var/materiatype
			var/players
			verb
				Display()
					if(usr.materia1==src || usr.materia2==src || usr.materia3==src)
						if(src in usr.contents)
							players={"<font color=#60F560>[usr.name] has flashed a Materia: <a href="byond://?src=\ref[usr]&action4=lookmat&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
							switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel"))
								if("Reveal")
									view() << output("[players]","icout")
								if("Cancel")
									return
					else
						alert(usr,"You can only display Materia you have equipped to one of your three Materia slots.")
						return
			verb
				Equip()
					if(src.equipped==1)
						alert("You already have this Materia equipped to a slot!")
						return
					switch(alert("Which slot do you wish to equip this Materia to?","[src.name]","Slot 1","Slot 2","Slot 3"))
						if("Slot 1")
							if(usr.materia1!=null)
								alert("You already have a Materia equipped to slot 1!")
							else
								alert("You have equipped [src] to Materia slot 1!")
								usr.materia1=src
								src.equipped=1
								view() << output("<font color=[usr.textcolor]><font size = 1>[usr.name] has equipped [src.name] to Materia Slot 1! ","icout")
								RefreshMateria(usr)
						if("Slot 2")
							if(usr.materia2!=null)
								alert("You already have a Materia equipped to slot 2!")
							else
								alert("You have equipped [src] to Materia slot 2!")
								usr.materia2=src
								view() << output("<font color=[usr.textcolor]><font size = 1>[usr.name] has equipped [src.name] to Materia Slot 2! ","icout")
								src.equipped=1
								RefreshMateria(usr)
						if("Slot 3")
							if(usr.materia3!=null)
								alert("You already have a Materia equipped to slot 3!")
							else
								alert("You have equipped [src] to Materia slot 3!")
								usr.materia3=src
								view() << output("<font color=[usr.textcolor]><font size = 1>[usr.name] has equipped [src.name] to Materia Slot 3! ","icout")
								src.equipped=1
								RefreshMateria(usr)
			verb
				Unequip()
					if(usr.materia1==src)
						alert("You have unequipped [src] from slot 1!")
						usr.materia1=null
						src.equipped=0
						view() << output("<font color=[usr.textcolor]><font size = 1>[usr.name] has unequipped [src.name] from Materia Slot 1! ","icout")
						RefreshMateria(usr)
					if(usr.materia2==src)
						alert("You have unequipped [src] from slot 2!")
						usr.materia2=null
						src.equipped=0
						view() << output("<font color=[usr.textcolor]><font size = 1>[usr.name] has unequipped [src.name] from Materia Slot 2! ","icout")
						RefreshMateria(usr)
					if(usr.materia3==src)
						alert("You have unequipped [src] fromt slot 3!")
						usr.materia3=null
						src.equipped=0
						view() << output("<font color=[usr.textcolor]><font size = 1>[usr.name] has unequipped [src.name] from Materia Slot 3! ","icout")
						RefreshMateria(usr)
			verb
				Use()
					var/row
					if(usr.materia1==src || usr.materia2==src || usr.materia3==src)
						winset(usr,"Materiainv","is-visible=true")
						winset(usr,"Materiainv.mgrid","cells=0x0")
						for(var/obj/perk/C in src.contents)
							row++
							usr<<output(C,"mgrid:1,[row]")
					else
						alert("In order to gain access to a Materia's abilities and spells, it must be equipped!")
						return

			StatMateria
				var/materiascore
				icon_state="yellow"
				materiatype="stat"
				rank="Stat"
				StrengthMateria
					name="Strength Materia"
					desc="Boosts Strength by +2. Also contains the 'Tiger's Strike' ability."
					materiascore="str"
					New()
						var/obj/perk/MateriaAbilities/TigerStrike/a = new /obj/perk/MateriaAbilities/TigerStrike
						src.contents+=a
				DexterityMateria
					name="Dexterity Materia"
					desc="Boosts Dexterity by +2. Also contains the 'Rabbit's Dash' ability."
					materiascore="dex"
					New()
						var/obj/perk/MateriaAbilities/RabbitDash/a = new /obj/perk/MateriaAbilities/RabbitDash
						src.contents+=a
				ConstitutionMateria
					name="Constitution Materia"
					desc="Boosts Constitution by +2. Also contains the 'Turtle's Stance' ability."
					materiascore="con"
					New()
						var/obj/perk/MateriaAbilities/TurtleStance/a = new /obj/perk/MateriaAbilities/TurtleStance
						src.contents+=a
				WisdomMateria
					name="Wisdom Materia"
					desc="Boosts Wisdom by +2. Also contains the 'Dragon's Song' ability."
					materiascore="wis"
					New()
						var/obj/perk/MateriaAbilities/DragonSong/a = new /obj/perk/MateriaAbilities/DragonSong
						src.contents+=a
				IntelligenceMateria
					name="Intelligence Materia"
					desc="Boosts Intelligence by +2. Also contains the 'Snake's Fang' ability."
					materiascore="int"
					New()
						var/obj/perk/MateriaAbilities/SnakeFang/a = new /obj/perk/MateriaAbilities/SnakeFang
						src.contents+=a
				CharismaMateria
					name="Charisma Materia"
					desc="Boosts Charisma by +2. Also contains the 'Phoenix's Blaze' ability. "
					materiascore="cha"
					New()
						var/obj/perk/MateriaAbilities/PhoenixBlaze/a = new /obj/perk/MateriaAbilities/PhoenixBlaze
						src.contents+=a

			AbilityMateria
				icon_state="purple"
				TendrilMateria
					name="Tendril Materia"
					New()
						var/obj/perk/Abilities/GeneralMagicAbilities/Tendril/a=new
						src.contents+=a
				FogMateria
					name="Fog Materia"
					New()
						var/obj/perk/Abilities/GeneralMagicAbilities/Fog/a=new
						src.contents+=a
				JoltMateria
					name="Jolt Materia"
					New()
						var/obj/perk/Abilities/GeneralMagicAbilities/Jolt/a=new
						src.contents+=a
				ImpactMateria
					name="Impact Materia"
					New()
						var/obj/perk/Abilities/GeneralMagicAbilities/Impact/a=new
						src.contents+=a
				LaserMateria
					name="Laser Materia"
					New()
						var/obj/perk/Abilities/GeneralMagicAbilities/Laser/a=new
						src.contents+=a
				FlecheMateria
					name="Fleche Materia"
					New()
						var/obj/perk/Abilities/GeneralMagicAbilities/Fleche/a=new
						src.contents+=a
				RiposteMateria
					name="Riposte Materia"
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Riposte/a=new
						src.contents+=a
				HaloneMateria
					name="Halone Materia"
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Halone/a=new
						src.contents+=a
				StellarCircleMateria
					name="Stellar Circle Materia"
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/StellarCircle/a=new
						src.contents+=a
				ShoutMateria
					name="Shout Materia"
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Shout/a=new
						src.contents+=a
				JechtShotMateria
					name="Jecht Shot"
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Ranged/JechtShot/a=new
						src.contents+=a
				JechtBeamMateria
					name="Jecht Beam"
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Ranged/JechtBeam/a=new
						src.contents+=a


			BlueMateria
				icon_state="blue"
				FireMateriaI
					name="Fire I"
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/a=new
						src.contents+=a
				FireMateriaII
					name="Fire II"
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/a=new
						var/obj/perk/Abilities/BlackMagic/Flame/Firaga/b=new
						src.contents+=a
						src.contents+=b
				FireMateriaIII
					name="Fire III"
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/a=new
						var/obj/perk/Abilities/BlackMagic/Flame/Firaga/b=new
						var/obj/perk/Abilities/BlackMagic/Flame/Firaja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				WaterMateriaI
					name="Water I"
					New()
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/a=new
						src.contents+=a
				WaterMateriaII
					name="Water II"
					New()
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/a=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterga/b=new
						src.contents+=a
						src.contents+=b
				WaterMateriaIII
					name="Water III"
					New()
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/a=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterga/b=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				ThunderMateriaI
					name="Thunder I"
					New()
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/a=new
						src.contents+=a
				ThunderMateriaII
					name="Thunder II"
					New()
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/a=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaga/b=new
						src.contents+=a
						src.contents+=b
				ThunderMateriaIII
					name="Thunder III"
					New()
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/a=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaga/b=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				IceMateriaI
					name="Ice I"
					New()
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzara/a=new
						src.contents+=a
				IceMateriaII
					name="Ice II"
					New()
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzara/a=new
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzaga/b=new
						src.contents+=a
						src.contents+=b
				IceMateriaIII
					name="Ice III"
					New()
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzara/a=new
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzaga/b=new
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				EarthMateriaI
					name="Earth I"
					New()
						var/obj/perk/Abilities/Geomancer/Earth/Stonra/a=new
						src.contents+=a
				EarthMateriaII
					name="Earth II"
					New()
						var/obj/perk/Abilities/Geomancer/Earth/Stonra/a=new
						var/obj/perk/Abilities/Geomancer/Earth/Stoneaga/b=new
						src.contents+=a
						src.contents+=b
				EarthMateriaIII
					name="Earth III"
					New()
						var/obj/perk/Abilities/Geomancer/Earth/Stonra/a=new
						var/obj/perk/Abilities/Geomancer/Earth/Stoneaga/b=new
						var/obj/perk/Abilities/Geomancer/Earth/Stonaja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				FlareMateria
					name="Flare III"
					New()
						var/obj/perk/Abilities/BlackMagic/Energy/Flare/a=new
						src.contents+=a
				DrainMateria
					name="Drain"
					New()
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drain/a=new
						src.contents+=a
				OsmoseMateria
					name="Osmose"
					New()
						var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmose/a=new
						src.contents+=a

			GreenMateria
				icon_state="green"
				CureMateriaI
					name="Cure I"
					New()
						var/obj/perk/Abilities/WhiteMagic/Healing/Cura/a=new
						src.contents+=a
				CureMateriaII
					name="Cure II"
					New()
						var/obj/perk/Abilities/WhiteMagic/Healing/Cura/a=new
						src.contents+=a
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/b=new
						src.contents+=b
				CureMateriaIII
					name="Cure III"
					New()
						var/obj/perk/Abilities/WhiteMagic/Healing/Cura/a=new
						src.contents+=a
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/b=new
						src.contents+=b
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaja/c=new
						src.contents+=c
				ProtectMateriaI
					name="Protect I"
					New()
						var/obj/perk/Abilities/GreenMagic/Protects/Protect/a=new
						src.contents+=a
				RegenMateria
					name="Regen"
					New()
						var/obj/perk/Abilities/WhiteMagic/Healing/Regen/a=new
						src.contents+=a
				RefreshMateria
					name="Refresh"
					New()
						var/obj/perk/Abilities/GreenMagic/Refresh/a=new
						src.contents+=a
				DiaMateriaI
					name="Dia I"
					New()
						var/obj/perk/Abilities/WhiteMagic/Holy/Diara/a=new
						src.contents+=a
				DiaMateriaII
					name="Dia II"
					New()
						var/obj/perk/Abilities/WhiteMagic/Holy/Diara/a=new
						src.contents+=a
						var/obj/perk/Abilities/WhiteMagic/Holy/Diaga/b=new
						src.contents+=b
				DiaMateriaIII
					name="Dia III"
					New()
						var/obj/perk/Abilities/WhiteMagic/Holy/Diara/a=new
						src.contents+=a
						var/obj/perk/Abilities/WhiteMagic/Holy/Diaga/b=new
						src.contents+=b
						var/obj/perk/Abilities/WhiteMagic/Holy/Holy/c=new
						src.contents+=c

			PassiveMateria
				name="Link Materia"
				icon_state="grey"
				rank="Passive"
				desc="When equipped, any equipped Materia holding a spell with a Status effect passively incurs the following effect: if it is a positive status effect, that effect is passively applied to the Materia holder and can not be dispelled. If it is a negative status effect, dealing physical/touch damage to this person prompts a DC 15 Fortitude saving throw. On a failure, the creature who dealt the touch damage is inflicted with the negative status effect. If a Link Materia is equipped alongside a Stat Materia, and the Materia holder is in a party, their party gains the same bonus (but this boost can not stack if multiple party members are utilizing this mechanic.) Contains the Osmose and Drain spells."


obj
	proc
		RandomYellowMateria(var/mob/b)
			var/randomizemat=rand(1,18)
			if(randomizemat>=1 && randomizemat < 4)
				var/obj/item/Materia/StatMateria/StrengthMateria/c=new
				b.contents+=c
				usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizemat>=4 && randomizemat < 7)
				var/obj/item/Materia/StatMateria/DexterityMateria/c=new
				b.contents+=c
				usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizemat>=7 && randomizemat < 10)
				var/obj/item/Materia/StatMateria/ConstitutionMateria/c=new
				b.contents+=c
				usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizemat>=10 && randomizemat < 13)
				var/obj/item/Materia/StatMateria/WisdomMateria/c=new
				b.contents+=c
				usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizemat>=13 && randomizemat < 16)
				var/obj/item/Materia/StatMateria/IntelligenceMateria/c=new
				b.contents+=c
				usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizemat>=16 && randomizemat < 19)
				var/obj/item/Materia/StatMateria/CharismaMateria/c=new
				b.contents+=c
				usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)

obj
	proc
		RandomPurpleMateria(var/mob/b)
			var/randomizemat=rand(1,20)
			var/randomizetier=rand(1,100)
			if(randomizetier>=1 && randomizetier < 50)
				if(randomizemat>= 1 && randomizemat < 6)
					var/obj/item/Materia/AbilityMateria/TendrilMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 6 && randomizemat < 11)
					var/obj/item/Materia/AbilityMateria/FogMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 11 && randomizemat < 15)
					var/obj/item/Materia/AbilityMateria/JoltMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 15 && randomizemat < 17)
					var/obj/item/Materia/AbilityMateria/ImpactMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 17 && randomizemat < 19)
					var/obj/item/Materia/AbilityMateria/LaserMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 19 && randomizemat < 21)
					var/obj/item/Materia/AbilityMateria/RiposteMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizetier>=51 && randomizetier < 101)
				if(randomizemat>= 1 && randomizemat < 6)
					var/obj/item/Materia/AbilityMateria/FlecheMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 6 && randomizemat < 11)
					var/obj/item/Materia/AbilityMateria/HaloneMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 11 && randomizemat < 15)
					var/obj/item/Materia/AbilityMateria/StellarCircleMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 15 && randomizemat < 17)
					var/obj/item/Materia/AbilityMateria/ShoutMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 17 && randomizemat < 19)
					var/obj/item/Materia/AbilityMateria/JechtShotMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>= 19 && randomizemat < 21)
					var/obj/item/Materia/AbilityMateria/JechtBeamMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)



obj
	proc
		RandomBlueMateria(var/mob/b)
			var/randomizemat=rand(1,20)
			var/randomizetier=rand(1,100)
			if(randomizetier>=1 && randomizetier < 33)
				if(randomizemat>=1 && randomizemat < 6)
					var/obj/item/Materia/BlueMateria/FireMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=6 && randomizemat < 10)
					var/obj/item/Materia/BlueMateria/WaterMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=10 && randomizemat < 12)
					var/obj/item/Materia/BlueMateria/ThunderMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=12 && randomizemat < 16)
					var/obj/item/Materia/BlueMateria/IceMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=15 && randomizemat < 17)
					var/obj/item/Materia/BlueMateria/EarthMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=16 && randomizemat < 21)
					var/obj/item/Materia/BlueMateria/DrainMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizetier>=34 && randomizetier < 66)
				if(randomizemat>=1 && randomizemat < 6)
					var/obj/item/Materia/BlueMateria/FireMateriaII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=6 && randomizemat < 10)
					var/obj/item/Materia/BlueMateria/WaterMateriaII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=10 && randomizemat < 12)
					var/obj/item/Materia/BlueMateria/ThunderMateriaII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=12 && randomizemat < 16)
					var/obj/item/Materia/BlueMateria/IceMateriaII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=15 && randomizemat < 17)
					var/obj/item/Materia/BlueMateria/EarthMateriaII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=16 && randomizemat < 21)
					var/obj/item/Materia/BlueMateria/OsmoseMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizetier>=67 && randomizetier < 101)
				if(randomizemat>=1 && randomizemat < 6)
					var/obj/item/Materia/BlueMateria/FireMateriaIII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=6 && randomizemat < 10)
					var/obj/item/Materia/BlueMateria/WaterMateriaIII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=10 && randomizemat < 12)
					var/obj/item/Materia/BlueMateria/ThunderMateriaIII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=12 && randomizemat < 16)
					var/obj/item/Materia/BlueMateria/IceMateriaIII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=15 && randomizemat < 17)
					var/obj/item/Materia/BlueMateria/EarthMateriaIII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=16 && randomizemat < 21)
					var/obj/item/Materia/BlueMateria/FlareMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)

obj
	proc
		RandomGreenMateria(var/mob/b)
			var/randomizemat=rand(1,20)
			var/randomizetier=rand(1,100)
			if(randomizetier>=1 && randomizetier < 33)
				if(randomizemat>=1 && randomizemat < 6)
					var/obj/item/Materia/GreenMateria/CureMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=6 && randomizemat < 10)
					var/obj/item/Materia/GreenMateria/ProtectMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=10 && randomizemat < 12)
					var/obj/item/Materia/GreenMateria/RegenMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=12 && randomizemat < 14)
					var/obj/item/Materia/GreenMateria/RefreshMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=14 && randomizemat < 21)
					var/obj/item/Materia/GreenMateria/DiaMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizetier>=34 && randomizetier < 66)
				if(randomizemat>=1 && randomizemat < 6)
					var/obj/item/Materia/GreenMateria/CureMateriaII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=6 && randomizemat < 10)
					var/obj/item/Materia/GreenMateria/ProtectMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=10 && randomizemat < 12)
					var/obj/item/Materia/GreenMateria/RegenMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=12 && randomizemat < 14)
					var/obj/item/Materia/GreenMateria/RefreshMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=14 && randomizemat < 21)
					var/obj/item/Materia/GreenMateria/DiaMateriaII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
			if(randomizetier>=67 && randomizetier < 101)
				if(randomizemat>=1 && randomizemat < 6)
					var/obj/item/Materia/GreenMateria/CureMateriaIII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=6 && randomizemat < 10)
					var/obj/item/Materia/GreenMateria/ProtectMateriaI/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=10 && randomizemat < 12)
					var/obj/item/Materia/GreenMateria/RegenMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=12 && randomizemat < 14)
					var/obj/item/Materia/GreenMateria/RefreshMateria/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
				if(randomizemat>=14 && randomizemat < 21)
					var/obj/item/Materia/GreenMateria/DiaMateriaIII/c=new
					b.contents+=c
					usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)

