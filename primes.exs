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

	def scrub_list(list, item) do
		cleaned_list = List.delete(list, item)

		if cleaned_list == list do
			list
		else
			scrub_list(cleaned_list, item)
		end
	end
 
	def find_factors(num) do
		l = int_to_list(num, [])
		lc n inlist l, rem(num, n) == 0, do: n
	end
 
	def is_prime(num) do
		if Enum.count(find_factors(num)) < 3 do
			num
		else
			false
		end
	end
 
	def parallel_find_primes_until(limit) do
		primes = C.pmap int_to_list(limit, []), fn x -> is_prime(x) end
		scrub_list(primes, false)
	end

	def sequential_find_primes_until(limit) do
		primes = C.map int_to_list(limit, []), fn x -> is_prime(x) end
		scrub_list(primes, false)
	end
 
end

IO.inspect "finding primes sequentially"
IO.inspect Primes.sequential_find_primes_until(20000)

IO.inspect "finding primes in parallel"
IO.inspect Primes.parallel_find_primes_until(20000)
