import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_filters/models/flight.dart';

import 'flights.dart';

final flightsProvider = Provider<List<Flight>>((ref) => flightsList);

final directFilterProvider = StateProvider<bool>((_) => false);
final priceFilterProvider = StateProvider<num>((_) => 0);

final filteredFlights = Provider<List<Flight>>((ref) {
  final flights = ref.watch(flightsProvider);
  final direct = ref.watch(directFilterProvider).state; // 1
  final price = ref.watch(priceFilterProvider).state;

  var filteredFlightsList =
      flights.where((flight) => flight.direct == direct); // 2

  if (price > 0) {
    // 3
    filteredFlightsList =
        filteredFlightsList.where((flight) => flight.price < price);
  }

  return filteredFlightsList.toList(); // 4
});
