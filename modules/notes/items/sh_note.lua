--------------------------------------------------------------------------------------------------------
ITEM.name = "Paper Note"
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "This is something you can write a doodle on."
ITEM.price = 20
ITEM.permit = "misc"
--------------------------------------------------------------------------------------------------------
ITEM.functions.use = {
	name = "Use",
	tip = "useTip",
	icon = "icon16/pencil.png",
	onRun = function(item)
		local client = item.player
		local data = {}
		data.start = client:GetShootPos()
		data.endpos = data.start + client:GetAimVector() * 96
		data.filter = client
		local trace = util.TraceLine(data)
		if trace.HitPos then
			local note = ents.Create("lia_note")
			note:SetPos(trace.HitPos + trace.HitNormal * 10)
			note:Spawn()
			hook.Run("OnNoteSpawned", note, item)
		end

		return true
	end,
}
--------------------------------------------------------------------------------------------------------