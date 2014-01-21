module Primes
	@primes = []

	def find_primes_up_to(limit)
		limit.times do |possible_prime|
			catch :not_a_match do
				possible_divisors = (2..possible_prime).to_a
				possible_divisors.each do |poss_div|
					remainder = possible_prime % poss_div
					throw :not_a_match if remainder == 0
					@primes << possible_prime if poss_div == (possible_prime - 1)
				end
			end
		end

		@primes
	end
end
