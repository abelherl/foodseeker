import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class RecipeModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String image;

  RecipeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }

  factory RecipeModel.example() {
    return RecipeModel(
      id: "2807982c-986a-4def-9e3a-153a3066af7a",
      name: "Ultimate Keto Blueberry Sponge Cake In A Mug",
      description:
          "Instead of making pancakes or waffles, make this easy Keto breakfast recipe that takes way less time to make. This blueberry sponge cake in a mug is soft and fluffy like a pancake but sweet like a cake. Don’t worry, you won’t be adding many carbs to your breakfast, as all sweetening products are replaced with Keto-friendly ingredients. You can assemble the recipe in under 5 minutes, so this is also a great Keto breakfast recipe for anyone who always ends up in a rush in the mornings. Even if you’re in a rush, you can still enjoy this sweet and delicious sponge cake breakfast! If you want to serve your sponge cake with a little whipped cream, you can whip heavy cream and liquid stevia together in a stand mixer or food processor.\n\n### Other ingredients to add\n\nLike to have a little more in your sponge cake? Try stirring in crushed nuts for more texture. Keto-friendly nuts include cashews, walnuts, pecan, hazelnuts, and even peanuts. Blueberries also happen to taste very good with lemon. Try mixing a little lemon zest in your dry ingredients!\n\n### Can other berries be used?\n\nBlueberries are one of the most Keto-friendly berries out there. If you don’t like blueberries, try raspberries or strawberries. If you’re using strawberries in the mug cake, make sure to chop them finely.\n\n### What type of mug should I use?\n\nA heat-safe mug or dish can easily be a coffee cup from your kitchen. Choose any type of ceramic mug to keep your hands safe as well as cook the sponge cake. If you own a ceramic ramekin, you can also cook your sponge cake in there.",
      image:
          "https://tinyurl.com/2p82zzca/2807982c-986a-4def-9e3a-153a3066af7a.png",
    );
  }

  factory RecipeModel.example2() => RecipeModel(
        id: "1807982c-986a-4def-9e3a-153a3066af7a",
        name: "A Different Pizza Recipe",
        description:
            "Instead of making pancakes or waffles, make this easy Keto breakfast recipe that takes way less time to make. This blueberry sponge cake in a mug is soft and fluffy like a pancake but sweet like a cake. Don’t worry, you won’t be adding many carbs to your breakfast, as all sweetening products are replaced with Keto-friendly ingredients. You can assemble the recipe in under 5 minutes, so this is also a great Keto breakfast recipe for anyone who always ends up in a rush in the mornings. Even if you’re in a rush, you can still enjoy this sweet and delicious sponge cake breakfast! If you want to serve your sponge cake with a little whipped cream, you can whip heavy cream and liquid stevia together in a stand mixer or food processor.\n\n### Other ingredients to add\n\nLike to have a little more in your sponge cake? Try stirring in crushed nuts for more texture. Keto-friendly nuts include cashews, walnuts, pecan, hazelnuts, and even peanuts. Blueberries also happen to taste very good with lemon. Try mixing a little lemon zest in your dry ingredients!\n\n### Can other berries be used?\n\nBlueberries are one of the most Keto-friendly berries out there. If you don’t like blueberries, try raspberries or strawberries. If you’re using strawberries in the mug cake, make sure to chop them finely.\n\n### What type of mug should I use?\n\nA heat-safe mug or dish can easily be a coffee cup from your kitchen. Choose any type of ceramic mug to keep your hands safe as well as cook the sponge cake. If you own a ceramic ramekin, you can also cook your sponge cake in there.",
        image:
            "https://tinyurl.com/2p82zzca/2807982c-986a-4def-9e3a-153a3066af7a.png",
      );
}

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final typeId = 0;

  @override
  RecipeModel read(BinaryReader reader) {
    return RecipeModel(
      id: reader.read(),
      name: reader.read(),
      description: reader.read(),
      image: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..write(obj.id)
      ..write(obj.name)
      ..write(obj.description)
      ..write(obj.image);
  }
}
