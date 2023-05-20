import 'package:drink_store/app/models/item_model.dart';
import 'package:drink_store/app/models/order_model.dart';

import '../models/cart_item_model.dart';
import '../models/user_model.dart';

ItemModel item1 = ItemModel(
    name: 'Chakana Nuna Vineyard Malbec',
    description:
        'Tinto orgânico, elaborado com mínima intervenção exclusivamente a partir de Malbec, sem passagem por madeira, mas estagiado durante 8 meses em tanques de concreto sem epóxi. Um vinho que expressa o vigor desta casta sem maquiagem.',
    image: 'assets/images/nuna.png',
    price: 89.00,
    favorite: false);

ItemModel item2 = ItemModel(
    name: 'Altos Las Hormigas Blanco',
    description:
        'Um corte de vinhedos antigos de Semillon, Pedro Gimenez e Chenin Blanc. Um presente para os sentidos.',
    image: 'assets/images/altos.png',
    price: 105.40,
    favorite: false);

ItemModel item3 = ItemModel(
    name: 'Odfjell Orzada Cabernet Sauvignon',
    description:
        'Técnicas sustentáveis de cultivo, conhecimento aprofundado dos terroirs explorados e uma equipe enológica estrelada tornam a Odfjell uma preciosa vinícola do seguimento premium de vinhos do Chile. ',
    image: 'assets/images/odfjeel.png',
    price: 168.30,
    favorite: false);

ItemModel item4 = ItemModel(
    name: 'Stellenrust After Eight Shiraz',
    description:
        'A Stellenrust foi fundada em 1928 e desde então produziu alguns dos vinhos mais notórios que a região de Stellenbosch da África do Sul pode oferecer. Este Shiraz amadurece sob condições climáticas que lhe proporcionam tipicidade e complexidade de fruta a qual, aliada as nuances advindas do estágio em barricas de carvalho francês, o eleva aos patamares dos melhores e mais emblemáticos vinhos elaborados com esta casta no mundo.',
    image: 'assets/images/shiraz.png',
    price: 650.00,
    favorite: false);

ItemModel item5 = ItemModel(
    name: 'Borsao Clásico',
    description:
        'A Bodegas Borsao é conhecida mundialmente por oferecer vinhos complexos, de ótima qualidade, a preços justos. “Se você ainda não experimentou os vinhos de ótimo custo-benefício da Bodegas Borsao, é hora de fazê-lo”, escreveu o crítico Robert Parker.',
    image: 'assets/images/borsao.png',
    price: 75.65,
    favorite: false);

ItemModel item6 = ItemModel(
    name: 'El Enemigo Cabernet Franc',
    description:
        'O El Enemigo é um tinto elegante e encorpado, de grande profundidade de fruta. Elaborado com uvas de vinhedos de altíssima densidade, mereceu 93 pontos de Robert Parker nas safras 2015 e 2017.',
    image: 'assets/images/elenemy.png',
    price: 233.31,
    favorite: false);

List<ItemModel> items = [
  item1,
  item2,
  item3,
  item4,
  item5,
  item6,
];

List<String> categorys = [
  'Tinto',
  'Branco',
  'Rosé',
  'Espumante',
  'Doce',
];

List<CartItemModel> cartItems = [
  CartItemModel(
    item: item1,
    quantity: 1,
  ),
  CartItemModel(
    item: item2,
    quantity: 1,
  ),
  CartItemModel(
    item: item3,
    quantity: 1,
  ),
  CartItemModel(
    item: item4,
    quantity: 1,
  ),
  CartItemModel(
    item: item5,
    quantity: 1,
  ),
  CartItemModel(
    item: item6,
    quantity: 1,
  ),
];

UserModel user = UserModel(
    name: 'Elizio Novais',
    email: 'elizio.neto@outlook.com',
    phone: '(33) 9 98051942',
    cpf: '000.000.000-00',
    password: '');

List<OrderModel> orders = [
  OrderModel(
      id: 'sde321cs',
      createDate: DateTime.parse(
        '2021-09-01 10:00:10.458',
      ),
      updateDate: DateTime.parse(
        '2021-09-01 10:00:10.458',
      ),
      items: cartItems,
      status: 'pending_payment',
      copyAndPaste: 'asfasfweda',
      total: 1321.66
      ),
];
