mob
	verb
		Stockwindow()
			set hidden = 1
			var/row
			winset(usr,"Stockwindow","is-visible=true")
			winset(usr,"Stockwindow.Stockgrid","text=\"[usr.money]\"")
			for(var/obj/item/stock/Stockgem/A in usr.contents)
				row++
				winset(usr, "Stockgrid", "current-cell=1,[row]")
				src << output(A,"Stockgrid")
				if(A.stock>0)
					A.suffix="[A.stock]"
				winset(usr, "Stockgrid", "current-cell=2,[row]")
				src << output(A.suffix,"Stockgrid")




obj
	proc
		Caststockmagic(var/mob/z, var/obj/perk/b)
			var/aoresult
			var/aresult
			var/amod
			var/doresult
			var/dmod
			var/dresult
			var/critdam
			var/abilitydamage
			var/flash={"<font color=#EC2323>[z.name] has casted a spell using STOCK!: <a href="byond://?src=\ref[z]&action=stock&value=\ref[b]"><font color=#FFFFFF>[b]</a>!!"}
			view() << output("[flash]","icout")
			if(b.atype=="heal")
				doresult=b.raw_attack_damage_roll()
				dresult=doresult+b.addhit
				view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[z.textcolor]>[b.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
			if(b.atype=="curada")
				var/curadabonus=z.mhp*0.5
				doresult=b.raw_attack_damage_roll()
				dresult=doresult+curadabonus
				view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[z.textcolor]>[b.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
			if(b.atype=="save")
				doresult=b.raw_attack_damage_roll()
				amod=Checkdamtype(b.damsource,z)
				dmod=Checkdamtype(b.damsource,z)
				abilitydamage=b.raw_attack_damage_roll()
				if(b.typing=="magical")
					aresult=b.basecheck+amod+z.rankbonus+b.addhit+3
					dresult=abilitydamage+dmod+z.mdb+b.adddam+5
				else
					aresult=b.basecheck+amod+z.rankbonus+b.addhit
					dresult=abilitydamage+dmod+z.pdb+b.adddam
					view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[z.textcolor]>[b.name]<font color=white> ability!  Saving throw: <font color=#8EF5DE><b>[aresult] [b.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>0 Cost! Used as Stock cast!</b> | Tile Range:[b.range]","icout")
			if(b.atype=="standard")
				aoresult=rand(1,20)
				amod=Checkdamtype(b.damsource,z)
				if(b.typing=="magical")
					aresult=aoresult+b.addhit+amod+z.rankbonus+z.mab+3
				else
					aresult=aoresult+b.addhit+amod+z.rankbonus+z.pab+3
				doresult=b.raw_attack_damage_roll()
				dmod=Checkdamtype(b.damsource,z)
				if(b.typing=="magical")
					dresult=doresult+dmod+b.adddam+z.mdb+5
				else
					dresult=doresult+dmod+b.adddam+z.pdb+5
				critdam=dresult+doresult
				if(aoresult>=b.critrange)
					view()<<output("<font size=1><font color=[z.textcolor]>[z] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[b.name]<font color=white> ability! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>0 Cost! Used as Stock cast! [b.costtype]</b>","icout")
				else
					view()<<output("<font size=1><font color=[z.textcolor]>[z] <font color=white>rolled an attack roll, using the <font color=[z.textcolor]>[b.name]<font color=white> ability!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>0 Cost! Used as Stock cast!</b> | Tile Range:[b.range]","output1")
					view()<<output("<font size=1><font color=[z.textcolor]>[z] <font color=white>rolled an attack roll, using the <font color=[z.textcolor]>[b.name]<font color=white> ability! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>0 Cost! Used as Stock cast!</b> | Tile Range:[b.range]","icout")



		Castfire(var/mob/a,var/obj/item/stock/Stockgem/Firegem/b)
			var/list/tier=list("Fira","Firaga","Firaja")
			var/tierchoice=input(a,"What tier of Fire spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Fira")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Fire gems, you need at least 1 to cast Fira!")
						return
				if("Firaga")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/BlackMagic/Flame/Firaga/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Fire gems to cast Firaga! You need at least 5!")
						return
				if("Firaja")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/BlackMagic/Flame/Firaja/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Fire gems to cast Firaja! You need at least 10!")
						return
		Castwater(var/mob/a, var/obj/item/stock/Stockgem/Watergem/b)
			var/list/tier=list("Watera","Waterga","Waterja")
			var/tierchoice=input(a,"What tier of Water spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Watera")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Water gems, you need at least 1 to cast Watera!")
						return
				if("Waterga")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterga/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Water gems to cast Waterga! You need at least 5!")
						return
				if("Waterja")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Water gems to cast Waterja! You need at least 10!")
						return
		Castthunder(var/mob/a, var/obj/item/stock/Stockgem/Thundergem/b)
			var/list/tier=list("Thundara","Thundaga","Thundaja")
			var/tierchoice=input(a,"What tier of Water spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Thundara")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Thunder gems, you need at least 1 to cast Thundara!")
						return
				if("Thundaga")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaga/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Thunder gems to cast Thundaga! You need at least 5!")
						return
				if("Thundaja")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Thunder gems to cast Thundaja! You need at least 10!")
						return
		Castice(var/mob/a, var/obj/item/stock/Stockgem/Icegem/b)
			var/list/tier=list("Blizzara","Blizzaga","Blizzaja")
			var/tierchoice=input(a,"What tier of Ice spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Blizzara")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzara/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Ice gems, you need at least 1 to cast Blizzara!")
						return
				if("Blizzaga")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzaga/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Ice gems to cast Blizzaga! You need at least 5!")
						return
				if("Blizzaja")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Thunder gems to cast Blizzaja! You need at least 10!")
						return
		Castearth(var/mob/a, var/obj/item/stock/Stockgem/Earthgem/b)
			var/list/tier=list("Stonra","Stoneaga","Stonaja")
			var/tierchoice=input(a,"What tier of Earth spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Stonra")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/Geomancer/Earth/Stonra/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Earth gems, you need at least 1 to cast Stonra!")
						return
				if("Stoneaga")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/Geomancer/Earth/Stoneaga/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Earth gems to cast Stoneaga! You need at least 5!")
						return
				if("Stonaja")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/Geomancer/Earth/Stonaja/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Thunder gems to cast Stonaja! You need at least 10!")
						return
		Castprotect(var/mob/a, var/obj/item/stock/Stockgem/Protectiongem/b)
			var/list/tier=list("Protect","Shell","Bubble")
			var/tierchoice=input(a,"What tier of Earth spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Protect")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/GreenMagic/Protects/Protect/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Protection gems, you need at least 1 to cast Protect!")
						return
				if("Shell")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/GreenMagic/Shells/Shell/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have any Protection gems, you need at least 1 to cast Shell!")
						return
				if("Bubble")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/GreenMagic/Bubble/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Protection gems to cast Bubble! You need at least 5!")
						return
		Castcure(var/mob/a, var/obj/item/stock/Stockgem/Curegem/b)
			var/list/tier=list("Cura","Curaga","Curaja")
			var/tierchoice=input(a,"What tier of Cure spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Cura")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/WhiteMagic/Healing/Cura/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Cure gems, you need at least 1 to cast Protect!")
						return
				if("Curaga")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Cure gems, you need at least 5 to cast Curaga!")
						return
				if("Curaja")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaja/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Cure gems to cast Curaja! You need at least 10!")
						return
		Castdia(var/mob/a, var/obj/item/stock/Stockgem/Diagem/b)
			var/list/tier=list("Dia","Diara","Diaga")
			var/tierchoice=input(a,"What tier of Cure spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Dia")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/WhiteMagic/Holy/Dia/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Dia gems, you need at least 1 to cast Dia!")
						return
				if("Diara")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/WhiteMagic/Holy/Diara/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Dia gems, you need at least 5 to cast Diara!")
						return
				if("Diaga")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/WhiteMagic/Holy/Diaga/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Cure gems to cast Diaga! You need at least 10!")
						return
		Castbio(var/mob/a, var/obj/item/stock/Stockgem/Biogem/b)
			var/list/tier=list("Bio","Bioara","Bioaga")
			var/tierchoice=input(a,"What tier of Bio spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Bio")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bio/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have any Bio gems, you need at least 1 to cast Bio!")
						return
				if("Bioara")
					if(b.stock>=5)
						b.stock-=5
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioara/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Bio gems, you need at least 5 to cast Bioara!")
						return
				if("Bioaga")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioaga/f3=new
						Caststockmagic(a,f3)
					else
						alert(a,"You do not have enough Bio gems to cast Bioaga! You need at least 10!")
						return
		Castflare(var/mob/a, var/obj/item/stock/Stockgem/Flaregem/b)
			var/list/tier=list("Flare","Scathe")
			var/tierchoice=input(a,"What tier of Flare spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Flare")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/BlackMagic/Energy/Flare/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have enough Flare gems, you need at least 10 to cast Flare!")
						return
				if("Scathe")
					if(b.stock>=15)
						b.stock-=15
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Flare gems, you need at least 15 to cast Scathe!")
						return
		Castosmose(var/mob/a, var/obj/item/stock/Stockgem/Osmosegem/b)
			var/list/tier=list("Osmose","Osmosega")
			var/tierchoice=input(a,"What tier of Osmose spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Osmose")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmose/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have enough Osmose gems, you need at least 1 to cast Osmose!")
						return
				if("Osmosega")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmosega/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Osmose gems, you need at least 10 to cast Osmosega!")
						return
		Castdrain(var/mob/a, var/obj/item/stock/Stockgem/Draingem/b)
			var/list/tier=list("Drain","Drainga")
			var/tierchoice=input(a,"What tier of Drain spell would you like to cast?") as anything in tier
			switch(tierchoice)
				if("Drain")
					if(b.stock>=1)
						b.stock-=1
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drain/f1=new
						Caststockmagic(a,f1)
					else
						alert(a,"You do not have enough Drain gems, you need at least 1 to cast Drain!")
						return
				if("Drainga")
					if(b.stock>=10)
						b.stock-=10
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drainga/f2=new
						Caststockmagic(a,f2)
					else
						alert(a,"You do not have enough Drain gems, you need at least 10 to cast Drainga!")
						return


obj
	item
		stock
			Stockgem
				var/stock=0
				stockgem=1
				amount=5
				market_value = 200
				Firegem
					icon='Icons/Perk/Fire.png'
					name="Fire"
				Watergem
					icon='Icons/Perk/Water.png'
					name="Water"
				Thundergem
					icon='Icons/Perk/Thunder.png'
					name="Thunder"
				Icegem
					icon='Icons/Perk/Ice.png'
					name="Ice"
				Earthgem
					icon='Icons/Perk/Stone.png'
					name="Earth"
				Protectiongem
					icon='Icons/Perk/Protect.png'
					name="Protection"
				Curegem
					icon='Icons/Perk/Cure.png'
					name="Cure"
				Diagem
					icon='Icons/Perk/Dia.png'
					name="Dia"
				Biogem
					icon='Icons/Perk/Bio.png'
					name="Bio"
				Flaregem
					icon='Icons/Perk/Flare.png'
					name="Flare"
				Osmosegem
					icon='Icons/Perk/Osmose.png'
					name="Osmose"
				Draingem
					icon='Icons/Perk/Drain.png'
					name="Drain"

obj
	perk
		StockEmpowerment
			icon='Icons/Perk/Stockempower.png'
			name="Stock Empowerment"
			desc="This person has learned to use the 'Stock Empowerment' ability - which allows them to consume 10 Stock Gems of a particular element as a bonus action, to gain a temporary boost dependent on the element in question for the duration of the current battle. You may only have a total of 3 Stock Empowerment bonuses active per battle. Fire: +5 global damage. Water: +5 to saving throws. Ice: +2 global to hit. Thunder: +3 AC. Bio: Immunity to Poison, Sleep, Silence, Blind. Cure: 5 HP regeneration per turn. Protect: +1 AC, +4 physical damage reduction, +4 magical damage reduction. Requires completion of at least 3 3 star rank or higher Assignments. SeeD only."
			ptype="Unique"
			cat="Unique"
			verb
				Empower()
					var/list/buffs=list("Fire","Water","Ice","Thunder","Bio","Cure","Protect")
					var/buffchoice = input(usr,"Which element would you like to draw power from? This will cost 10 of that stock.") as anything in buffs
					switch(buffchoice)
						if("Fire")
							for(var/obj/item/stock/Stockgem/Firegem/a in usr.contents)
								if(a.stock>=10)
									a.stock-=10
									view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b> has drawn upon the power of Fire to gain a bonus of +5 global damage for the duration of the battle!","icout")
								else
									alert(usr,"You do not have enough stock in that element to draw out its power!")
									return
						if("Water")
							for(var/obj/item/stock/Stockgem/Watergem/a in usr.contents)
								if(a.stock>=10)
									a.stock-=10
									view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b> has drawn upon the power of Water to gain a bonus of +5 to saving throws for the duration of the battle!","icout")
								else
									alert(usr,"You do not have enough stock in that element to draw out its power!")
									return
						if("Ice")
							for(var/obj/item/stock/Stockgem/Icegem/a in usr.contents)
								if(a.stock>=10)
									a.stock-=10
									view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b> has drawn upon the power of Ice to gain a bonus of +2 to hit for the duration of the battle!","icout")
								else
									alert(usr,"You do not have enough stock in that element to draw out its power!")
									return
						if("Thunder")
							for(var/obj/item/stock/Stockgem/Thundergem/a in usr.contents)
								if(a.stock>=10)
									a.stock-=10
									view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b> has drawn upon the power of Thunder to gain a bonus of +3 to AC for the duration of the battle!","icout")
								else
									alert(usr,"You do not have enough stock in that element to draw out its power!")
									return
						if("Bio")
							for(var/obj/item/stock/Stockgem/Biogem/a in usr.contents)
								if(a.stock>=10)
									a.stock-=10
									view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b> has drawn upon the power of Bio to gain immunity to Poison, Sleep, Silence, and Blind for the duration of the battle!","icout")
								else
									alert(usr,"You do not have enough stock in that element to draw out its power!")
									return
						if("Cure")
							for(var/obj/item/stock/Stockgem/Curegem/a in usr.contents)
								if(a.stock>=10)
									a.stock-=10
									view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b> has drawn upon the power of Holy to gain a bonus of +5 HP regeneration per turn for the duration of the battle!","icout")
								else
									alert(usr,"You do not have enough stock in that element to draw out its power!")
									return
						if("Protect")
							for(var/obj/item/stock/Stockgem/Protectiongem/a in usr.contents)
								if(a.stock>=10)
									a.stock-=10
									view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b> has drawn upon the power of Protection to gain a bonus of +1 AC, +4 physical damage reduction, and +4 magical damage reduction for the duration of the battle!","icout")
								else
									alert(usr,"You do not have enough stock in that element to draw out its power!")
									return
					UpdateStock(usr)


obj
	perk
		Stockcasting
			var/schoice
			icon='Icons/Perk/Stockcast.png'
			name="Stock Casting"
			ptype="Unique"
			cat="Unique"
			desc="This person has learned the art of Stock Casting, and is able to utilize 'Stock' gems in order to cast spells of a particular element or magic type, depending on the amount of gems consumed in order to cast the spell. This caps at the B Rank level of a given element. This allows you to temporarily cast spells you do not know. The higher the level of the spell, the more Stock it will cost to cast. Requires completion of at least a single Assignment of any star rank. SeeD only."
			verb
				Cast()
					var/list/stocks=list("Fire","Water","Thunder","Earth","Protection","Cure","Dia","Bio","Flare","Osmose","Drain")
					var/stockchoice = input(usr,"What type of Stock would you like to cast?") as anything in stocks
					switch(stockchoice)
						if("Fire")
							for(var/obj/item/stock/Stockgem/Firegem/a in usr.contents)
								Castfire(usr,a)
						if("Water")
							for(var/obj/item/stock/Stockgem/Watergem/a in usr.contents)
								Castwater(usr,a)
						if("Thunder")
							for(var/obj/item/stock/Stockgem/Thundergem/a in usr.contents)
								Castthunder(usr,a)
						if("Earth")
							for(var/obj/item/stock/Stockgem/Earthgem/a in usr.contents)
								Castearth(usr,a)
						if("Ice")
							for(var/obj/item/stock/Stockgem/Icegem/a in usr.contents)
								Castice(usr,a)
						if("Protection")
							for(var/obj/item/stock/Stockgem/Protectiongem/a in usr.contents)
								Castprotect(usr,a)
						if("Cure")
							for(var/obj/item/stock/Stockgem/Curegem/a in usr.contents)
								Castcure(usr,a)
						if("Dia")
							for(var/obj/item/stock/Stockgem/Diagem/a in usr.contents)
								Castdia(usr,a)
						if("Bio")
							for(var/obj/item/stock/Stockgem/Biogem/a in usr.contents)
								Castbio(usr,a)
						if("Flare")
							for(var/obj/item/stock/Stockgem/Flaregem/a in usr.contents)
								Castflare(usr,a)
						if("Osmose")
							for(var/obj/item/stock/Stockgem/Osmosegem/a in usr.contents)
								Castosmose(usr,a)
						if("Drain")
							for(var/obj/item/stock/Stockgem/Draingem/a in usr.contents)
								Castdrain(usr,a)
					UpdateStock(usr)

obj
	perk
		Stockdraw
			name="Stock Draw"
			icon='Icons/Perk/Stockcast.png'
			ptype="Unique"
			cat="Unique"
			desc="This person has learned to use the 'Stock Draw' ability - which allows them to generate up to 12 Stock Gems of a random element, once every 24 hours ; thus allowing them to distribute these gems amongst their squad, sell them to other SeeD members, or use them to cast Stock spells themselves.Doing so in combat is a free action. Requires completion of at least 1 3 star rank or higher Assignment. SeeD only."
			verb
				Draw()
					var/rand1=rand(1,4)
					var/rand2=rand(1,4)
					var/rand3=rand(1,4)
					var/list/draw1=list("Fire","Water","Ice","Thunder","Earth","Protection","Cure")
					var/list/draw2=list("Fire","Water","Ice","Thunder","Earth","Protection","Cure","Dia","Bio","Drain","Osmose")
					var/list/draw3=list("Fire","Water","Ice","Thunder","Earth","Protection","Cure","Dia","Bio","Drain","Osmose","Flare")
					if(usr.stockdrawn==0)
						var/drawchoice1 = input(usr,"What type of Stock would you like to draw?") as anything in draw1
						var/drawchoice2 = input (usr, "What type of Stock would you like to draw?") as anything in draw2
						var/drawchoice3 = input (usr, "What type of Stock would you like to draw? Gain 2 extra Fire, Water, Thunder, Earth, or Ice gems if selecting them!!") as anything in draw3
						switch(drawchoice1)
							if("Fire")
								for(var/obj/item/stock/Stockgem/Firegem/a in usr.contents)
									a.stock+=rand1
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand1]</font> [a]!","icout")
							if("Water")
								for(var/obj/item/stock/Stockgem/Watergem/a in usr.contents)
									a.stock+=rand1
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand1]</font> [a]!","icout")
							if("Thunder")
								for(var/obj/item/stock/Stockgem/Thundergem/a in usr.contents)
									a.stock+=rand1
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand1]</font> [a]!","icout")
							if("Earth")
								for(var/obj/item/stock/Stockgem/Earthgem/a in usr.contents)
									a.stock+=rand1
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand1]</font> [a]!","icout")
							if("Ice")
								for(var/obj/item/stock/Stockgem/Icegem/a in usr.contents)
									a.stock+=rand1
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand1]</font> [a]!","icout")
							if("Protection")
								for(var/obj/item/stock/Stockgem/Protectiongem/a in usr.contents)
									a.stock+=rand1
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand1]</font> [a]!","icout")
							if("Cure")
								for(var/obj/item/stock/Stockgem/Curegem/a in usr.contents)
									a.stock+=rand1
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand1]</font> [a]!","icout")
						switch(drawchoice2)
							if("Fire")
								for(var/obj/item/stock/Stockgem/Firegem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Water")
								for(var/obj/item/stock/Stockgem/Watergem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Thunder")
								for(var/obj/item/stock/Stockgem/Thundergem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Earth")
								for(var/obj/item/stock/Stockgem/Earthgem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Ice")
								for(var/obj/item/stock/Stockgem/Icegem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Protection")
								for(var/obj/item/stock/Stockgem/Protectiongem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]></b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Cure")
								for(var/obj/item/stock/Stockgem/Curegem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Dia")
								for(var/obj/item/stock/Stockgem/Diagem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Bio")
								for(var/obj/item/stock/Stockgem/Biogem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Osmose")
								for(var/obj/item/stock/Stockgem/Osmosegem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
							if("Drain")
								for(var/obj/item/stock/Stockgem/Draingem/a in usr.contents)
									a.stock+=rand2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand2]</font> [a]!","icout")
						switch(drawchoice3)
							if("Fire")
								for(var/obj/item/stock/Stockgem/Firegem/a in usr.contents)
									a.stock+=rand3+2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3+2]</font> [a]!","icout")
							if("Water")
								for(var/obj/item/stock/Stockgem/Watergem/a in usr.contents)
									a.stock+=rand3+2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3+2]</font> [a]!","icout")
							if("Thunder")
								for(var/obj/item/stock/Stockgem/Thundergem/a in usr.contents)
									a.stock+=rand3+2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3+2]</font> [a]!","icout")
							if("Earth")
								for(var/obj/item/stock/Stockgem/Earthgem/a in usr.contents)
									a.stock+=rand3+2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3+2]</font> [a]!","icout")
							if("Ice")
								for(var/obj/item/stock/Stockgem/Icegem/a in usr.contents)
									a.stock+=rand3+2
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3+2]</font> [a]!","icout")
							if("Protection")
								for(var/obj/item/stock/Stockgem/Protectiongem/a in usr.contents)
									a.stock+=rand3
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3]</font> [a]!","icout")
							if("Cure")
								for(var/obj/item/stock/Stockgem/Curegem/a in usr.contents)
									a.stock+=rand3
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3]</font> [a]!","icout")
							if("Dia")
								for(var/obj/item/stock/Stockgem/Diagem/a in usr.contents)
									a.stock+=rand3
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3]</font> [a]!","icout")
							if("Bio")
								for(var/obj/item/stock/Stockgem/Biogem/a in usr.contents)
									a.stock+=rand3
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3]</font> [a]!","icout")
							if("Osmose")
								for(var/obj/item/stock/Stockgem/Osmosegem/a in usr.contents)
									a.stock+=rand3
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3]</font> [a]!","icout")
							if("Drain")
								for(var/obj/item/stock/Stockgem/Draingem/a in usr.contents)
									a.stock+=rand3
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3]</font> [a]!","icout")
							if("Flare")
								for(var/obj/item/stock/Stockgem/Flaregem/a in usr.contents)
									a.stock+=rand3
									view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</b><font color=white> has drawn <font color=#60F5B1>[rand3]</font> [a]!","icout")
						usr.stockdrawn=1
						UpdateStock(usr)
					else
						alert(usr,"You have already drawn your Stock for this 24 hour period, please wait until the reset!")
						return
