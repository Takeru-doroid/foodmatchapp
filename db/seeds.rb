categories = [
  [ 1, "キノコ類" ],
  [ 2, "肉類" ],
  [ 3, "魚類" ]
]
categories.each do |id, name|
  Category.find_or_create_by!(id: id, name: name)
end

ingredients = [
  [ 1, "ソラダケ", "空島の木の根元に生えるポピュラーなキノコ。食べるとハート回復の効果がある。", "", 1, "mushrooms" ],
  [ 2, "ハイラルダケ", "ハイラルの森を代表するキノコ。木のそばに生えることが多く、食べるとハート回復の効果がある。", "", 1, "mushrooms" ],
  [ 3, "ガンバリダケ", "大地のエネルギーをたくさんため込んだ栄養満点のキノコ。料理に使うとがんばりが回復する効果を得られる。", "がんばり回復", 1, "mushrooms" ],
  [ 4, "ケモノ肉", "平原や森にいる動物から手に入る肉。そのままでも食べられるが、料理するとおいしさアップでハートの回復量も増える。", "", 2, "meats" ],
  [ 5, "上ケモノ肉", "新鮮で上質な動物の肉。なかなか手に入るものでは無いが、料理に使うと高いハート回復効果がある。", "", 2, "meats" ],
  [ 6, "ムカシアロワナ", "今もなお太古の姿を残す活力にあふれる魚。引き締まった身は栄養たっぷりで食べるとハートを回復することができる。", "", 3, "fish" ],
  [ 7, "ポカポカマス", "暖かい水場を好む赤いマス。体内に熱を蓄える特殊な臓器を持ち、食材として使うと体を芯から温める効能を持つ料理を作る事ができる。", "寒さガード", 3, "fish" ]
]
ingredients.each do |id, name, flavor_text, cooking_effect, category_id, category_name|
  ingredient = Ingredient.find_or_create_by!(id: id, name: name, flavor_text: flavor_text, cooking_effect: cooking_effect, category_id: category_id)
  ingredient.image.attach(io: File.open(Rails.root.join("app/assets/images/ingredients/#{category_name}/#{name}.JPG")), filename: "#{name}.JPG")
end

dishes = [
  [ 1, "串焼きキノコ", "キノコの風味が香るシンプルな串焼き。カラフルな見た目が食欲をそそる。" ],
  [ 2, "串焼き肉キノコ添え", "新鮮な肉をメインに、山の恵みをふんだんに使ったボリューム満点の串焼き料理。" ],
  [ 3, "串焼き魚キノコ添え", "新鮮な魚の串焼きに香りの高いキノコを添えたシンプルながら味わい深い料理。" ],
  [ 4, "串焼き肉", "大自然の恵み。ケモノ肉を豪快に焼き上げたジューシーな串焼き。" ],
  [ 5, "串焼き魚", "採れたての魚を串に刺して焼き上げたシンプルながらもっとも魚の味を楽しめる料理。" ],
  [ 25, "山海焼き", "新鮮な肉や魚をこんがりと焼き上げたボリューム満点の料理。" ],
  [ 26, "上山海焼き", "上質な肉と魚を組み合わせた焼きもの。ただの山海焼きより、上品で深い味わい。" ]
]
dishes.each do |id, name, flavor_text|
  dish = Dish.find_or_create_by!(id: id, name: name, flavor_text: flavor_text)
  dish.image.attach(io: File.open(Rails.root.join("app/assets/images/dishes/#{name}.JPG")), filename: "#{name}.JPG")
end

category_dishes = [
  [ 1, 1, 1 ],
  [ 2, 1, 2 ],
  [ 3, 1, 3 ],
  [ 4, 2, 2 ],
  [ 5, 2, 4 ],
  [ 6, 2, 25 ],
  [ 7, 2, 26 ],
  [ 8, 3, 3 ],
  [ 9, 3, 5 ],
  [ 10, 3, 25 ],
  [ 11, 3, 26 ]
]
category_dishes.each do |id, category_id, dish_id|
  CategoryDish.find_or_create_by!(id: id, category_id: category_id, dish_id: dish_id)
end
