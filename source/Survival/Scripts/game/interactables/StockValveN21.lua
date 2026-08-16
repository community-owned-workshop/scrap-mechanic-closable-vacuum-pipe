local OPEN_UUID = sm.uuid.new( "1a5e2d7c-1fd1-4b1e-b11c-6f9af99df210" )
local CLOSED_UUID = sm.uuid.new( "1a5e2d7c-1fd1-4b1e-b11c-6f9af99df211" )

StockValveN21 = class( nil )
StockValveN21.maxParentCount = 1
StockValveN21.connectionInput = sm.interactable.connectionType.logic

local function isOpen( self )
    local parents = self.interactable:getParents()
    if #parents == 0 then
        return true
    end
    for _, parent in pairs( parents ) do
        if parent.active then return true end
    end
    return false
end

function StockValveN21.server_onCreate( self )
    self.sv = { state = nil }
end

function StockValveN21.server_onFixedUpdate( self, dt )
    local open = isOpen( self )
    if self.sv.state == open then return end
    self.sv.state = open

    if open and self.shape.uuid ~= OPEN_UUID then
        self.shape:replaceShape( OPEN_UUID )
    elseif not open and self.shape.uuid ~= CLOSED_UUID then
        self.shape:replaceShape( CLOSED_UUID )
    end
end
