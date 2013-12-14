local Letter = {}

Letter.new = function(vocale)

  local short = display.newText(
    vocale,
    display.contentWidth/2-20,
    display.contentHeight-160,
    _G.font_bold,
    70
  )

  short.zoom = function ( self, _delay )
    local original_size = self.size
    local timing = 200
    -- first time
    transition.to(self, { time=timing,size=original_size*2 })  
    transition.to(self, { time=timing,delay=timing,size=original_size}) 
    -- second time
    transition.to(self, { 
      time=timing,
      size=original_size*2,
      delay=_delay
    })  
    transition.to(self, { 
      time=timing,
      size=original_size,
      delay=_delay+timing,
    }) 
  end

  
  return short
end

return Letter