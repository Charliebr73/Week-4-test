class Array

	def injector(initial=nil)
    result = initial
    self.each do |element|
      if result; result = yield(result, element)
      else; result = element; end
    end
    result
  end
  
end