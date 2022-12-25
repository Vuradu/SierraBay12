/obj/structure/bed/chair	//YES, chairs are a type of bed, which are a type of stool. This works, believe me.	-Pete
	name = "chair"
	desc = "You sit in this, either by will or force."
	icon_state = "chair_preview"
	color = "#666666"
	base_icon = "chair"
	buckle_dir = 0
	buckle_stance = BUCKLE_FORCE_STAND
	obj_flags = OBJ_FLAG_ROTATABLE
	var/propelled = 0 // Check for fire-extinguisher-driven chairs
	buckle_movable = TRUE

/obj/structure/bed/chair/do_simple_ranged_interaction(mob/user)
	if(!buckled_mob && user)
		rotate(user)
	return TRUE

/obj/structure/bed/chair/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if(!padding_material && istype(W, /obj/item/assembly/shock_kit))
		var/obj/item/assembly/shock_kit/SK = W
		if(!SK.status)
			to_chat(user, SPAN_NOTICE("\The [SK] is not ready to be attached!"))
			return
		if(!user.unEquip(SK))
			return
		var/obj/structure/bed/chair/e_chair/E = new (src.loc, material.name)
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		E.set_dir(dir)
		E.part = SK
		SK.forceMove(E)
		SK.master = E
		qdel(src)

/obj/structure/bed/chair/post_buckle_mob()
	update_icon()
	return ..()

/obj/structure/bed/chair/on_update_icon()
	..()

	var/cache_key = "[base_icon]-[material.name]-over"
	if(isnull(stool_cache[cache_key]))
		var/image/I = image('icons/obj/furniture.dmi', "[base_icon]_over")
		if(material_alteration & MATERIAL_ALTERATION_COLOR)
			I.color = material.icon_colour
		I.layer = ABOVE_HUMAN_LAYER
		stool_cache[cache_key] = I
	overlays |= stool_cache[cache_key]
	// Padding overlay.
	if(padding_material)
		var/padding_cache_key = "[base_icon]-padding-[padding_material.name]-over"
		if(isnull(stool_cache[padding_cache_key]))
			var/image/I =  image(icon, "[base_icon]_padding_over")
			if(material_alteration & MATERIAL_ALTERATION_COLOR)
				I.color = padding_material.icon_colour
			I.layer = ABOVE_HUMAN_LAYER
			stool_cache[padding_cache_key] = I
		overlays |= stool_cache[padding_cache_key]

	if(buckled_mob)
		if(padding_material)
			cache_key = "[base_icon]-armrest-[padding_material.name]"
		if(isnull(stool_cache[cache_key]))
			var/image/I = image(icon, "[base_icon]_armrest")
			I.layer = ABOVE_HUMAN_LAYER
			if(material_alteration & MATERIAL_ALTERATION_COLOR)
				I.color = material.icon_colour
			stool_cache[cache_key] = I
		overlays |= stool_cache[cache_key]
		if(padding_material)
			cache_key = "[base_icon]-padding-armrest-[padding_material.name]"
			if(isnull(stool_cache[cache_key]))
				var/image/I = image(icon, "[base_icon]_padding_armrest")
				I.layer = ABOVE_HUMAN_LAYER
				if(material_alteration & MATERIAL_ALTERATION_COLOR)
					I.color = padding_material.icon_colour
				stool_cache[cache_key] = I
			overlays |= stool_cache[cache_key]

/obj/structure/bed/chair/rotate(mob/user)
	if(!CanPhysicallyInteract(user))
		to_chat(user, SPAN_NOTICE("You can't interact with \the [src] right now!"))
		return

	set_dir(turn(dir, 90))
	update_icon()

/obj/structure/bed/chair/set_dir()
	..()
	if(buckled_mob)
		buckled_mob.set_dir(dir)

/obj/structure/bed/chair/padded/red/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_CARPET)

/obj/structure/bed/chair/padded/brown/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_LEATHER_GENERIC)

/obj/structure/bed/chair/padded/teal/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_TEAL_CLOTH)

/obj/structure/bed/chair/padded/black/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLACK_CLOTH)

/obj/structure/bed/chair/padded/green/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_GREEN_CLOTH)

/obj/structure/bed/chair/padded/purple/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_PURPLE_CLOTH)

/obj/structure/bed/chair/padded/blue/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLUE_CLOTH)

/obj/structure/bed/chair/padded/beige/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BEIGE_CLOTH)

/obj/structure/bed/chair/padded/lime/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_LIME_CLOTH)

/obj/structure/bed/chair/padded/yellow/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, "yellow")

// Leaving this in for the sake of compilation.
/obj/structure/bed/chair/comfy
	name = "comfy chair"
	desc = "It's a chair. It looks comfy."
	icon_state = "comfychair_preview"
	base_icon = "comfychair"

/obj/structure/bed/chair/comfy/brown/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_LEATHER_GENERIC)

