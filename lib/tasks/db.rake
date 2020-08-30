namespace :db do
  desc "TODO"
  task fake_data: :environment do
    arr_cats = %w[ Samsung Macbook Asus Acer iPhone iPad Dell LG HP Leno ]
    arr_cats.each do |cat|
      puts "Creating category #{cat}"
      category = Category.create(name: cat)

      ['product1', 'product2'].each do |product_name|
        puts "Creating product #{product_name}"
        Product.create(product_name: product_name, quantity: 50, unit_price: 200, category_id: category.id)
      end
    end
  end

end
