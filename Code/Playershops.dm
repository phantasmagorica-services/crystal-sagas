obj
	var
		amount=0

atom
	proc
		RefreshShop()
			var/row
			winset(usr,"playershop","is-visible=true")
			winset(usr,"playershop.item","cells=0x0")
			for(var/obj/item/A in src.contents)
				row++
				winset(usr, "playershop.item", "current-cell=1,[row]")
				usr << output(A,"playershop.item")
				if(A.amount>0)
					A.suffix="Amount: [A.amount] | Price:[A.cusprice]"
				else
					A.suffix="Price:[A.cusprice]"
				winset(usr, "playershop.item", "current-cell=2,[row]")
				usr << output(A.suffix,"playershop.item")


obj/playershops
	var/shopid
	var/shopowner
	var/shopcost=0
	var/forsale=0
	var/shopname
	sign
		icon='Map Icons/Signs.dmi'
		icon_state="19"
		Click()
			if(src.shopowner==null||src.forsale)
				switch(alert(usr,"This shop is currently forsale. Do you wish to purchase this shop? It will cost [shopcost]",,"Yes","No"))
					if("Yes")
						if(usr.money>=shopcost)
							usr.money-=shopcost
							for(var/obj/playershops/s in world)
								if(s.shopid==src.shopid)
									s.shopowner=usr.ckey
									s.Savable=1
									s.layer=3
									src.layer=3
									src.Savable=1
							alert(usr,"Congrats! You now own this shop. Click this sign again to set features such as a sign,name, etc.")
						else
							alert(usr,"You don't have enough money to buy this property.")
					if("No")
						return
			else if(shopowner==usr.ckey)
				switch(input("Manage your shop?") in list("Edit Name","Change Sign","Cancel"))
					if("Edit Name")
						var/nam=input("Set the name") as text
						for(var/obj/playershops/p in world)
							if(p.shopid==src.shopid)
								p.shopname=nam
					if("Change Sign")
						var/ico = input("Upload an icon") as icon
						for(var/obj/playershops/signplaceholder/s in world)
							if(s.shopid==src.shopid)
								s.icon=ico
					if("Cancel")
						return

			else
				alert(usr,"[shopname] currently owned by ")

	signplaceholder

	shoptable
		name="Shop Table"
		Savable=0
		layer=2
		icon='Shoptable.dmi'
		density=1
		var/obj/item/itemon
		var/storedmon
		var/samount
		Click()
			var/list/itemlist=new
			if(src.shopowner==usr.ckey)
				switch(input("What do you wish to do to your shop?") as anything in list("View Stock","Add Item","Remove Stock","Set Display","Remove Money","Cancel"))
					if("View Stock")
						var/row
						winset(usr,"playershop","is-visible=true")
						winset(usr,"playershop.item","cells=0x0")
						for(var/obj/item/A in src.contents)
							row++
							winset(usr, "playershop.item", "current-cell=1,[row]")
							usr << output(A,"playershop.item")
							if(A.amount>0)
								A.suffix="Amount: [A.amount] | Price:[A.cusprice]"
							else
								A.suffix="Price:[A.cusprice]"
							winset(usr, "playershop.item", "current-cell=2,[row]")
							usr << output(A.suffix,"playershop.item")
					if("Add Item")
						for(var/obj/item/i in usr.contents)
							if(i.equipped!=1)// This should make it so that equipped items do not show up on the list.
								itemlist+=i
						var/obj/item/choice=input("Choose an item for sale.") as null | anything in itemlist
						if(choice==null)
							return
						if(choice.equipped==1)// An additional sanity check, in case any equipped items get past the prior filter, to make it so you can't put them on shops.
							alert(usr,"You cannot sell equipped items!")
							return
						choice.cusprice=input("What price/unit do you wish to set?") as num
						if(choice.amount>0)
							var/numbah = input("How many do you wish to sell?") as num
							if(numbah>choice.amount)
								alert("You don't have that many to sell")
								return
							else if(numbah==choice.amount)
								if(choice.craftingmaterialtrue==1)
									choice.amount=0
									var/obj/item/i = copyatom(choice)
									choice.amount-=numbah
									i.amount=numbah
									src.contents+=i
								else
									choice.Move(src)
							else if(numbah<choice.amount)
								var/obj/item/i = copyatom(choice)
								i.amount=numbah
								choice.amount-=numbah
								src.contents+=i
						else
							if(choice.craftingmaterialtrue==1)
								alert(usr,"You do not have any of that crafting ingredient!")
								return
							else
								choice.Move(src)
						RefreshShop()
					if("Remove Stock")
						var/list/choicelist=new
						for(var/obj/item/o in src.contents)
							choicelist+=o
						var/obj/choice=input("Choose an ian item to reacquire.") as null|anything in choicelist
						if(choice.craftingmaterialtrue==1)
							for(var/obj/item/p in usr.contents)
								if(choice.name==p.name)
									p.amount+=choice.amount
									del choice
									RefreshShop()
									return
						else
							choice.Move(usr)
							RefreshShop()
							return
					if("Set Display")
						var/list/choicelist=new
						for(var/obj/item/o in src.contents)
							choicelist+=o
						var/obj/choice=input("Choose an item for the main display") as null|anything in choicelist
						if(choice==null)
							return
						choice.mouse_opacity=0
						for(var/obj/item/o in src.contents)
							o.mouse_opacity=1
						src.vis_contents=null
						src.overlays+=choice.icon
					if("Remove Money")
						usr.money+=src.storedmon
						view() << output("[usr.name] collects [storedmon] from the shoptable","icout")
						src.storedmon=0
					if("Cancel")
						return
			else
				var/list/stockorbuy = list("View","Purchase")
				var/choose = input("Would you like to view the stock, or buy from it?") as anything in stockorbuy
				switch(choose)
					if("View")
						var/row
						winset(usr,"playershop","is-visible=true")
						winset(usr,"playershop.item","cells=0x0")
						for(var/obj/item/A in src.contents)
							row++
							winset(usr, "playershop.item", "current-cell=1,[row]")
							usr << output(A,"playershop.item")
							if(A.amount>0)
								A.suffix="Amount: [A.amount] | Price:[A.cusprice]"
							else
								A.suffix="Price:[A.cusprice]"
							winset(usr, "playershop.item", "current-cell=2,[row]")
							usr << output(A.suffix,"playershop.item")
					if("Purchase")
						for(var/obj/item/o in src.contents)
							itemlist += o
						var/obj/item/choice = input("What're you buying?") as null|anything in itemlist
						if(!choice)
							return
						var/list/confirmation=list("Yes","No")
						var/choices2=input(usr,"[choice.name] costs [choice.cusprice]/unit, purchase?") as anything in confirmation
						switch(choices2)
							if("Yes")
								if(choice.amount>0)
									if(usr.money<choice.cusprice)
										alert(usr,"You don't even have enough to afford a single unit!")
										return
									var/numba = input("How many do you wish to purchase?") as num|null
									if(numba <= 0)
										return
									var/adjprice = choice.cusprice*numba
									if(numba>choice.amount)
										alert("There isn't that much for sale")
										return
									if(adjprice>usr.money)
										alert("You don't have enough money to buy that.")
										return
									usr.money-=adjprice
									src.storedmon+=adjprice
									log_action("BUY: [key_name(usr)] bought [numba] of [choice] for [adjprice] from a player shop owned by [shopowner]")
									if(numba<choice.amount)
										if(choice.craftingmaterialtrue==1)
											for(var/obj/item/p in usr.contents)
												if(choice.name==p.name)
													p.amount+=numba
													choice.amount-=numba
										else
											choice.amount-=numba
											var/obj/item/no=copyatom(choice)
											usr.contents+=no
									else if(numba==choice.amount)
										if(choice.craftingmaterialtrue==1)
											for(var/obj/item/p in usr.contents)
												if(choice.name==p.name)
													p.amount+=numba
													del choice
										else
											choice.Move(usr)
								else
									if(usr.money<choice.cusprice)
										alert("You don't have enough to purchase this item.")
										return
									usr.money-=choice.cusprice
									src.storedmon+=choice.cusprice
									choice.Move(usr)
								RefreshShop()
							if("No")
								return
