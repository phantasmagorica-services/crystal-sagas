mob
	verb
		OpenPerkShop()
			set hidden = 1
			winset(usr,"PerkWindow","is-visible=true")
			winset(usr,"Perksheet","is-visible=false")
			winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
		ShowGeneralPerks()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.cat=="General"  && o.desc != null)
					row++
					src<<output(o,"perkshop:1,[row]")
		ShowJobPerks()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.jobneed=="[usr.job]" && o.ability==0  && o.desc != null && o.cat!="Unique")
					row++
					src<<output(o,"perkshop:1,[row]")
		ShowSubJobPerks()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.jobneed=="[usr.subjob]" && o.ability==0  && o.desc != null && o.cat!="Unique")
					row++
					src<<output(o,"perkshop:1,[row]")
		ShowCraftingPerks()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.cat=="Crafting"  && o.desc != null)
					row++
					src<<output(o,"perkshop:1,[row]")
		ShowGeneralAbilities()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.cat=="Genability" && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowBlackMagic()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.magicneed=="Black Magic" && o.level <= usr.blackmagicable  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowWhiteMagic()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.magicneed=="White Magic" && o.level <= usr.whitemagicable  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowGreenMagic()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.magicneed=="Green Magic" && o.level <= usr.greenmagicable  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowArcaneMagic()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.magicneed=="Arcane Magic" && o.level <= usr.arcanemagicable  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowJobAbilities()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.jobneed=="[usr.job]" && o.ability==1  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowSubjobAbilities()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.jobneed=="[usr.subjob]" && o.ability==1  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowAdvanced()
			set hidden = 1
			var/row
			var/row2
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.ajob=="[usr.ajob]" && o.ability==0  && o.desc != null && o.cat!="Unique")
					row++
					src<<output(o,"perkshop:1,[row]")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.ajob=="[usr.ajob]" && o.ability==1  && o.desc != null && o.cat!="Unique")
					row2++
					src<<output(o,"techshop:1,[row2]")
