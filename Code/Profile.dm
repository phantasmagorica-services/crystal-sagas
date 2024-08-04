/mob
	var/Oprofile
	var/profilepic
	var/profile = {"
		<html>
		<head><center><title>Character Profile</title></center></head>
		<body bgcolor=black text=white><center>
		<b>Name:</b> - <br>
		<b>Race:</b> - <br>
		<b>Coven/Faction:</b> - <br>
		<b>Age:</b> - <br>
		<b>Birth Place:</b> - <br>
		<b>Personality:</b> - <br>
		</center><hr><hr>
		<b>Description:</b><br>
		Not yet created.
		<hr><hr>
		<b>Background Story:</b><br>
		Not yet created.
		<br></body>
	"}

/mob/verb/EditProfile()
	set hidden=1
	usr.profile=input(usr,"Edit","Edit Profile",profile) as message
	winset(usr,"Profile.profile","Clear")
	usr<<browse(usr.profile,"window=Profile.profile")
/mob/verb/EditProfilePic()
	set hidden = 1
	usr.profilepic = input("Select an image to use.","EditProfilePic") as null|icon
	winset(usr,"Profile.ProfilePic","image=[usr.profilepic]")
/mob/verb/Editprofilebuttons()
	set hidden = 1
	if(!usr.editing)
		winset(usr,"Profile.Edit1","is-visible=true")
		winset(usr,"Profile.Edit2","is-visible=true")
		usr.editing =1
	else if(usr.editing)
		winset(usr,"Profile.Edit1","is-visible=false")
		winset(usr,"Profile.Edit2","is-visible=false")
		usr.editing=0
/mob/verb/Switchtoprofile()
	set hidden = 1
	var/winpos = winget(usr,"Charsheet","pos")
	winset(usr,"Charsheet","is-visible=false")
	winset(usr,"Charsheet.strplus","is-visible=false")
	winset(usr,"Profile","is-visible=true")
	winset(usr,"Profile.Edit","is-visible=true")
	winset(usr,"Profile.Sheet","is-visible=true")
	winset(usr,"Profile","pos=[winpos]")
	if(usr.viewing)
		var/mob/M = usr.target
		usr<<browse(M.profile,"window=Profile.profile")
		winset(usr,"Profile.ProfilePic","image=[M.profilepic]")
		winset(usr,"Profile.Metadata1","text=\"Date Joined: [M.datejoined]\"")
		winset(usr,"Profile.Metadata2","text=\"Event Points: [M.ep]/[M.tep]\"")
	else
		usr<<browse(usr.profile,"window=Profile.profile")
		winset(usr,"Profile.patron","is-visible=false")
		winset(usr,"Profile.ProfilePic","image=[usr.profilepic]")
		winset(usr,"Profile.Metadata1","text=\"Date Joined: [usr.datejoined]\"")
		winset(usr,"Profile.Metadata2","text=\"Event Points: [usr.ep]/[usr.tep]\"")
		if(usr.rank=="Fledgling")
			winset(usr,"Profile.t1s","text=\"T1s: [usr.t1s]/Unlimited\"")
			winset(usr,"Profile.t2s","text=\"T2s: [usr.t2s]/2\"")
			winset(usr,"Profile.t3s","text=\"T3s: [usr.t3s]/N/A\"")
			winset(usr,"Profile.t4s","text=\"T4s: [usr.t4s]/N/A\"")
			winset(usr,"Profile.t5s","text=\"T5s: [usr.t5s]/N/A\"")
			winset(usr,"Profile.t6s","text=\"T6s: [usr.t6s]/N/A\"")
			winset(usr,"Profile.es","text=\"E Rank Abilities: [usr.eabs]/Unlimited\"")
			winset(usr,"Profile.ds","text=\"D Rank Abilities: [usr.dabs]/Unlimited\"")
			winset(usr,"Profile.cs","text=\"C Rank Abilities: [usr.cabs]/Unlimited\"")
			winset(usr,"Profile.bs","text=\"B Rank Abilities: [usr.babs]/N/A\"")
			winset(usr,"Profile.as","text=\"A Rank Abilities: [usr.aabs]/N/A\"")
			winset(usr,"Profile.ss","text=\"S Rank Abilities: [usr.sabs]/N/A\"")
		else if(usr.rank=="Rookie")
			winset(usr,"Profile.t1s","text=\"T1s: [usr.t1s]/Unlimited\"")
			winset(usr,"Profile.t2s","text=\"T2s: [usr.t2s]/Unlimited\"")
			winset(usr,"Profile.t3s","text=\"T3s: [usr.t3s]/2\"")
			winset(usr,"Profile.t4s","text=\"T4s: [usr.t4s]/N/A\"")
			winset(usr,"Profile.t5s","text=\"T5s: [usr.t5s]/N/A\"")
			winset(usr,"Profile.t6s","text=\"T6s: [usr.t6s]/N/A\"")
			winset(usr,"Profile.es","text=\"E Rank Abilities: [usr.eabs]/Unlimited\"")
			winset(usr,"Profile.ds","text=\"D Rank Abilities: [usr.dabs]/Unlimited\"")
			winset(usr,"Profile.cs","text=\"C Rank Abilities: [usr.cabs]/Unlimited\"")
			winset(usr,"Profile.bs","text=\"B Rank Abilities: [usr.babs]/3\"")
			winset(usr,"Profile.as","text=\"A Rank Abilities: [usr.aabs]/N/A\"")
			winset(usr,"Profile.ss","text=\"S Rank Abilities: [usr.sabs]/N/A\"")
		else if(usr.rank=="Adept")
			winset(usr,"Profile.t1s","text=\"T1s: [usr.t1s]/Unlimited\"")
			winset(usr,"Profile.t2s","text=\"T2s: [usr.t2s]/Unlimited\"")
			winset(usr,"Profile.t3s","text=\"T3s: [usr.t3s]/4\"")
			winset(usr,"Profile.t4s","text=\"T4s: [usr.t4s]/N/A\"")
			winset(usr,"Profile.t5s","text=\"T5s: [usr.t5s]/N/A\"")
			winset(usr,"Profile.t6s","text=\"T6s: [usr.t6s]/N/A\"")
			winset(usr,"Profile.es","text=\"E Rank Abilities: [usr.eabs]/Unlimited\"")
			winset(usr,"Profile.ds","text=\"D Rank Abilities: [usr.dabs]/Unlimited\"")
			winset(usr,"Profile.cs","text=\"C Rank Abilities: [usr.cabs]/Unlimited\"")
			winset(usr,"Profile.bs","text=\"B Rank Abilities: [usr.babs]/Unlimited\"")
			winset(usr,"Profile.as","text=\"A Rank Abilities: [usr.aabs]/N/A\"")
			winset(usr,"Profile.ss","text=\"S Rank Abilities: [usr.sabs]/N/A\"")
		else if(usr.rank=="Veteran")
			winset(usr,"Profile.t1s","text=\"T1s: [usr.t1s]/Unlimited\"")
			winset(usr,"Profile.t2s","text=\"T2s: [usr.t2s]/Unlimited\"")
			winset(usr,"Profile.t3s","text=\"T3s: [usr.t3s]/Unlimited\"")
			winset(usr,"Profile.t4s","text=\"T4s: [usr.t4s]/2\"")
			winset(usr,"Profile.t5s","text=\"T5s: [usr.t5s]/N/A\"")
			winset(usr,"Profile.t6s","text=\"T6s: [usr.t6s]/N/A\"")
			winset(usr,"Profile.es","text=\"E Rank Abilities: [usr.eabs]/Unlimited\"")
			winset(usr,"Profile.ds","text=\"D Rank Abilities: [usr.dabs]/Unlimited\"")
			winset(usr,"Profile.cs","text=\"C Rank Abilities: [usr.cabs]/Unlimited\"")
			winset(usr,"Profile.bs","text=\"B Rank Abilities: [usr.babs]/Unlimited\"")
			winset(usr,"Profile.as","text=\"A Rank Abilities: [usr.aabs]/3\"")
			winset(usr,"Profile.ss","text=\"S Rank Abilities: [usr.sabs]/N/A\"")
		else if(usr.rank=="Hero")
			winset(usr,"Profile.t1s","text=\"T1s: [usr.t1s]/Unlimited\"")
			winset(usr,"Profile.t2s","text=\"T2s: [usr.t2s]/Unlimited\"")
			winset(usr,"Profile.t3s","text=\"T3s: [usr.t3s]/Unlimited\"")
			winset(usr,"Profile.t4s","text=\"T4s: [usr.t4s]/4\"")
			winset(usr,"Profile.t5s","text=\"T5s: [usr.t5s]/1\"")
			winset(usr,"Profile.t6s","text=\"T6s: [usr.t6s]/N/A\"")
			winset(usr,"Profile.es","text=\"E Rank Abilities: [usr.eabs]/Unlimited\"")
			winset(usr,"Profile.ds","text=\"D Rank Abilities: [usr.dabs]/Unlimited\"")
			winset(usr,"Profile.cs","text=\"C Rank Abilities: [usr.cabs]/Unlimited\"")
			winset(usr,"Profile.bs","text=\"B Rank Abilities: [usr.babs]/Unlimited\"")
			winset(usr,"Profile.as","text=\"A Rank Abilities: [usr.aabs]/Unlimited\"")
			winset(usr,"Profile.ss","text=\"S Rank Abilities: [usr.sabs]/1\"")
		if(usr.rank=="Master")
			winset(usr,"Profile.t1s","text=\"T1s: [usr.t1s]/Unlimited\"")
			winset(usr,"Profile.t2s","text=\"T2s: [usr.t2s]/Unlimited\"")
			winset(usr,"Profile.t3s","text=\"T3s: [usr.t3s]/Unlimited\"")
			winset(usr,"Profile.t4s","text=\"T4s: [usr.t4s]/6\"")
			winset(usr,"Profile.t5s","text=\"T5s: [usr.t5s]/2\"")
			winset(usr,"Profile.t6s","text=\"T6s: [usr.t6s]/1\"")
			winset(usr,"Profile.es","text=\"E Rank Abilities: [usr.eabs]/Unlimited\"")
			winset(usr,"Profile.ds","text=\"D Rank Abilities: [usr.dabs]/Unlimited\"")
			winset(usr,"Profile.cs","text=\"C Rank Abilities: [usr.cabs]/Unlimited\"")
			winset(usr,"Profile.bs","text=\"B Rank Abilities: [usr.babs]/Unlimited\"")
			winset(usr,"Profile.as","text=\"A Rank Abilities: [usr.aabs]/Unlimited\"")
			winset(usr,"Profile.ss","text=\"S Rank Abilities: [usr.sabs]/3\"")
