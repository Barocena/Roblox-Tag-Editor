local Modules = script.Parent.Parent.Parent
local Roact = require(Modules.Roact)

local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)

local Search = Roact.PureComponent:extend("Search")

function Search:init()
	self.state = {
		hover = false,
		focus = false,
	}
end

function Search:render()
	local searchBarState = "Default"

	if self.state.focus then
		searchBarState = "Selected"
	elseif self.state.hover then
		searchBarState = "Hover"
	end

	return Roact.createElement("Frame", {
		Size = self.props.Size,
		Position = self.props.Position,
		BackgroundTransparency = 1.0,
	}, {
		SearchBarContainer = StudioThemeAccessor.withTheme(function(theme)
			return Roact.createElement("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(1, -16, 1, -16),
				BackgroundColor3 = theme:GetColor("InputFieldBackground", "Default"),
				BorderSizePixel = 1,
				BorderColor3 = theme:GetColor("InputFieldBorder", searchBarState),

				[Roact.Event.MouseEnter] = function(rbx)
					self:setState({
						hover = true,
					})
				end,

				[Roact.Event.MouseLeave] = function(rbx)
					self:setState({
						hover = false,
					})
				end,
			}, {
				SearchBar = Roact.createElement("TextBox", {
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, -20, 0, 20),
					BackgroundTransparency = 1.0,
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.SourceSans,
					TextSize = 20,
					PlaceholderText = "Search",
					PlaceholderColor3 = theme:GetColor("DimmedText"),
					TextColor3 = theme:GetColor("MainText"),
					Text = self.props.term,
					ClearTextOnFocus = false,

					[Roact.Event.Changed] = function(rbx, prop)
						if prop == 'Text' then
							self.props.setTerm(rbx.Text)
						end
					end,

					[Roact.Event.InputBegan] = function(rbx, input)
						if input.UserInputType == Enum.UserInputType.MouseButton2 and input.UserInputState == Enum.UserInputState.Begin then
							self.props.setTerm("")
						end
					end,

					[Roact.Event.Focused] = function(rbx)
						self:setState({
							focus = true,
						})
					end,

					[Roact.Event.FocusLost] = function(rbx, enterPressed)
						self:setState({
							focus = false,
						})
					end,
				})
			})
		end)
	})
end

return Search
