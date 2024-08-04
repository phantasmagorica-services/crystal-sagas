LEGACY_GLOBAL_LIST_BOILERPLATE(fate_crystals, /obj/FATECrystal)
/**
 * fate crystal where fates are spawned from
 *
 * todo: repath to /obj/fate_crystal
 */
/obj/FATECrystal


obj
	FATECrystal
		var
			locationarea
			FATEID
			party1=0
			party2=0
			occupied=0
		name="FATE Crystal"
		icon='Icons/Fatecrystal.dmi'
		density=1
		layer=2
		pixel_x=-10
