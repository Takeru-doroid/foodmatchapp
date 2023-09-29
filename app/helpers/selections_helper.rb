module SelectionsHelper
  def find_display_dish(category_ids, select_ingredients)
    all_category_ids = category_ids&.map(&:to_i)
    if all_category_ids.present?
      duplicate_categories = all_category_ids.tally.select{ |k, v| v > 1 }.map(&:first)
      if duplicate_categories.present?
        if duplicate_categories.include?(3)
          if select_ingredients.pluck(:name).include?("上ケモノ肉")
            Dish.find_by(name: "上山海焼き")
          elsif all_category_ids.include?(2)
            Dish.find_by(name: "山海焼き")
          else
            pluck_dish_id = CategoryDish.where(category_id: duplicate_categories).pluck(:dish_id)
            display_dish = CategoryDish.where(dish_id: pluck_dish_id)
                                      .group(:dish_id)
                                      .count.select{ |k, v| v == 1 }
                                      .map(&:first)
            Dish.find_by(id: display_dish)
          end
        else
          pluck_dish_id = CategoryDish.where(category_id: duplicate_categories).pluck(:dish_id)
          display_dish = CategoryDish.where(dish_id: pluck_dish_id)
                                    .group(:dish_id)
                                    .count.select{ |k, v| v == 1 }
                                    .map(&:first)
          Dish.find_by(id: display_dish)
        end
      else
        if select_ingredients.pluck(:name).include?("上ケモノ肉") && all_category_ids.include?(3)
          Dish.find_by(name: "上山海焼き")
        elsif all_category_ids.include?(2) && all_category_ids.include?(3)
          Dish.find_by(name: "山海焼き")
        elsif all_category_ids.count > 1
          display_dish = Dish.joins(:category_dishes)
                            .where(category_dishes: { category_id: all_category_ids })
                            .pluck(:dish_id)
                            .tally
                            .select{ |k, v| v > 1 }
                            .map(&:first)
          Dish.find_by(id: display_dish)
        else
          pluck_dish_id = CategoryDish.where(category_id: all_category_ids).pluck(:dish_id)
          display_dish = CategoryDish.where(dish_id: pluck_dish_id)
                                    .group(:dish_id)
                                    .count.select{ |k, v| v == 1 }
                                    .map(&:first)
          Dish.find_by(id: display_dish)
        end
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
