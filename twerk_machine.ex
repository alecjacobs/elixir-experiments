defmodule Hey do

	def yo_dog(), do: IO.inspect "yo_doggggg"
	def yo_dog(0), do: IO.inspect "yo_doggggg"
	def yo_dog(n), when n > 10, do: IO.inspect "more than ten"
	def yo_dog(n), when n < 10, do: IO.inspect "less than ten"
		
end

Hey.yo_dog(5)
Hey.yo_dog(15)