-- Author: Tyler Johnston
-- email: tylerjohnst@gmail.com

local SELFLESS_HEALER_ID = 114250
local DENOUNCE_ID = 115654

local SELFLESS = GetSpellInfo(SELFLESS_HEALER_ID)
local DENOUNCE = GetSpellInfo(DENOUNCE_ID)

-- Create a frame to listen for events:
local f = CreateFrame("Frame")

-- Tell the frame to listen for the UNIT_AURA event
-- only when it fires for the player unit:
f:RegisterUnitEvent("UNIT_AURA", "player")

function AuraTickIfStacksExist(spellInfo, spellID, position, red, green, blue)
	local name, _, icon, count = UnitBuff("player", spellInfo)

	-- Draw the spell icon around the character frame in the HUD section if
	-- the required number of stacks are present.
	if name and count > 2 then
		SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame, spellID, icon, position, 0.5, red, green, blue, vflip, false)
	else
		SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame, spellID)
	end
end

f:SetScript("OnEvent", function()
	AuraTickIfStacksExist(SELFLESS, SELFLESS_HEALER_ID, "TOPRIGHT", 255, 255, 255)
	AuraTickIfStacksExist(DENOUNCE, DENOUNCE_ID, "TOPLEFT", 255, 255, 255)
end)

-- Move the stance bar out of the way.
StanceBarFrame:ClearAllPoints()
StanceBarFrame:SetPoint("RIGHT", MultiBarBottomRight, -0, 40)
StanceBarFrame.SetPoint = function() end

-- Move player frame closer to the middle of the screen.
PlayerFrame:ClearAllPoints()
PlayerFrame:SetPoint("RIGHT", UIParent, "CENTER", -250, 250)
PlayerFrame:SetUserPlaced(true)

-- Move target frame closer to the center.
TargetFrame:ClearAllPoints()
TargetFrame:SetPoint("LEFT", PlayerFrame, "RIGHT", 20, 0)
TargetFrame:SetUserPlaced(true)

-- Move the focus frame under the player frame.
FocusFrame:ClearAllPoints()
FocusFrame:SetPoint("TOP", PlayerFrame, "BOTTOM", 50, 0)
FocusFrame:SetScale(0.8)
FocusFrame:SetUserPlaced(true)
