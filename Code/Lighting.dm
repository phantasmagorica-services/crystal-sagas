proc
	sd_OutsideLight(n as num)
		outside_light = n
		for(var/mob/M in world)
			if(M.darkness) if(M.darkness.alpha == 0) continue
			M.setLightOverlay(n)

mob
	var/
		obj/light/light
		image
			darkness/darkness
			master_plane/master_plane
var
	outside_light = 0

obj
	lightsource
		luminosity=3
		var/level=1
		var
			obj/light/light
			matrix
				on_matrix = matrix()
				off_matrix = matrix()
		New()
			..()
			light = new(src.loc)
			on_matrix.Scale(8)
			off_matrix.Scale(0)
			light.transform = on_matrix


image
	master_plane
		plane = GAME_PLANE
		blend_mode = BLEND_MULTIPLY
		appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR
		color = list(null,null,null,"#0000","#000f")
		mouse_opacity = 0

	darkness
		plane = LEGACY_DARKNESS_PLANE
		blend_mode = BLEND_ADD
		mouse_opacity = 0
		icon = 'darkness.dmi'
		New()
			..()
			var/matrix/m = matrix()
			// we cannot possibly go higher than this
			m.Scale(75, 75)
			transform = m


obj/light
	plane = -1
	blend_mode = BLEND_ADD
	icon = 'light32.dmi'
	mouse_opacity = 0

mob/proc/addLightPlane()
	if(!master_plane)
		master_plane = new /image/master_plane
	master_plane.loc = src
	if(!darkness)
		darkness = new /image/darkness
	darkness.loc = src
	darkness.alpha = 120
	var/matrix/M = matrix()
	M.Scale(75, 75)
	darkness.transform = M
	client.images += master_plane
	client.images += darkness

mob/proc/removeLightPlane()
	client.screen -= master_plane
	client.screen -= darkness
	del(darkness)
	del(master_plane)

mob/proc/setLightOverlay(var/light)
	light = abs(light)
	switch(light)
		if(0) light = 5
		if(1) light = 120
		if(2) light = 130
		if(3) light = 140
		if(4) light = 170
		if(5) light = 200
		if(6) light = 225
		if(7) light = 255
	if(darkness)
		animate(darkness,alpha=light,time=15)

