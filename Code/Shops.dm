mob/var/obj/NPCshop/browsing

/obj/NPCshop
	/// hardcoded list of things to sell, associated to price.
	/// null associations will use the item's `market_value` variable
	var/list/auto_stock = list()

	var/stockgiver=0
	icon='WhiteMaleBase.dmi'
	Click()
		var/row
		if(src.stockgiver==1)
			if(usr.stockcasting==0)
				alert(usr,"You cannot purchase Stock Crystal!")
				return
		winset(usr,"Shop","is-visible=true")
		winset(usr,"Shop.buy","cells=0x0")
		for(var/obj/item/i in src.contents)
			row++
			usr<<output(i,"Shop.buy:1,[row]")

/obj/NPCshop/New(loc)
	..()
	for(var/path in auto_stock)
		var/value = auto_stock[path]
		if(!ispath(path, /obj/item))
			SOFT_CRASH("non item path [path] on [type]")
			continue
		var/obj/item/casted = path
		if(isnull(value))
			value = initial(casted.market_value)
		if(isnull(value))
			SOFT_CRASH("neither auto value nor market value for [path] was set on [type]")
			continue
		value = max(FLOOR1(value), 1)
		var/obj/item/instance = new path(src)
		instance.instore = TRUE
		instance.shopprice = value

/obj/NPCshop/StockShop
	name="Stock Crystal Shop"
	icon='Icons/NPCs.dmi'
	icon_state="Ramen"
	stockgiver=1
	auto_stock = list(
		/obj/item/stock/Stockgem/Firegem,
		/obj/item/stock/Stockgem/Watergem,
		/obj/item/stock/Stockgem/Thundergem,
		/obj/item/stock/Stockgem/Icegem,
		/obj/item/stock/Stockgem/Earthgem,
		/obj/item/stock/Stockgem/Protectiongem,
		/obj/item/stock/Stockgem/Curegem,
		/obj/item/stock/Stockgem/Diagem,
		/obj/item/stock/Stockgem/Biogem,
		/obj/item/stock/Stockgem/Flaregem,
		/obj/item/stock/Stockgem/Osmosegem,
		/obj/item/stock/Stockgem/Draingem,
	)

/obj/NPCshop/GeneralShop
	icon='Icons/NPCs.dmi'
	icon_state="Ramen"
	name="General Shop"
	auto_stock = list(
		/obj/item/material/ingot/bronze,
		/obj/item/material/ingot/iron,
		/obj/item/material/ingot/steel,
		/obj/item/material/ingot/mythril,
		/obj/item/material/leather,
		/obj/item/material/wool,
		/obj/item/material/wood,
		/obj/item/material/stone,
	)

/obj/NPCshop/WeaponShop
	name="General Weaponsmith"
	icon='Icons/NPCs.dmi'
	icon_state="Shop"

/obj/NPCshop/WeaponShop/New()
	del(src)

/obj/NPCshop/GemShop
	name="Gem Shop"
	icon='Icons/NPCs.dmi'
	icon_state="Flower"
	auto_stock = list(
		/obj/item/material/gem/holy,
		/obj/item/material/gem/dark,
		/obj/item/material/gem/fire,
		/obj/item/material/gem/ice,
		/obj/item/material/gem/thunder,
		/obj/item/material/gem/wind,
		/obj/item/material/gem/earth,
		/obj/item/material/gem/white,
		/obj/item/material/gem/black,
		/obj/item/material/gem/diamond,
		/obj/item/material/gem/water,
		/obj/item/material/gem/bio,
	)

/obj/NPCshop/MateriaVendor
	icon='Icons/NPCs.dmi'
	icon_state="Shinra"
	name="Mako Vendor"
	auto_stock = list(
		/obj/item/material/raw_mako,
	)

/obj/NPCshop/MysidiaShop
	name="Mysidia Shop"
	icon='Icons/NPCs.dmi'
	icon_state="Shop"
	auto_stock = list(
		/obj/item/material/bomb_core,
		/obj/item/material/flying_eyes_eye,
		/obj/item/material/flying_eyes_wing,
		/obj/item/material/tonberry_knife,
		/obj/item/material/gigantoad_slime,
		/obj/item/material/zuu_feather,
		/obj/item/material/pixe_sand,
		/obj/item/material/coeurl_whsker,
		/obj/item/material/sahaugin_scale,
		/obj/item/material/dragon_scale,
		/obj/item/material/esper_soul,
		/obj/item/material/AetherPowder,
		/obj/item/material/EtherPowder,
	)
