obj
	item
		var/jewelery
		var/initialized=0
		var/gilded=0
		Weapon
			Click()
				if(istype(loc, /obj/playershops/shoptable))
					winset(usr,"playershop.selected","text=\"Selected: [src.name]\"")
					winset(usr,"playershop.desc","text=\"[src.desc]\"")
					winset(usr,"playershop.lore","text=\"[src.lore]\"")
					winset(usr,"playershop.enchant","text=\"[src.enchantment]\"")
					return
				if(istype(loc, /obj/npc))
					var/obj/npc/z = loc
					var/aoresult
					var/aresult
					var/amod
					var/doresult
					var/dmod
					var/dresult
					var/critdam
					aoresult=rand(1,20)
					amod=Checkdamtype(src.damsource,z)
					if(src.typing=="magical")
						aresult=aoresult+src.addhit+amod+usr.rankbonus+z.mab
					else
						aresult=aoresult+src.addhit+amod+usr.rankbonus+z.pab
					doresult=rand(src.range1,src.range2)
					dmod=Checkdamtype(src.damsource,usr)
					if(src.typing=="magical")
						dresult=doresult+dmod+src.adddam+z.mdb
					else
						dresult=doresult+dmod+src.adddam+z.pdb
					critdam=dresult+doresult
					if(aoresult==20)
						view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit!","icout")
					else
						view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br>Tile Range:[src.range]","output1")
						view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br>Tile Range:[src.range]","icout")

				if(src.instore)
					switch(alert(usr,"[src.desc] Cost:[src.shopprice]",,"Buy","Cancel"))
						if("Buy")
							if(src.amount>=1)
								var/amocho=input("How many?") as num
								if(amocho<0)
									alert(usr,"You need a positive number here.")
								var/adjprice=(src.price*=src.shopprice)
								if(usr.money>=adjprice)
									usr.money-=adjprice
									for(var/obj/item/i in usr.contents)
										if(i.name==src.name)
											i.amount+=amocho
											usr<<output("You purchased [amocho] [src.name]/s","oocout")
											return
									var/obj/item/i=copyatom(src)
									i.amount=amocho
									i.instore=0
									usr.contents+=i
									usr<<output("You purchased [amocho] [src.name]/s","oocout")
								else
									alert(usr,"You don't enough for that many.")
									return
							else
								if(usr.money>=src.shopprice)
									usr.money-=src.shopprice
									var/obj/item/i=copyatom(src)
									i.instore=0
									usr.contents+=i
									usr<<output("You purchased [src.name]","oocout")

								else
									alert(usr,"You don't have enough for that")
									return
						if("Cancel")
							return
				if(istype(loc, /obj/npc))
					return
				if(src in usr.contents)
					return
				if(usr in view(1,src))
					log_action("PICKUP: [key_name(usr)] picked up [src]")
					view(usr) << output("[usr.name] has picked up [src.name]!","icout")
					src.Move(usr)
					usr.Refreshinventoryscreen()

			New()
				if(src.name=="Bronze")
					src.name="Bronze [src.weapontype]"
					src.weptier="Bronze"
				if(src.name=="Iron")
					src.name="Iron [src.weapontype]"
					src.weptier="Iron"
				if(src.name=="Steel")
					src.name="Steel [src.weapontype]"
					src.weptier="Steel"
				if(src.name=="Mythril")
					src.name="Mythril [src.weapontype]"
					src.weptier="Mythril"
				if(src.name=="Adamantine")
					src.name="Mythic [src.weapontype]"
					src.weptier="Adamantine"
				if(src.name=="Orichalcum")
					src.name="Legendary [src.weapontype]"
					src.weptier="Orichalcum"
				if(!modified)
					rebuild()

			weapon=1
			equipable=1
			icon='Icons/Items/Longsword.dmi'

			Jeweler
				weapon_system = FALSE
				jewelery=1
				equiptype="accessory"
				weapontype="accessory"
				weptier="Accessory"
				SilverRing
					icon='Icons/Jewelery/Silverring.png'
					name="Silver Ring"
					desc="While worn, a Silver Ring grants a bonus of +2 to Saving Throws. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				GoldRing
					icon='Icons/Jewelery/Goldring.png'
					name="Gold Ring"
					desc="While worn, a Gold Ring grants a bonus of +3 to Saving Throws. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				SilverNecklace
					icon='Icons/Jewelery/Silvernecklace.png'
					name="Silver Necklace"
					desc="While worn, a Silver Necklace grants a bonus of +2 MP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				GoldNecklace
					icon='Icons/Jewelery/Goldnecklace.png'
					name="Gold Necklace"
					desc="While worn, a Gold Necklace grants a bonus of +4 MP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				SilverEarring
					icon='Icons/Jewelery/Silverearring.png'
					name="Silver Earring"
					desc="While worn, a set of Silver Earrings grants a bonus of, and +1 PAB and MAB. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				GoldEarring
					icon='Icons/Jewelery/Goldearring.png'
					name="Gold Earring"
					desc="While worn, a set of Gold Earrings grants a bonus of, and +2 to PAB and MAB. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				SilverBracelet
					icon='Icons/Jewelery/Silverbracelet.png'
					name="Silver Bracelet"
					desc="While worn, a Silver Bracelet grants a bonus of +2 HP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				GoldBracelet
					icon='Icons/Jewelery/Goldbracelet.png'
					name="Gold Bracelet"
					desc="While worn, a Gold Bracelet grants a bonus of +4 HP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				BronzeBangle
					icon='Icons/Jewelery/Bronzebangle.png'
					name="Bronze Bangle"
					desc="While worn, a Bronze Bangle grants a bonus of 2 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				MythrilBangle
					icon='Icons/Jewelery/Mythrilbangle.png'
					name="Mythril Bangle"
					desc="While worn, a Mythril Bangle grants a bonus of 3 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				AdamantineBangle
					name="Adamantine Bangle"
					desc="While worn, an Adamantine Bangle grants a bonus of 5 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
					icon='Icons/Jewelery/Adamantinebangle.png'


