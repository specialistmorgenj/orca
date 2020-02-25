local param_ids = {}
local param_names = {}

local helper = false
local synth_param = function ( self, x, y )
  
  self.y = y
  self.x = x
  self.name = "param"

  print(engine.name)

  self.ports = { {1, 0, helper or "in-param"}, {2, 0, helper or "in-value"} }
  self:spawn( self.ports )

  if self:neighbor( self.x, self.y, "*" ) then
    -- TODO(frederickk): write this.
  end
end


return synth_param