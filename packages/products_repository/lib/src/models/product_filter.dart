class ProductFilter {
  String? name;
  String? value;
  ProductFilter({this.name, this.value});
}

final listProductFilter = [
  ProductFilter(name: "All product", value: ""),
  ProductFilter(name: "Simple", value: "simple"),
  ProductFilter(name: "Variable product", value: "variable"),
  ProductFilter(name: "Grouped product", value: "grouped"),
  ProductFilter(name: "External/Affiliate product", value: "external"),
];
