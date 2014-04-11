# --------------------------------------------------
# Probabilities
# --------------------------------------------------

# true on x in 10 chance
def probability chance=5
  (rand(10)+1) <= chance
end

# has an x in 10 chance of not being default
def prob chance, value, default=nil
  probability(chance) ? value : default
end
