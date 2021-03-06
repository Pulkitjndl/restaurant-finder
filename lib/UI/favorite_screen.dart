
import 'package:flutter/material.dart';

import '../BLoC/bloc_provider.dart';
import '../BLoC/favorite_bloc.dart';
import '../DataLayer/restaurant.dart';
import 'restaurant_tile.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
      title: Text('Favorites'),
      ),
       body: StreamBuilder<List<Restaurant>>(
        stream: bloc.favoritesStream,
  
        initialData: bloc.favorites,
        builder: (context, snapshot) {
          List<Restaurant> favorites =
              (snapshot.connectionState == ConnectionState.waiting)
                  ? bloc.favorites
                  : snapshot.data;
    
          if (favorites == null || favorites.isEmpty) {
            return Center(child: Text('No Favorites'));
          }
    
      return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final restaurant = favorites[index];
              return RestaurantTile(restaurant: restaurant);
            },
      );
      },  
      ),
    );
  }
}