-- Author: Tyler Johnston
-- email: tylerjohnst@gmail.com

local SELFLESS_ID = 114250
local DENOUNCE_ID = 115654

local SELFLESS = GetSpellInfo(SELFLESS_ID)
local DENOUNCE = GetSpellInfo(DENOUNCE_ID)

-- Create a frame to listen for events:
local f = CreateFrame("Frame")

-- Tell the frame to listen for the UNIT_AURA event
-- only when it fires for the player unit:
f:RegisterUnitEvent("UNIT_AURA", "player")

function SelflessTick(spellInfo, spellID, position, red, green, blue)
	local name, _, icon, count = UnitBuff("player", spellInfo)

	if name and count > 2 then
		-- Yes they do! Show the low opacity overlay.
		SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame, spellID, icon, position, 0.5, red, green, blue, vflip, false)
	else
		-- No, they don't. Hide the overlay.
		SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame, spellID)
	end
end

f:SetScript("OnEvent", function()
	SelflessTick(SELFLESS, SELFLESS_ID, "TOPRIGHT", 255, 255, 255)
	SelflessTick(DENOUNCE, DENOUNCE_ID, "TOPLEFT", 255, 255, 255)
end)

StanceBarFrame:ClearAllPoints()
StanceBarFrame:SetPoint("RIGHT", MultiBarBottomRight, -0, 40)
StanceBarFrame.SetPoint = function() end

PlayerFrame:ClearAllPoints()
PlayerFrame:SetPoint("RIGHT", UIParent, "CENTER", -250, 250)
PlayerFrame:SetUserPlaced(true)

TargetFrame:ClearAllPoints()
TargetFrame:SetPoint("LEFT", PlayerFrame, "RIGHT", 20, 0)
TargetFrame:SetUserPlaced(true)

FocusFrame:ClearAllPoints()
FocusFrame:SetPoint("TOP", PlayerFrame, "BOTTOM", 50, 0)
FocusFrame:SetScale(0.8)
FocusFrame:SetUserPlaced(true)
