import 'package:mousa_store/features/category_items/models/product_models.dart';

class ProductController {
  ProductController(this._allProducts)
    : _filteredProducts = List.from(_allProducts);
  final List<Product> _allProducts;
  List<Product> _filteredProducts;

  List<Product> get filteredProducts => List.unmodifiable(_filteredProducts);

  void applyFilter(ProductFilter filter) {
    if (filter.isEmpty) {
      _filteredProducts = List.from(_allProducts);
      return;
    }

    _filteredProducts = _allProducts.where((product) {
      // Note: Product uses indices, but ProductFilter now uses names.
      // This controller needs refactoring to match the new filtering system.
      const matchesBrand = true;
      const matchesColor = true;
      final matchesPrice =
          filter.priceRange == null ||
          (product.price >= filter.priceRange!.start &&
              product.price <= filter.priceRange!.end);

      return matchesBrand && matchesColor && matchesPrice;
    }).toList();
  }

  void applySort(ProductSort sort) {
    switch (sort) {
      case ProductSort.mostPopular:
        _filteredProducts.sort((a, b) => b.popularity.compareTo(a.popularity));
        break;
      case ProductSort.nameAZ:
        _filteredProducts.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
        break;
      case ProductSort.nameZA:
        _filteredProducts.sort(
          (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
        );
        break;
      case ProductSort.priceLowHigh:
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSort.priceHighLow:
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSort.latest:
        _filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case ProductSort.featuredDiscounts:
        _filteredProducts.sort((a, b) => b.discount.compareTo(a.discount));
        break;
    }
  }

  void resetFilter() {
    _filteredProducts = List.from(_allProducts);
  }
}
