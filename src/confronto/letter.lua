local Letter = {}

Letter.new = function(vocale)

  local short = display.newText(
    vocale,
    display.contentWidth/2-10,
    display.contentHeight-150,
    "Hiragino Maru Gothic Pro",
    60
  )

  short.zoom = function ( self )
    local original_size = self.size
    local timing = 300
    transition.to(self, { time=100,size=original_size*2 })  
    transition.to(self, { time=100,delay=timing,size=original_size}) 
  end

  
  return short
end

return Letter