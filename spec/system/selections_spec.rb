require 'rails_helper'

RSpec.describe "Selections", type: :system do
  describe "食材の組み合わせ機能" do
    let(:user) { create(:user) }
    let!(:ingredient) do
      [
        create(:ingredient, name: "ソラダケ", category: category[0]),
        create(:ingredient, name: "ガンバリダケ", category: category[0], cooking_effect: "がんばり回復"),
        create(:ingredient, name: "ケモノ肉", category: category[1]),
        create(:ingredient, name: "上ケモノ肉", category: category[1]),
        create(:ingredient, name: "ムカシアロワナ", category: category[2]),
        create(:ingredient, name: "サンケゴイ", category: category[2]),
        create(:ingredient, name: "ヨロイカボチャ", category: category[3], cooking_effect: "防御アップ"),
        create(:ingredient, name: "ガンバリ草", category: category[3], cooking_effect: "がんばり回復"),
        create(:ingredient, name: "リンゴ", category: category[4]),
        create(:ingredient, name: "イチゴ", category: category[4]),
      ]
    end
    let!(:category) do
      [
        create(:category, id: 1, name: "キノコ類"),
        create(:category, id: 2, name: "肉類"),
        create(:category, id: 3, name: "魚類"),
        create(:category, id: 4, name: "野菜類"),
        create(:category, id: 5, name: "果実類"),
      ]
    end
    let!(:category_dish) do
      [
        create(:category_dish, category: category[0], dish: dish[0]),
        create(:category_dish, category: category[1], dish: dish[1]),
        create(:category_dish, category: category[2], dish: dish[2]),
        create(:category_dish, category: category[0], dish: dish[3]),
        create(:category_dish, category: category[1], dish: dish[3]),
        create(:category_dish, category: category[0], dish: dish[4]),
        create(:category_dish, category: category[2], dish: dish[4]),
        create(:category_dish, category: category[1], dish: dish[5]),
        create(:category_dish, category: category[2], dish: dish[5]),
        create(:category_dish, category: category[1], dish: dish[6]),
        create(:category_dish, category: category[2], dish: dish[6]),
        create(:category_dish, category: category[3], dish: dish[7]),
        create(:category_dish, category: category[3], dish: dish[8]),
        create(:category_dish, category: category[0], dish: dish[9]),
        create(:category_dish, category: category[3], dish: dish[9]),
        create(:category_dish, category: category[1], dish: dish[10]),
        create(:category_dish, category: category[3], dish: dish[10]),
        create(:category_dish, category: category[2], dish: dish[11]),
        create(:category_dish, category: category[3], dish: dish[11]),
        create(:category_dish, category: category[4], dish: dish[12]),
        create(:category_dish, category: category[0], dish: dish[13]),
        create(:category_dish, category: category[4], dish: dish[13]),
        create(:category_dish, category: category[3], dish: dish[14]),
        create(:category_dish, category: category[4], dish: dish[14]),
        create(:category_dish, category: category[2], dish: dish[15]),
        create(:category_dish, category: category[4], dish: dish[15]),
      ]
    end
    let!(:dish) do
      [
        create(:dish, name: "串焼きキノコ"),
        create(:dish, name: "串焼き肉"),
        create(:dish, name: "串焼き魚"),
        create(:dish, name: "串焼き肉キノコ添え"),
        create(:dish, name: "串焼き魚キノコ添え"),
        create(:dish, name: "山海焼き"),
        create(:dish, name: "上山海焼き"),
        create(:dish, name: "焼き山菜"),
        create(:dish, name: "丸ごと焼き"),
        create(:dish, name: "包み焼きキノコ"),
        create(:dish, name: "包み焼き肉"),
        create(:dish, name: "包み焼き魚"),
        create(:dish, name: "煮込み果実"),
        create(:dish, name: "果実のキノコあえ"),
        create(:dish, name: "蒸し焼き果実"),
        create(:dish, name: "肉詰めカボチャ"),
      ]
    end

    it "selectionページに遷移できること" do
      login(user)
      click_on "組み合わせページへのリンク画像"
      expect(current_path).to eq selections_display_selection_path
    end

    it "ログイン前だとselectionページリンクがないこと" do
      visit root_path
      expect(page).to_not have_selector "a", text: "selectionsコントローラー(食材選び)"
    end

    describe "selectionページ画面" do
      before do
        login(user)
        visit selections_display_selection_path
      end

      it "食材が表示されていること" do
        expect(page).to have_selector "#ingredients-container"
      end

      it "食材の画像が表示されていること" do
        expect(page).to have_selector "img[alt=#{ingredient[0].name}の画像]"
      end

      it "表示された料理に画像があること" do
        select_ingredient([0])
        expect(page).to have_selector "img[alt=#{dish[0].name}の画像]"
      end

      it "選択した食材名が詳細ページへのリンクになっていること" do
        select_ingredient([0])
        within ".select-ingredients" do
          click_on "#{ingredient[0].name}"
        end
        expect(current_path).to eq ingredient_path(ingredient[0])
      end

      it "cooking_effectを持つ食材を使用した料理には、名前の先頭に別名が付与されること" do
        select_ingredient([1])
        expect(page).to have_content "がんばり" + "#{dish[0].name}"
      end

      it "無選択で送信するとalertが表示されること" do
        click_on "料理する"
        expect(page).to have_content "少なくとも1つ以上は食材を選択してください"
      end

      it "投稿するが投稿ページへのリンクになっていること" do
        select_ingredient([0])
        click_on "投稿"
        expect(current_path).to eq new_post_path
      end

      describe "組み合わせ挙動" do
        context "選択数が1つの場合" do
          it "キノコ類の食材であれば、串焼きキノコが表示されること" do
            select_ingredient([0])
            expect(page).to have_content "#{dish[0].name}"
          end

          it "肉類の食材であれば、串焼き肉が表示されること" do
            select_ingredient([2])
            expect(page).to have_content "#{dish[1].name}"
          end

          it "魚類の食材であれば、串焼き魚が表示されること" do
            select_ingredient([4])
            expect(page).to have_content "#{dish[2].name}"
          end

          it "野菜類の食材であれば、焼き山菜が表示されること" do
            select_ingredient([6])
            expect(page).to have_content "#{dish[7].name}"
          end

          it "ガンバリ草であれば、丸ごと焼きが表示されること" do
            select_ingredient([7])
            expect(page).to have_content "がんばり" + "#{dish[8].name}"
          end

          it "果実類の食材であれば、煮込み果実が表示されること" do
            select_ingredient([8])
            expect(page).to have_content "#{dish[12].name}"
          end
        end

        context "選択数が2つの場合" do
          context "同カテゴリの場合" do
            it "キノコ類は、串焼きキノコが表示されること" do
              select_ingredient([0, 1])
              expect(page).to have_content "#{dish[0].name}"
            end

            it "肉類は、串焼き肉が表示されること" do
              select_ingredient([2, 3])
              expect(page).to have_content "#{dish[1].name}"
            end

            it "魚類は、串焼き魚が表示されること" do
              select_ingredient([4, 5])
              expect(page).to have_content "#{dish[2].name}"
            end

            it "野菜類は、焼き山菜が表示されること" do
              select_ingredient([6, 7])
              expect(page).to have_content "#{dish[7].name}"
            end

            it "果実類は、煮込み果実が表示されること" do
              select_ingredient([8, 9])
              expect(page).to have_content "#{dish[12].name}"
            end
          end

          context "別カテゴリの場合" do
            it "キノコ類 ✖️ 肉類は、串焼きキノコ添えが表示されること" do
              select_ingredient([0, 2])
              expect(page).to have_content "#{dish[3].name}"
            end

            it "キノコ類 ✖️ 魚類は、串焼き魚キノコ添えが表示されること" do
              select_ingredient([0, 4])
              expect(page).to have_content "#{dish[4].name}"
            end

            it "キノコ類 ✖️ 野菜類は、包み焼きキノコが表示されること" do
              select_ingredient([0, 6])
              expect(page).to have_content "#{dish[9].name}"
            end

            it "キノコ類 ✖️ 果実類は、果実のキノコあえが表示されること" do
              select_ingredient([0, 8])
              expect(page).to have_content "#{dish[13].name}"
            end

            it "肉類 ✖️ 魚類は、山海焼きが表示されること" do
              select_ingredient([2, 4])
              expect(page).to have_content "#{dish[5].name}"
            end

            it "肉類 ✖️ 野菜類は、包み焼き肉が表示されること" do
              select_ingredient([2, 7])
              expect(page).to have_content "#{dish[10].name}"
            end

            it "肉類 ✖️ 果実類は、串焼き肉が表示されること" do
              select_ingredient([2, 8])
              expect(page).to have_content "#{dish[1].name}"
            end

            it "魚類 ✖️ 野菜類は、包み焼き魚が表示されること" do
              select_ingredient([4, 6])
              expect(page).to have_content "#{dish[11].name}"
            end

            it "魚類 ✖️ 果実類は、串焼き魚が表示されること" do
              select_ingredient([4, 8])
              expect(page).to have_content "#{dish[2].name}"
            end

            it "野菜類 ✖️ 果実類は、蒸し焼き果実が表示されること" do
              select_ingredient([6, 8])
              expect(page).to have_content "#{dish[14].name}"
            end

            it "上ケモノ肉 ✖️ 魚類は、上山海焼きが表示されること" do
              select_ingredient([3, 4])
              expect(page).to have_content "#{dish[6].name}"
            end

            it "ヨロイカボチャ ✖️ 肉類は、肉詰めカボチャが表示されること" do
              select_ingredient([2, 6])
              expect(page).to have_content "#{dish[15].name}"
            end
          end
        end

        context "選択数が3つの場合" do
          context "2つが同カテゴリの場合" do
            it "キノコ類食材が2つ以上であれば、串焼きキノコが表示されること" do
              (0..9).reject { |i| [0, 1].include?(i) }.each do |i|
                select_ingredient([i, 0, 1])
                expect(page).to have_content "#{dish[0].name}"
              end
            end

            it "果実類食材が2つ以上であれば、煮込み果実が表示されること" do
              (0..9).reject { |i| [8, 9].include?(i) }.each do |i|
                select_ingredient([i, 8, 9])
                expect(page).to have_content "#{dish[12].name}"
              end
            end

            it "肉類食材が2つ以上かつもう一つがヨロイカボチャでなければ、串焼き肉が表示されること" do
              (0..9).reject { |i| [2, 3, 6].include?(i) }.each do |i|
                select_ingredient([i, 2, 3])
                expect(page).to have_content "#{dish[1].name}"
              end
            end

            it "野菜類食材が2つ以上かつヨロイカボチャ ✖️ 肉類の組み合わせでなければ、焼き山菜が表示されること" do
              (0..9).reject { |i| [2, 3, 6, 7].include?(i) }.each do |i|
                select_ingredient([i, 6, 7])
                expect(page).to have_content "#{dish[7].name}"
              end
            end

            it "魚類食材が2つ以上かつ肉類以外の食材であれば、串焼き魚が表示されること" do
              (0..9).reject { |i| [2, 3, 4, 5].include?(i) }.each do |i|
                select_ingredient([i, 4, 5])
                expect(page).to have_content "#{dish[2].name}"
              end
            end

            it "野菜類2種(ヨロイカボチャを含む) ✖️ 肉類であれば、肉詰めカボチャが表示されること" do
              [2, 3].each do |i|
                select_ingredient([i, 6, 7])
                expect(page).to have_content "#{dish[15].name}"
              end
            end

            it "肉類2種 ✖️ ヨロイカボチャであれば、肉詰めカボチャが表示されること" do
              select_ingredient([2, 3, 6])
              expect(page).to have_content "#{dish[15].name}"
            end

            it "魚類2種 ✖️ 肉類であれば、山海焼きが表示されること" do
              select_ingredient([2, 4, 5])
              expect(page).to have_content "#{dish[5].name}"
            end

            it "魚類2種 ✖️ 上ケモノ肉であれば、上山海焼きが表示されること" do
              select_ingredient([3, 4, 5])
              expect(page).to have_content "#{dish[6].name}"
            end
          end

          context "全て別カテゴリの場合" do
            it "ヨロイカボチャ ✖️ 肉類の食材が含まれているとき、肉詰めカボチャが優先表示されること" do
              (0..9).reject { |i| [2, 6].include?(i) }.each do |i|
                select_ingredient([i, 2, 6])
                expect(page).to have_content "#{dish[15].name}"
              end
            end

            it "肉類 ✖️ 魚類の食材が含まれるかつヨロイカボチャが含まれないとき、山海焼きが優先表示されること" do
              (0..9).reject { |i| [2, 3, 4, 5, 6].include?(i) }.each do |i|
                select_ingredient([i, 2, 4])
                expect(page).to have_content "#{dish[5].name}"
              end
            end

            it "上ケモノ肉 ✖️ 魚類の食材が含まれるかつヨロイカボチャが含まれないとき、上山海焼きが優先表示されること" do
              (0..9).reject { |i| [2, 3, 4, 5, 6].include?(i) }.each do |i|
                select_ingredient([i, 3, 4])
                expect(page).to have_content "#{dish[6].name}"
              end
            end

            it "肉類 ✖️ 野菜類(ヨロイカボチャを除く) ✖️ (キノコ類 or 果実類)であれば、包み焼き肉が優先表示されること" do
              (0..9).reject { |i| [2, 3, 4, 5, 6, 7].include?(i) }.each do |i|
                select_ingredient([i, 2, 7])
                expect(page).to have_content "#{dish[10].name}"
              end
            end

            it "魚類 ✖️ 野菜類 ✖️ (キノコ類 or 果実類)であれば、包み焼き魚が優先表示されること" do
              (0..9).reject { |i| [2, 3, 4, 5, 6, 7].include?(i) }.each do |i|
                select_ingredient([i, 4, 6])
                expect(page).to have_content "#{dish[11].name}"
              end
            end

            it "キノコ類 ✖️ 野菜類 ✖️ 果実類であれば、包み焼きキノコが優先表示されること" do
              select_ingredient([0, 6, 8])
              expect(page).to have_content "#{dish[9].name}"
            end
          end
        end
      end
    end
  end
end
