import '../models/Item.dart';
import '../models/category.dart';

List<Category> CATEGORIES = [
  Category(
    id: 'c1',
    name: 'Cake',
    imagePath: 'assets/images/categories/c3.png',
    selectedImagePath: 'assets/images/categories/c3_selected.png',
  ),
  Category(
      id: 'c2',
      name: 'Snack',
      imagePath: 'assets/images/categories/c2.png',
      selectedImagePath: 'assets/images/categories/c2_selected.png'),
  Category(
    id: 'c3',
    name: 'Bread',
    imagePath: 'assets/images/categories/c1.png',
    selectedImagePath: 'assets/images/categories/c1_selected.png',
  ),
  Category(
    id: 'c4',
    name: 'Sweets',
    imagePath: 'assets/images/categories/c4.png',
    selectedImagePath: 'assets/images/categories/c4_selected.png',
  ),
];

List<Item> ITEMS = [
  // cakes c1
  Item(
    id: 'i1',
    title: 'Tutti Frutti Cake',
    itemCategory: 'c1',
    description:
        'Tutti Frutti Cake – A fun take on tutti frutti dessert, a sponge cake topped with fresh cream and jelly chunks.',
    prices: {
      Size.OnePound: {'1 LBS': 400},
      Size.TwoPound: {'2 LBS': 800},
    },
    imagePath: 'assets/images/items/item1c1.png',
  ),
  Item(
    id: 'i2',
    title: 'Black Forest',
    itemCategory: 'c1',
    description:
        'All-time favourite, elevated by the inclusion of premium chocolate chips and maraschino cherries.',
    prices: {
      Size.OnePound: {'1 LBS': 500},
      Size.TwoPound: {'2 LBS': 1000},
    },
    imagePath: 'assets/images/items/item2c1.png',
  ),
  Item(
    id: 'i3',
    title: 'Coffee Caramel',
    itemCategory: 'c1',
    description:
        'Freshly baked cake frosted with the goodness of caramel cream with a pinch of coffee each bite is simply divine.',
    prices: {
      Size.OnePound: {'1 LBS': 800},
      Size.TwoPound: {'2 LBS': 1200},
    },
    imagePath: 'assets/images/items/item3c1.png',
  ),
  Item(
    id: 'i17',
    title: 'Almond Macaroon',
    itemCategory: 'c1',
    description: 'A dry almond infused sponge cake, splattered with almonds.',
    prices: {
      Size.OnePound: {'1 LBS': 450},
      Size.TwoPound: {'2 LBS': 850},
    },
    imagePath: 'assets/images/items/item4c1.png',
  ),

  // Bread c3
  Item(
    id: 'i12',
    title: 'Phool Bun',
    itemCategory: 'c3',
    description:
        'Surreal bun topped with sesmi seeds and baked to be perfectly brown this phool shaped bun offers an exciting sharable bun time!',
    prices: {
      Size.None: {
        '': 60,
      },
    },
    imagePath: 'assets/images/items/item1c3.png',
  ),
  Item(
    id: 'i13',
    title: 'Hard Bread',
    itemCategory: 'c3',
    description:
        'Well baked with the awesome taste of a side food, this hard bread is perfect if you can get crafty while being foody.',
    prices: {
      Size.None: {
        '': 70,
      },
    },
    imagePath: 'assets/images/items/item2c3.png',
  ),
  Item(
    id: 'i14',
    title: 'Fruit Bun',
    itemCategory: 'c3',
    description:
        'Sweet little pleasantly awesome fruit bun has little chunks of jelly topping and sugar toppings. Goes with any of your meal breaks or tea-time.',
    prices: {
      Size.None: {
        '': 30,
      },
    },
    imagePath: 'assets/images/items/item3c3.png',
  ),
  Item(
    id: 'i15',
    title: 'Dinner Bun',
    itemCategory: 'c3',
    description:
        'Have a good time at your table when your dinner bun is right on your plate. Try it out now for a traditionally legit dinner.',
    prices: {
      Size.None: {
        '': 30,
      },
    },
    imagePath: 'assets/images/items/item4c3.png',
  ),
  Item(
    id: 'i16',
    title: 'Sada Bread',
    itemCategory: 'c3',
    description:
        'Plain bread, to serve as the base of all your favorite snacks.',
    prices: {
      Size.None: {
        '': 70,
      },
    },
    imagePath: 'assets/images/items/item5c3.png',
  ),

  // sweats c4
  Item(
    id: 'i4',
    title: 'Gulab Jamun',
    itemCategory: 'c4',
    description:
        'Gulab jamun we create is garnished with dried nuts such as almonds and pista to '
        'enhance flavour, soft tempting gulab jamun are what you need right away.',
    prices: {
      Size.Quarter: {'250g': 400},
      Size.HalfKg: {'500g': 800},
      Size.OneKg: {'700g': 1000},
      Size.ThreeQuarter: {'1Kg': 1200},
    },
    imagePath: 'assets/images/items/item1c4.png',
  ),
  Item(
    id: 'i5',
    title: 'White Chamcham',
    itemCategory: 'c4',
    description:
        'Cham-Chams we make are truly delicious and very sweet indeed. '
        'It is coated with coconut flakes as a garnish.',
    prices: {
      Size.Quarter: {'250g': 400},
      Size.HalfKg: {'500g': 800},
      Size.OneKg: {'700g': 1000},
      Size.ThreeQuarter: {'1Kg': 1200},
    },
    imagePath: 'assets/images/items/item2c4.png',
  ),
  Item(
    id: 'i6',
    title: 'Pink Chamcham',
    itemCategory: 'c4',
    description:
        'Pink cham-Chams we make are truly delicious and very sweet indeed. It is coated with coconut flakes as a garnish.',
    prices: {
      Size.Quarter: {'250g': 400},
      Size.HalfKg: {'500g': 800},
      Size.OneKg: {'700g': 1000},
      Size.ThreeQuarter: {'1Kg': 1200},
    },
    imagePath: 'assets/images/items/item3c4.png',
  ),
  Item(
    id: 'i6',
    title: 'Heart Shape Barfi',
    itemCategory: 'c4',
    description:
        'Heart-shaped barfi the perfect traditional sweet topped with dry fruits.',
    prices: {
      Size.Quarter: {'250g': 400},
      Size.HalfKg: {'500g': 800},
      Size.OneKg: {'700g': 1000},
      Size.ThreeQuarter: {'1Kg': 1200},
    },
    imagePath: 'assets/images/items/item4c4.png',
  ),
  Item(
    id: 'i6',
    title: 'Habshi Halwa',
    itemCategory: 'c4',
    description:
        'To satisfy your sweet tooth we present Habshi halwa, which is a sticky-sweet, mostly consumed during the winter months, made with the wheat extract.',
    prices: {
      Size.Quarter: {'250g': 400},
      Size.HalfKg: {'500g': 800},
      Size.OneKg: {'700g': 1000},
      Size.ThreeQuarter: {'1Kg': 1200},
    },
    imagePath: 'assets/images/items/item5c4.png',
  ),
  Item(
    id: 'i6',
    title: 'Milky Patisa',
    itemCategory: 'c4',
    description:
        'Black&brown bakers milky patisa is gram flour collated with thick milk and sweet cane sugar, to give it a unique rich taste.',
    prices: {
      Size.Quarter: {'250g': 400},
      Size.HalfKg: {'500g': 800},
      Size.OneKg: {'700g': 1000},
      Size.ThreeQuarter: {'1Kg': 1200},
    },
    imagePath: 'assets/images/items/item6c4.png',
  ),

  // snacks c2
  Item(
    id: 'i7',
    title: 'Zinger Burger',
    itemCategory: 'c2',
    description:
        'Batter-coated fried chicken spread with mayo, lettuce and chopped cabbage, Black&Brown’s very own Zinger Burger every day freshly served.',
    prices: {
      Size.None: {
        '': 800,
      },
    },
    imagePath: 'assets/images/items/item1c2.png',
  ),
  Item(
    id: 'i8',
    title: 'Chicken Spring Roll',
    itemCategory: 'c2',
    description:
        'Preserving the history of spring roll cuisine and revolutionizing it we craft some of the well-baked and stuffed rolls.',
    prices: {
      Size.None: {
        '': 800,
      },
    },
    imagePath: 'assets/images/items/item2c2.png',
  ),
  Item(
    id: 'i9',
    title: 'Vegetable Patties',
    itemCategory: 'c2',
    description:
        'Carefully filled with fresh vegetables and baked till golden, these patties look just like ordinary patties but are far healthier and tastier.',
    prices: {
      Size.None: {
        '': 800,
      },
    },
    imagePath: 'assets/images/items/item3c2.png',
  ),
  Item(
    id: 'i10',
    title: 'Chicken Pizza',
    itemCategory: 'c2',
    description:
        'Chicken pizza layered with onions, oregano, cheese, and chicken. Topped with black olives and minced capsicum.',
    prices: {
      Size.Small: {
        'Small': 300,
      },
      Size.Medium: {
        'Medium': 600,
      },
      Size.Large: {
        'Large': 1200,
      },
    },
    imagePath: 'assets/images/items/item4c2.png',
  ),
  Item(
    id: 'i11',
    title: 'Chicken Shashlik Sandwich',
    itemCategory: 'c2',
    description:
        'Just as good and as simple but why not shashlik flavor? Here it is, the widely enjoyed and savored sandwich.',
    prices: {
      Size.None: {
        '': 300,
      },
    },
    imagePath: 'assets/images/items/item5c2.png',
  ),
];