/obj/structure/bed/chair/comfy/red/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_CARPET)

/obj/structure/bed/chair/comfy/teal/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_TEAL_CLOTH)

/obj/structure/bed/chair/comfy/black/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLACK_CLOTH)

/obj/structure/bed/chair/comfy/green/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_GREEN_CLOTH)

/obj/structure/bed/chair/comfy/purple/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_PURPLE_CLOTH)

/obj/structure/bed/chair/comfy/blue/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLUE_CLOTH)

/obj/structure/bed/chair/comfy/beige/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BEIGE_CLOTH)

/obj/structure/bed/chair/comfy/lime/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_LIME_CLOTH)

/obj/structure/bed/chair/comfy/yellow/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_YELLOW_CLOTH)

/obj/structure/bed/chair/comfy/captain
	name = "captain chair"
	desc = "It's a chair. Only for the highest ranked asses."
	icon_state = "capchair_preview"
	base_icon = "capchair"

/obj/structure/bed/chair/comfy/captain/on_update_icon()
	..()
	var/image/I = image(icon, "[base_icon]_special")
	I.layer = ABOVE_HUMAN_LAYER
	overlays |= I

/obj/structure/bed/chair/comfy/captain/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc,MATERIAL_STEEL, MATERIAL_BLUE_CLOTH)

/obj/structure/bed/chair/armchair
	name = "armchair"
	desc = "It's an armchair. It looks comfy."
	icon_state = "armchair_preview"
	base_icon = "armchair"
	buckle_movable = FALSE

/obj/structure/bed/chair/armchair/brown/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_LEATHER_GENERIC)

/obj/structure/bed/chair/armchair/red/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_CARPET)

/obj/structure/bed/chair/armchair/teal/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_TEAL_CLOTH)

/obj/structure/bed/chair/armchair/black/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLACK_CLOTH)

/obj/structure/bed/chair/armchair/green/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_GREEN_CLOTH)

/obj/structure/bed/chair/armchair/purple/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_PURPLE_CLOTH)

/obj/structure/bed/chair/armchair/blue/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLUE_CLOTH)

/obj/structure/bed/chair/armchair/beige/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BEIGE_CLOTH)

/obj/structure/bed/chair/armchair/lime/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_LIME_CLOTH)

/obj/structure/bed/chair/armchair/yellow/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_YELLOW_CLOTH)

/obj/structure/bed/chair/office
	name = "office chair"
	icon_state = "officechair_preview"
	base_icon = "officechair"
	anchored = FALSE

/obj/structure/bed/chair/office/Move()
	. = ..()
	if(buckled_mob)
		var/mob/living/occupant = buckled_mob
		if (occupant && (src.loc != occupant.loc))
			if (propelled)
				for (var/mob/O in src.loc)
					if (O != occupant)
						Bump(O)
			else
				unbuckle_mob()

/obj/structure/bed/chair/office/Bump(atom/A)
	..()
	if(!buckled_mob)	return

	if(propelled)
		var/mob/living/occupant = unbuckle_mob()

		var/def_zone = ran_zone()
		var/blocked = 100 * occupant.get_blocked_ratio(def_zone, DAMAGE_BRUTE, damage = 10)
		occupant.throw_at(A, 3, propelled)
		occupant.apply_effect(6, EFFECT_STUN, blocked)
		occupant.apply_effect(6, EFFECT_WEAKEN, blocked)
		occupant.apply_effect(6, EFFECT_STUTTER, blocked)
		occupant.apply_damage(10, DAMAGE_BRUTE, def_zone)
		playsound(src.loc, 'sound/weapons/punch1.ogg', 50, 1, -1)
		if(istype(A, /mob/living))
			var/mob/living/victim = A
			def_zone = ran_zone()
			blocked = 100 * victim.get_blocked_ratio(def_zone, DAMAGE_BRUTE, damage = 10)
			victim.apply_effect(6, EFFECT_STUN, blocked)
			victim.apply_effect(6, EFFECT_WEAKEN, blocked)
			victim.apply_effect(6, EFFECT_STUTTER, blocked)
			victim.apply_damage(10, DAMAGE_BRUTE, def_zone)
		occupant.visible_message(SPAN_DANGER("[occupant] crashed into \the [A]!"))

/obj/structure/bed/chair/office/light/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_CLOTH)

/obj/structure/bed/chair/office/dark/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLACK_CLOTH)

/obj/structure/bed/chair/office/comfy
	name = "comfy office chair"
	desc = "It's an office chair. It looks comfy."
	icon_state = "comfyofficechair_preview"
	base_icon = "comfyofficechair"

/obj/structure/bed/chair/office/comfy/brown/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_LEATHER_GENERIC)

/obj/structure/bed/chair/office/comfy/red/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_CARPET)

/obj/structure/bed/chair/office/comfy/teal/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_TEAL_CLOTH)

