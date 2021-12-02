require "set"
input = File.read('21.input').split("\n")

all_allergens = { }
all_ingredients = []
input.each do |meal|
    ingredients, allergens = meal.split("(")
    ingredients = ingredients.strip.split(" ")
    all_ingredients << ingredients
    allergens = allergens.chop[9..].split(', ')
    allergens.each do |allergen|
        all_allergens[allergen] ||= Set.new(ingredients)
        all_allergens[allergen] = all_allergens[allergen].intersection(Set.new(ingredients))
    end
    
end

10.times do 
    all_allergens.each do |allergen, ingredients|
        if ingredients.size == 1
            to_delete = ingredients.first
            all_allergens.each do |sallergen, singredients|
                next if allergen == sallergen
                singredients.delete(to_delete)
            end
        end
    end
end
p all_allergens
p to_delete = all_allergens.to_a.sort.map { |x| x[1].first }.join(',')
#p (all_ingredients.flatten - to_delete).size