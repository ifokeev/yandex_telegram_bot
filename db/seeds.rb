# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

StateItem::Screen.create(path: 'home', header: 'Начальный экран', description: 'Здесь вы можете увидеть подпункты меню')

StateItem::Screen.create(path: 'home.products', header: 'Список товаров', description: 'Products list')

StateItem::Action.create(path: 'home.products.product1', header: 'Пицца 37 см')
StateItem::Action.create(path: 'home.products.product2', header: 'Пицца 55 см')
StateItem::Action.create(path: 'home.products.product3', header: 'Пиво 55 см')

StateItem::Screen.create(path: 'home.help', header: 'Помощь', description: 'Я бы написал этот раздел, если бы не тратил время попусту')
# StateItem::Screen.create(path: 'home.other', header: 'Другое')
# StateItem::Action(path: 'home.order', header: 'Оформить заказ')

