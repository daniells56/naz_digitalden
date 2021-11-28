local marker = createMarker(1340.9713134766,-1056.7083740234,27.01611328125 - 1, "cylinder", 1.5, 255, 255, 0, 170 )

function open(hitElement)
	
    triggerClientEvent(getRootElement(), 'opennui', getRootElement() )


end
addEventHandler("onMarkerHit", marker, open)

addEvent('giveitem', true)
addEventHandler('giveitem', getRootElement(), function(player, item, qnt, din)

	exports.n3xt_inventario:giveItem( player, item, qnt )
	takePlayerMoney(player, din)

end)