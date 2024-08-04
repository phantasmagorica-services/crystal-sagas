/**
 * stackable materials implementation
 *
 * todo: move to /obj/item/stack/materials
 */
/obj/item/material
	name = "unknown material"
	icon = 'content/icons/items/materials.dmi'
	abstract_type = /obj/item/material
	/// unique id - used for save/load; must be unique and fulfilling the equivalence-relation on the same material
	var/id

/**
 * Get amount of material
 *
 * todo: add id support
 * todo: move to /mob/character
 *
 * @params
 * * material_like - typepath of material
 *
 * @return amount
 */
/mob/proc/get_material_amount(obj/item/material/material_like)
	// todo: this is shitcode
	for(var/obj/item/material/mat in contents)
		if(mat.type == material_like)
			return mat.amount
	CRASH("material not found")

/**
 * Set amount of material
 *
 * todo: add id support
 * todo: move to /mob/character
 *
 * @params
 * * material_like - typepath of material
 * * amount - how much to set
 */
/mob/proc/set_material_amount(obj/item/material/material_like, amount)
	// todo: this is shitcode
	for(var/obj/item/material/mat in contents)
		if(mat.type == material_like)
			mat.amount = amount
	CRASH("material not found")

/**
 * Adjust amount of material
 *
 * todo: add id support
 * todo: move to /mob/character
 *
 * @params
 * * material_like - typepath of material
 * * amount - how much to change
 *
 * @return new amount
 */
/mob/proc/adjust_material_amount(obj/item/material/material_like, amount)
	// todo: this is shitcode
	for(var/obj/item/material/mat in contents)
		if(mat.type == material_like)
			mat.amount += amount
			return mat.amount
	CRASH("material not found")

/**
 * Use an amount of materials
 *
 * todo: add id support
 * todo: move to /mob/character
 *
 * @params
 * * material_like - typepath of material
 * * amount - how much to use
 *
 * @return TRUE / FALSE based on success / failure
 */
/mob/proc/use_material_amount(obj/item/material/material_like, amount)
	// todo: this is shitcode
	for(var/obj/item/material/mat in contents)
		if(mat.type == material_like)
			if(mat.amount > amount)
				mat.amount -= amount
				return TRUE
			return FALSE
	CRASH("material not found")
