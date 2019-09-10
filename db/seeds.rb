=begin
User.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
RecipeIngredient.destroy_all
=end

# USERS
jamie = User.create(email: "jamie@jamie.com", password: "test", display_name: "jme")
bob = User.create(email: "bob@bob.com", password: "test", display_name: "bob")
sam = User.create(email: "sam@sam.com", password: "test", display_name: "sam")
sue = User.create(email: "sue@sue.com", password: "test", display_name: "sue")
fred = User.create(email: "fred@fred.com", password: "test", display_name: "fred")

# RECIPES
carrot_cake = Recipe.create(user_id: jamie.id, name: "Carrot Cake", description: "yummy cake", total_time: "2 hours", cook_time: "45 minutes", image_url: "https://i.ytimg.com/vi/EJ5AlErxLWY/maxresdefault.jpg", instructions: "MAKE BATTER
Heat the oven to 350 degrees Fahrenheit (176C). Grease two 9-inch round cake pans and line the bottom with parchment paper then grease the top of the paper. Or, grease and flour the bottom and sides of both pans.

In a medium bowl, whisk flour, baking soda, salt, and the cinnamon until well blended.

In a separate bowl, whisk the oil, sugars, and vanilla. Whisk in eggs, one at a time, until combined.

Switch to a large rubber spatula. Scrape the sides and bottom of the bowl then add the dry ingredients in 3 parts, gently stirring until they disappear and the batter is smooth. Stir in the carrots, nuts, and raisins.

BAKE CAKE
Divide the batter between the prepared cake pans. Bake until the tops of the cake layers are springy when touched and when a toothpick inserted into the center of the cake comes out clean; 35 to 45 minutes.

Cool cakes in pans for 15 minutes then turn out onto cooling racks, peel off parchment paper and cool completely.

TO FINISH
In a large bowl, beat cream cheese with a handheld mixer on medium speed until creamy, about 1 minute.

Beat in the powdered sugar, a 1/4 cup at a time until fluffy. Pour in cream and beat on medium speed for 1 minute. Chill covered until ready to frost cake.

When the cake layers are completely cool, frost the top of one cake layer, place the other cake layer on top. Decoratively swirl the top of the cake with remaining frosting, leaving the sides unfrosted. Scatter nuts on top.")

baked_chicken = Recipe.create(user_id: bob.id, name: "Baked Chicken", description: "The best baked chicken ever!", total_time: "1 hour", cook_time: "30 minutes", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-baked-chicken-horizontal-1541702257.jpg?crop=1xw:1xh;center,top&resize=768:*", instructions: "1. Preheat oven to 375º. In a small bowl, combine brown sugar, garlic powder, paprika, salt, and pepper. Drizzle oil all over chicken and generously coat with seasoning mixture, shaking off excess. Scatter lemon slices in baking dish then place chicken on top.
2. Bake until chicken is cooked through, or reads an internal temperature of 165º, about 25 minutes.
3. Cover chicken loosely with foil and let rest for at least 5 minutes. Garnish with parsley, if using.")

pork_chops = Recipe.create(user_id: sam.id, name: "Juicy Pork Choops", total_time: "30 minutes", cook_time: "20 minutes", image_url: "https://hips.hearstapps.com/del.h-cdn.co/assets/18/11/1520972863-pork-chop-vertical.jpg?crop=1.0xw:1xh;center,top&resize=768:*", instructions: "1. Preheat oven to 375°. Season pork chops with salt and pepper.
2. In a small bowl mix together butter, rosemary, and garlic. Set aside.
3. In an oven safe skillet over medium-high heat, heat olive oil then add pork chops. Sear until golden, 4 minutes, flip and cook 4 minutes more. Brush pork chops generously with garlic butter.
4. Place skillet in oven and cook until cooked through, 10-12 minutes. Serve with more garlic butter.")

roasted_carrots = Recipe.create(user_id: sue.id, name: "Roasted Carrots", description: "Oven Roasted Carrots", total_time: "35 minutes", cook_time: "30 minutes", image_url: "https://hips.hearstapps.com/del.h-cdn.co/assets/18/09/2048x1365/gallery-1519653814-delish-roasted-carrots-1.jpg?resize=980:*", instructions: "1. Preheat oven to 400º. On a large baking sheet, toss carrots with olive oil and season generously with salt and pepper.
2. Roast until tender and lightly caramelized, 30 minutes.
3. Garnish with parsley, if desired, before serving.")

greek_chicken = Recipe.create(user_id: fred.id, name: "Greek Chicken", description: "A light summer dish", total_time: "8 hours", cook_time: "30 minutes", image_url: "https://www.recipetineats.com/wp-content/uploads/2018/08/Greek-Yoghurt-Marinated-Chicken_8.jpg", instructions: "1. Mix Marinade ingredients in a large bowl.
2. Add chicken and coat well. Marinade for 24 hours (3 hours minimum).
3. Preheat oven to 180C.350F.
4. Line a tray with foil (trust me), place rack on tray (optional).
5. Place chicken on rack (reserve marinade), skin side up. Bake 30 minutes,
6. Remove from oven. Brush with marinade - do not flip.
7. Return to oven for 20 minutes or until golden and a bit crispy. Give it a spray of olive oil just before it's done if you want an extra crispy, shiny coat.
8. Rest for a few minutes before serving. Juicy and tasty enough to serve plain but extra great with tzatziki or even some plain yogurt.")

# INGREDIENTS
carrot = Ingredient.create(name: "carrot", food_group: "vegetable")
chicken_breast = Ingredient.create(name: "chicken breast", food_group: "protein")
chicken_thigh = Ingredient.create(name: "chicken thigh", food_group: "protein")
butter = Ingredient.create(name: "butter", food_group: "dairy")
garlic = Ingredient.create(name: "garlic", food_group: "spice")
lemon = Ingredient.create(name: "lemon", food_group: "fruit")
rosemary =  Ingredient.create(name: "rosemary", food_group: "spice")
olive_oil = Ingredient.create(name: "olive oil", food_group: "condiment")
sugar = Ingredient.create(name: "sugar", food_group: "spice")
egg = Ingredient.create(name: "egg", food_group: "protein")
pork_chop = Ingredient.create(name: "pork chop", food_group: "protein")
salt = Ingredient.create(name: "salt", food_group: "spice")
pepper = Ingredient.create(name: "black pepper", food_group: "spice")

# RECIPE_INGREDIENTS
RecipeIngredient.create(recipe_id: carrot_cake.id, ingredient_id: carrot.id, ingredient_amount: "3 cups, grated")
RecipeIngredient.create(recipe_id: carrot_cake.id, ingredient_id: egg.id, ingredient_amount: "4 large, room temperature")
RecipeIngredient.create(recipe_id: carrot_cake.id, ingredient_id:sugar.id, ingredient_amount: "1/2 cup")

RecipeIngredient.create(recipe_id: baked_chicken.id, ingredient_id: chicken_breast.id, ingredient_amount: "4")
RecipeIngredient.create(recipe_id: baked_chicken.id, ingredient_id: olive_oil.id, ingredient_amount: "2 Tbs")
RecipeIngredient.create(recipe_id: baked_chicken.id, ingredient_id: salt.id, ingredient_amount: "1 tsp")
RecipeIngredient.create(recipe_id: baked_chicken.id, ingredient_id: pepper.id, ingredient_amount: "1/2 tsp")

RecipeIngredient.create(recipe_id: greek_chicken.id, ingredient_id: chicken_thigh.id, ingredient_amount: "2 lbs")
RecipeIngredient.create(recipe_id: greek_chicken.id, ingredient_id: lemon.id, ingredient_amount: "2, juiced")
RecipeIngredient.create(recipe_id: greek_chicken.id, ingredient_id: olive_oil.id, ingredient_amount: "1/4 cup")
RecipeIngredient.create(recipe_id: greek_chicken.id, ingredient_id: garlic.id, ingredient_amount: "2 cloves, minced")

RecipeIngredient.create(recipe_id: pork_chops.id, ingredient_id: pork_chop.id, ingredient_amount: "3")
RecipeIngredient.create(recipe_id: pork_chops.id, ingredient_id: olive_oil.id, ingredient_amount: "1 Tbs")
RecipeIngredient.create(recipe_id: pork_chops.id, ingredient_id: garlic.id, ingredient_amount: "3 cloves, diced")

RecipeIngredient.create(recipe_id: roasted_carrots.id, ingredient_id: carrot.id, ingredient_amount: "2 lbs, peeled and quartered")
RecipeIngredient.create(recipe_id: roasted_carrots.id, ingredient_id: olive_oil.id, ingredient_amount: "3 Tbs")
RecipeIngredient.create(recipe_id: roasted_carrots.id, ingredient_id: salt.id, ingredient_amount: "to taste")
RecipeIngredient.create(recipe_id: roasted_carrots.id, ingredient_id: pepper.id, ingredient_amount: "generous")
