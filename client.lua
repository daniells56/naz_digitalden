local x, y = guiGetScreenSize()
local link = "http://mta/"..getResourceName(getThisResource()).."/web-side/darkside.html"
local browser = createBrowser(x, y, true, true, false)
local opened = false


function SendNUIMessage(browser, table)
   if isElement(browser) and type(table) == "table" then
      return executeBrowserJavascript(browser, 'window.postMessage('..toJSON(table)..'[0])')
   end
end

function dxNUI()

    dxDrawImage(0, 0, x, y, browser)
end

bindKey('backspace', 'down', function()
if opened == true then
    opened = false
    removeEventHandler('onClientRender', getRootElement(), dxNUI) 
    SendNUIMessage(browser, { hidemenu = true })
    showCursor(false)
    end
end)


addEventHandler("onClientBrowserCreated", browser, function()
    loadBrowserURL(source, link)
    addEventHandler("onClientKey", root, onKey)
end)

 addEventHandler("onClientCursorMove", root,
    function (relativeX, relativeY, absoluteX, absoluteY)
        injectBrowserMouseMove(browser, absoluteX, absoluteY)
    end
)


addEventHandler("onClientClick", root,
    function(button, state)
        if state == "down" then
            injectBrowserMouseDown(browser, button)
        else
            injectBrowserMouseUp(browser, button)
        end
    end
)


function onKey(button)
    if button == "mouse_wheel_down" then
        injectBrowserMouseWheel(browser, -90, 0)
    elseif button == "mouse_wheel_up" then
        injectBrowserMouseWheel(browser, 90, 0)
    end
end

 valores = {
    { item = "celular", quantidade = 1, compra = 2000 },
    { item = "Radio", quantidade = 1, compra = 1500 },
}

addEvent('buy', true)
addEventHandler('buy', getRootElement(), function ( item )
local money = getPlayerMoney( localPlayer )
for k,v in pairs(valores) do
if item == v.item then
    if money >= v.compra then 

        triggerEvent("Notify", localPlayer, "verde", "Compra realizada com sucesso!")

        triggerServerEvent('giveitem', getRootElement(), localPlayer, item, v.quantidade, v.compra)


    else

        triggerEvent("Notify", localPlayer, "vermelho", "Compra negada, você não possuí dinheiro o suficiente.!")

            end
        end
    end
end)

addEvent('opennui', true)
addEventHandler('opennui', getRootElement(), function()
    if opened == false then
        opened = true 
        addEventHandler('onClientRender', getRootElement(), dxNUI) 
        SendNUIMessage(browser, { showmenu = true })
        showCursor(true)
        focusBrowser(browser)
    end
end)