obj
	var/armor
	item
		Weapon
			Armor
				weapon_system = FALSE
				weapon=0
				armor=1
				equiptype="armor"
				Shield
					icon='Icons/Items/Shield.dmi'
					desc="A small Shield. Wielding a Shield in one hand will grant global damage reduction! A Shield grants 1 DR per Metal Tier."
					equiptype="1h"
					weapontype="Shield"
					Bronze
						name="Bronze Shield"
						weptier="Bronze"
					Iron
						name="Iron Shield"
						weptier="Iron"
					Steel
						name="Steel Shield"
						weptier="Steel"
					Mythril
						name="Mythril Shield"
						weptier="Mythril"
					Adamantine
						name="Adamantine Shield"
						weptier="Adamantine"
					Orichalcum
						weptier="Orichalcum"
						name="Orichalcum Shield"
				TowerShield
					icon='Icons/Items/TowerShield.dmi'
					desc="A large Tower shield. Wielding a Tower Shield in one hand will grant immense global damage reduction (2 DR per Metal Tier), but you are considered encumbered, and incur disadvantage on Stealth Checks, DEX Checks, and Reflex saving throws without proper perks."
					equiptype="1h"
					weapontype="Tower Shield"
					Bronze
						name="Bronze Tower Shield"
						weptier="Bronze"
					Iron
						name="Iron Tower Shield"
						weptier="Iron"
					Steel
						name="Steel Tower Shield"
						weptier="Steel"
					Mythril
						name="Mythril Tower Shield"
						weptier="Mythril"
					Adamantine
						name="Adamantine Tower Shield"
						weptier="Adamantine"
					Orichalcum
						weptier="Orichalcum"
						name="Orichalcum Tower Shield"

				LightArmor
					equiptype="armor"
					weapontype="Light Armor"
					armortype="Light"
					icon='Icons/Items/LightArmor.dmi'
					desc="A set of Light Armor. Its defensive boons are minimal compared to Medium or Heavy, but it does not encumber its wearer at all. Bronze: 1 AC | Iron: 2 AC | Steel: 3 AC | Mythril: 4 AC | Adamantine: 5 AC | Orichalcum: 6 AC"
					Bronze
						weptier="Bronze"
						name="Bronze Light Armor"
					Iron
						weptier="Iron"
						name="Iron Light Armor"
					Steel
						weptier="Steel"
						name="Steel Light Armor"
					Mythril
						weptier="Mythril"
						name="Mythril Light Armor"
					Adamantine
						weptier="Adamantine"
						name="Adamantine Light Armor"
					Orichalcum
						weptier="Orichalcum"
						name="Orichalcum Light Armor"
				MediumArmor
					equiptype="armor"
					weapontype="Medium Armor"
					icon='Icons/Items/MediumArmor.dmi'
					armortype="Medium"
					desc="A set of Medium armor. It defends the wearer but does not permit as easy of evasive movements. Disadvantage to stealth related checks while wearing it. Bronze: 2 AC, 2 DR | Iron: 3 AC, 4 DR | Steel: 4 AC, 6 DR | Mythril: 5 AC, 8 DR | Adamantine: 6 AC, 10 DR | Orichalcum: 7 AC, 12 DR"
					Bronze
						weptier="Bronze"
						name="Bronze Medium Armor"
					Iron
						weptier="Iron"
						name="Iron Medium Armor"
					Steel
						weptier="Steel"
						name="Steel Medium Armor"
					Mythril
						weptier="Mythril"
						name="Mythril Medium Armor"
					Adamantine
						weptier="Adamantine"
						name="Adamantine Medium Armor"
					Orichalcum
						weptier="Orichalcum"
						name="Orichalcum Medium Armor"
				HeavyArmor
					equiptype="armor"
					weapontype="Heavy Armor"
					icon='Icons/Items/HeavyArmor.dmi'
					desc="A set of Heavy armor. Its defensive boons are quite massive, but it has heavy side effects. Disadvantage on DEX checks, Stealth checks, Reflex saving throws, and suffer -2 movement speed (Min. 2). Bronze: 3 AC, 4 DR | Iron: 4 AC, 8 DR | Steel: 5 AC, 12 DR | Mythril: 6 AC, 16 DR | Adamantine: 7 AC, 20 DR | Orichalcum: 8 AC, 24 DR"
					armortype="Heavy"
					Bronze
						weptier="Bronze"
						name="Bronze Heavy Armor"
					Iron
						name="Iron Heavy Armor"
						weptier="Iron"
					Steel
						name="Steel Heavy Armor"
						weptier="Steel"
					Mythril
						name="Mythril Heavy Armor"
						weptier="Mythril"
					Adamantine
						name="Adamantine Heavy Armor"
						weptier="Adamantine"
					Orichalcum
						name="Orichalcum Heavy Armor"
						weptier="Orichalcum"
