import 'dart:io';

class Room {
  int id = -1;
  String? name;
  List<Room> routes = [];

  Room(this.id, this.name);
}

void print_status(Room curr_room) {
  print("You are at the ${curr_room.name} .");
  print("Where do you want to go?");

  for (int i = 0; i < curr_room.routes.length; i++) {
    print("${i}: ${curr_room.routes[i].name}");
  }
}

Room switch_room(Room curr_room, int route_idx) {
  if (route_idx < 0 || route_idx > curr_room.routes.length) {
    print("That's not a valid option.");
    return curr_room;
  }

  Room new_room = curr_room.routes[route_idx];

  print("You go to [${new_room.name}].");
  return new_room;
}

int main() {
  Room curr_room;
  bool is_gaming = true;
  String? user_input;

  print("Welcome.");

  // Initialize rooms
  // test rooms, just for testing
  Room living_room = Room(0, "living room");
  Room kitchen = Room(1, "kitchen");
  Room outside = Room(2, "outside");

  living_room.routes.add(kitchen);
  living_room.routes.add(outside);
  kitchen.routes.add(living_room);
  outside.routes.add(living_room);
  curr_room = living_room;

  // gameplay loop
  while (is_gaming) {
    print_status(curr_room);

    // get user input
    user_input = stdin.readLineSync() ?? "";
    int int_user_input = int.tryParse(user_input) ?? -1;

    // check if input is valid

    // switch rooms
    curr_room = switch_room(curr_room, int_user_input);

    // CR for cleanliness
    print("-");

    if (curr_room.name == "outside") {
      is_gaming = false;
    }
  }

  print("You went [outside]. Thank god.");

  return 0;
}
