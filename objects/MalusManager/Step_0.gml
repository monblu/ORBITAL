if (GameController.inGame) {
	allPlayerList = ds_list_create();
    ds_list_add(allPlayerList, oPlayer1, oPlayer2, oPlayer3, oPlayer4);
    
    playerList = ds_list_create();
    for (i = 0; i < GameController.playerNb; i++) {
        ds_list_add(playerList, ds_list_find_value(allPlayerList, i));
    }
	
	
	
	if (global.leader != "null") {
	    currentHighestScore = global.leader.myScore;
	} else {
	    currentHighestScore = 0;
	}

	theLeaderOfTheMoment = global.leader;
	//show_debug_message("size: "+string(ds_list_size(playerList)))
	for (i = 0; i < ds_list_size(playerList); i++) {
	    player_i = ds_list_find_value(playerList, i);
	    if (player_i.myScore == currentHighestScore && player_i != global.leader) {
	        global.leader = "null";
	    } else if (player_i.myScore > currentHighestScore) {
	        currentHighestScore = player_i.myScore;
	        global.leader = player_i;
	        if (theLeaderOfTheMoment != global.leader) {
	            justChangedLeader = true;
	            malusTimer = 0;
	        }
	    }
	}

	//if we have a leader, check if he just 
	if (global.leader != "null") {
	    malusTimer++;
	    if (malusTimer == secondsBetweenMalus*60) {
	        malusTimer = 0;
	        //trigger an add malus event
	        //check if the player doesn't have the maximum amount of maluses
	        if (ds_list_size(global.leader.maluses) < ds_list_size(malusList)) {
	            hasSetMalus = false;
	            while (!hasSetMalus){
	                malusToAdd = ds_list_find_value(malusList, irandom(ds_list_size(malusList)-1));
	                //check if the random gotten malus from malusList is not present in current maluses (if it is not present, the get find_index function will return -1)
	                if (ds_list_find_index(global.leader.maluses, malusToAdd) == -1) {
	                    //it's not in, we can add it
	                    hasSetMalus = true;
	                    ds_list_add(global.leader.maluses, malusToAdd);
	                    show_debug_message("Added the malus number " + string(malusToAdd) + " to the leader, which is " + string(global.leader));
	                }
	            }
	        }
	    }
	}
	//remove all maluses from all non leader players
    for (i = 0; i < ds_list_size(playerList); i++) {
        player_i = ds_list_find_value(playerList, i);
        if (player_i != global.leader) {
            if (ds_list_size(player_i.maluses) > 0) {
                show_debug_message("Emptying maluses list (size "+string(ds_list_size(player_i.maluses))+") from player "+string(player_i));
            }
            ds_list_clear(player_i.maluses);
			player_i.testt = "bruh";
        }
    }
}