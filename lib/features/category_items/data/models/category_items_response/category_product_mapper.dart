import 'package:mousa_store/features/brands/domain/entities/brand.dart'
    as core_brand;
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

final _products = Expando<Product>('category-product');

extension CategoryProductMapper on CategoryProduct {
  Product toProduct() => _products[this] ??= Product(
    id: id ?? 0,
    minQuantity: minQuantity,
    stock: stock,
    createdAt: createdAt,
    updatedAt: updatedAt,
    brandId: brandId,
    name: name ?? '',
    desc: desc ?? '',
    price: price ?? '0',
    imagePath: imagePath ?? '',
    imagesPath: imagesPath ?? [],
    brand: brand == null
        ? null
        : core_brand.Brand(
            id: brand!.id ?? 0,
            name: brand!.name ?? '',
            imagePath: brand!.imagePath ?? '',
          ),
    offers: offers,
    variants: variants,
  );
}
