import 'dart:io';

class Room {
  int id = -1;
  String? name;
  List<Room> routes = [];

  Room(this.id, this.name);
}

// TODO: function to check if room exists

void print_status(curr_room) {
  String? user_input;

  print("You are at the " + curr_room.name + " .");
  print("Where do you want to go?");

  for (int i = 0; i < curr_room.routes.length; i++) {
    print("${i}: ${curr_room.routes[0].name}");
  }

  user_input = stdin.readLineSync();

  // TODO check if room exists
  curr_room = curr_room.routes[0];
}

int main() {
  Room? curr_room;
  bool is_gaming = true;

  print("Welcome.");

  // Initialize rooms
  // test rooms, just for testing
  Room living_room = Room(0, "living room");
  Room kitchen = Room(1, "kitchen");

  living_room.routes.add(kitchen);
  kitchen.routes.add(living_room);

  curr_room = living_room;

  // gameplay loop
  while (is_gaming) {
    print_status(curr_room);
    print("aaa");
  }

  return 0;
}
