local Modules = script.Parent.Parent.Parent
local Roact = require(Modules.Roact)
local StudioService = game:GetService("StudioService")

local ClassIcon = Roact.PureComponent:extend("ClassIcon")

function ClassIcon:render()
	local props = self.props
	local iconProps = StudioService:GetClassIcon(props.ClassName)
	return Roact.createElement("ImageLabel", {
		Image = iconProps.Image,
		ImageTransparency = props.transparency,
		ImageRectOffset = iconProps.ImageRectOffset,
		ImageRectSize = iconProps.ImageRectSize,
		BackgroundTransparency = 1,
		Size = props.Size,
		Position = props.Position,
	}, {
		ARConstraint = Roact.createElement("UIAspectRatioConstraint", {
			AspectRatio = 1,
			DominantAxis = "Height",
		}),
	})
end

return ClassIcon
