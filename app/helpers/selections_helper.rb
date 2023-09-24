module SelectionsHelper
  def find_display_dish(all_dish_ids, select_ingredients)
    if all_dish_ids.present?
      if all_dish_ids.tally.select { |k, v| v > 1 }.map(&:first).present?
        duplicate_dish_ids = all_dish_ids.tally.select { |k, v| v > 1 }.map(&:first)
        if duplicate_dish_ids.count == 1
          Dish.find_by(id: duplicate_dish_ids)
        else
          if select_ingredients.pluck(:name).include?("上ケモノ肉")
            Dish.find_by(name: "上山海焼き")
          else
            Dish.find_by(name: "山海焼き")
          end
        end
      else
        dish_id_counts = CategoryDish.where(dish_id: all_dish_ids).group(:dish_id).count
        dish_id_count = dish_id_counts.select { |k, v| v == 1 }.map(&:first)
        Dish.find_by(id: dish_id_count)
      end
    end
  end

  def find_cooking_effect(select_ingredients)
    cooking_effect_records = select_ingredients.where.not(cooking_effect: [""])
    if cooking_effect_records.present?
      cooking_effect_counts = cooking_effect_records.pluck(:cooking_effect).tally
      if cooking_effect_counts.keys.length == 1
        have_effect = cooking_effect_counts.keys.first
        Ingredient.find_by(cooking_effect: have_effect)
      end
    end
  end
end
