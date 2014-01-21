defmodule C do

	def map([], _func), do: []
	def map([ head | tail ], func), do: [func.(head) | map(tail, func)]

	def child(element, func, parent) do 
		parent <- { self, func.(element) }
	end

	def spawn_children(collection, func) do
		map collection, fn element -> spawn(__MODULE__, :child, [element, func, self]) end
	end

	def collect_results(pids) do
		map pids, fn pid -> receive do: ( {^pid, value} -> value) end
	end
	
	def pmap(collection, func) do
		collection |> spawn_children(func) |> collect_results
	end

end

defmodule Primes do
	
	def int_to_list(0, []), do: []
	def int_to_list(n, list), do: List.insert_at(int_to_list(n - 1, list), 0, n)

	# def divide_possible_factors(num) do
	# 	C.map int_to_list(num, []), fn x 
	# 		when x > 0 -> num / x
	# 		0 -> 0
	# 	end
	# end

	def map_divisors(num, [ head | tail ]), when rem num, head == 0 do:


	def find_factors(num) do
		map_divisors(num, int_to_list(num, []))
	end

	def is_prime(num) do
		if Enum.count(divisors_of(num)) > 2 do
			true
		else
			false
		end
	end

	# def find_primes_until(limit) do
	# 	C.map int_to_list(limit, []), is_prime(limit)
	# end

end

IO.inspect Primes.divisors_of(10)
IO.inspect Primes.is_prime(100)