/obj/structure/bed/chair/office/comfy/black/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLACK_CLOTH)

/obj/structure/bed/chair/office/comfy/green/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_GREEN_CLOTH)

/obj/structure/bed/chair/office/comfy/purple/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_PURPLE_CLOTH)

/obj/structure/bed/chair/office/comfy/blue/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BLUE_CLOTH)

/obj/structure/bed/chair/office/comfy/beige/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_BEIGE_CLOTH)

/obj/structure/bed/chair/office/comfy/lime/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_LIME_CLOTH)

/obj/structure/bed/chair/office/comfy/yellow/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc, newmaterial, MATERIAL_YELLOW_CLOTH)

/obj/structure/bed/chair/shuttle
	name = "shuttle seat"
	desc = "A comfortable, secure seat. It has a sturdy-looking buckling system for smoother flights."
	base_icon = "shuttle_chair"
	icon_state = "shuttle_chair_preview"
	buckle_sound = 'sound/effects/metal_close.ogg'
	buckle_movable = FALSE

/obj/structure/bed/chair/shuttle/post_buckle_mob()
	if(buckled_mob)
		base_icon = "shuttle_chair-b"
	else
		base_icon = "shuttle_chair"
	..()

/obj/structure/bed/chair/shuttle/on_update_icon()
	..()
	if(!buckled_mob)
		var/image/I = image(icon, "[base_icon]_special")
		I.layer = ABOVE_HUMAN_LAYER
		if(material_alteration & MATERIAL_ALTERATION_COLOR)
			I.color = material.icon_colour
		overlays |= I

/obj/structure/bed/chair/shuttle/blue/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc,MATERIAL_STEEL, MATERIAL_BLUE_CLOTH)

/obj/structure/bed/chair/shuttle/black/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc,MATERIAL_STEEL,MATERIAL_BLACK_CLOTH)

/obj/structure/bed/chair/shuttle/white/New(newloc, newmaterial = DEFAULT_FURNITURE_MATERIAL)
	..(newloc,MATERIAL_STEEL,MATERIAL_CLOTH)

/obj/structure/bed/chair/wood
	name = "classic chair"
	desc = "Old is never too old to not be in fashion."
	base_icon = "wooden_chair"
	icon_state = "wooden_chair_preview"
	color = WOOD_COLOR_GENERIC
	var/chair_material = MATERIAL_WOOD
	buckle_movable = FALSE

/obj/structure/bed/chair/wood/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/stack) || istype(W, /obj/item/wirecutters))
		return
	..()

/obj/structure/bed/chair/wood/New(newloc)
	..(newloc, chair_material)

/obj/structure/bed/chair/wood/mahogany
	color = WOOD_COLOR_RICH
	chair_material = MATERIAL_MAHOGANY

/obj/structure/bed/chair/wood/maple
	color = WOOD_COLOR_PALE
	chair_material = MATERIAL_MAPLE

/obj/structure/bed/chair/wood/ebony
	color = WOOD_COLOR_BLACK
	chair_material = MATERIAL_EBONY

/obj/structure/bed/chair/wood/walnut
	color = WOOD_COLOR_CHOCOLATE
	chair_material = MATERIAL_WALNUT

/obj/structure/bed/chair/wood/wings
	name = "winged chair"
	base_icon = "wooden_chair_wings"
	icon_state = "wooden_chair_wings_preview"

/obj/structure/bed/chair/wood/wings/mahogany
	color = WOOD_COLOR_RICH
	chair_material = MATERIAL_MAHOGANY

/obj/structure/bed/chair/wood/wings/maple
	color = WOOD_COLOR_PALE
	chair_material = MATERIAL_MAPLE

/obj/structure/bed/chair/wood/wings/ebony
	color = WOOD_COLOR_BLACK
	chair_material = MATERIAL_EBONY

/obj/structure/bed/chair/wood/wings/walnut
	color = WOOD_COLOR_CHOCOLATE
	chair_material = MATERIAL_WALNUT

/obj/structure/bed/chair/pew
	name = "pew"
	desc = "A long, simple bench with a backboard, commonly found in places of worship, courtrooms and so on. Not known for being particularly comfortable."
	icon_state = "pew"
	base_icon = "pew"
	color = WOOD_COLOR_GENERIC
	var/material/pew_material = MATERIAL_WOOD
	obj_flags = 0
	buckle_movable = FALSE

/obj/structure/bed/chair/pew/left
	icon_state = "pew_left"
	base_icon = "pew_left"

/obj/structure/bed/chair/pew/New(newloc)
	..(newloc, pew_material)

/obj/structure/bed/chair/pew/mahogany
	color = WOOD_COLOR_RICH
	pew_material = MATERIAL_MAHOGANY

/obj/structure/bed/chair/pew/left/mahogany
	color = WOOD_COLOR_RICH
	pew_material = MATERIAL_MAHOGANY
