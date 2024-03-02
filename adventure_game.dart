import 'dart:io';

class Interactible {
  int id = -1;
  String name = "???";
  String type = "-";
  String description = "";

  Interactible(this.id, this.name, this.type);
}

class Item extends Interactible {
  List<Item> items = [];

  Item(int id, String name) : super(id, name, 'item');
}

class Room extends Interactible {
  List<Room> routes = [];
  List<Item> items = [];

  Room(int id, String name) : super(id, name, 'room');
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

(Room, Room) connect_rooms(Room room_a, Room room_b) {
  room_a.routes.add(room_b);
  room_b.routes.add(room_a);
  return (room_a, room_b);
}

bool check_valid_input(Room curr_room, int choice_idx) {
  if (choice_idx < 0) {
    return false;
  }

  int no_of_interactibles = curr_room.routes.length + curr_room.items.length;
  if (choice_idx > no_of_interactibles) {
    return false;
  }

  return true;
}

void print_status(Room curr_room) {
  print("You are at the [${curr_room.name}] .");
  print("What do you want to do?");

  int choice_idx = 0;
  print("[0]: Stay.");
  for (int i = 0; i < curr_room.routes.length; i++) {
    print("[${++choice_idx}]: Go to [${curr_room.routes[i].name}].");
  }
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

  (living_room, kitchen) = connect_rooms(living_room, kitchen);
  (living_room, outside) = connect_rooms(living_room, outside);

  curr_room = living_room;

  // gameplay loop
  while (is_gaming) {
    print_status(curr_room);

    // get user input
    user_input = stdin.readLineSync() ?? "";
    int int_user_input = int.tryParse(user_input) ?? -1;

    // check if input is valid
    if (!check_valid_input(curr_room, int_user_input)) {
      print("That's not a valid option.");
      print("-");
      continue;
    }

    // switch rooms
    curr_room = switch_room(curr_room, int_user_input - 1);

    // CR for cleanliness
    print("-");

    if (curr_room.name == "outside") {
      is_gaming = false;
    }
  }

  print("You went [outside]. Thank god.");

  return 0;
}
