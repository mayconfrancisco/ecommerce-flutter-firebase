import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/data/product_data.dart';
import 'package:ecommerce_flutter/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot categorySnapshot;

  CategoryScreen(this.categorySnapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(categorySnapshot.data['title']),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Grid',
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  text: 'Lista',
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection('products')
                .document(categorySnapshot.documentID)
                .collection('items')
                .getDocuments(),
            builder: (context, snapshotItems) {
              if (!snapshotItems.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TabBarView(
                    physics:
                        NeverScrollableScrollPhysics(), //não scrola para as laterais como no PageView
                    children: [
                      GridView.builder(
                          padding: EdgeInsets.all(4),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  childAspectRatio: 0.65),
                          itemCount: snapshotItems.data.documents.length,
                          itemBuilder: (context, index) {
                            ProductData productData = ProductData.fromDocument(
                                snapshotItems.data.documents[index]);
                            productData.category =
                                this.categorySnapshot.documentID;
                            return ProductTile("grid", productData);
                          }),
                      ListView.builder(
                        padding: EdgeInsets.all(4),
                        itemCount: snapshotItems.data.documents.length,
                        itemBuilder: (context, index) {
                          ProductData productData = ProductData.fromDocument(
                              snapshotItems.data.documents[index]);
                          productData.category =
                              this.categorySnapshot.documentID;
                          return ProductTile("list", productData);
                        },
                      ),
                    ]);
              }
            },
          ),
        ));
  }
}