obj
	item
		Weapon
			var
				damagescales=0
				scaling=1
				armortype=null

obj
var/weapontype
obj
	proc
		AssignCraftinginfo(var/obj/recipes/a)
			if(a.name=="Bronze")
				a.name="Bronze [a.weapontype]"
				a.mat1="Bronze Ingot"
				a.weptier="Bronze"
				a.amount1=12
			if(a.name=="Iron")
				a.name="Iron [a.weapontype]"
				a.mat1="Iron Ingot"
				a.mat2="Bronze Ingot"
				a.weptier="Iron"
				a.amount1=8
				a.amount2=12
			if(a.name=="Steel")
				a.name="Steel [a.weapontype]"
				a.mat1="Steel Ingot"
				a.mat2="Bronze Ingot"
				a.mat3="Iron Ingot"
				a.weptier="Steel"
				a.amount1=8
				a.amount2=12
				a.amount3=6
			if(a.name=="Mythril")
				a.name="Mythril [a.weapontype]"
				a.mat1="Mythril Ingot"
				a.mat2="Bronze Ingot"
				a.mat3="Iron Ingot"
				a.mat4="Steel Ingot"
				a.mat5="Esper Soul"
				a.weptier="Mythril"
				a.amount1=8
				a.amount2=10
				a.amount3=10
				a.amount4=10
				a.amount5=1
			if(a.name=="Adamantine")
				a.name="Mythic [a.weapontype]"
				a.mat1="Adamantine Ingot"
				a.mat2="Bronze Ingot"
				a.mat3="Iron Ingot"
				a.mat4="Steel Ingot"
				a.mat5="Mythril Ingot"
				a.mat6="Esper Soul"
				a.mat7="Gold Ingot"
				a.weptier="Adamantine"
				a.amount1=8
				a.amount2=12
				a.amount3=12
				a.amount4=12
				a.amount5=6
				a.amount6=2
				a.amount7=10
			if(a.name=="Orichalcum")
				a.name="Legendary [a.weapontype]"
				a.mat1="Orichalcum Ingot"
				a.weptier="Orichalcum"
				a.mat2="Bronze Ingot"
				a.mat3="Iron Ingot"
				a.mat4="Steel Ingot"
				a.mat5="Mythril Ingot"
				a.mat6="Adamantine Ingot"
				a.mat7="Esper Soul"
				a.mat8="Platinum Ingot"
				a.amount1=10
				a.amount1=8
				a.amount2=20
				a.amount3=20
				a.amount4=20
				a.amount5=8
				a.amount6=8
				a.amount7=3
				a.amount8=5
