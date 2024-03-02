import 'dart:io';

class Screen {
  int id = -1;
  String name = "???";
  String? type;
  String? description;
  List<Screen> routes = [];

  Screen(this.id, this.name, [String? this.description]);

  Screen.room(int id, String name, [String? description])
      : this.id = id,
        this.name = name,
        this.type = 'room',
        this.description = description;

  Screen.item(int id, String name, [String? description])
      : this.id = id,
        this.name = name,
        this.type = 'item',
        this.description = description;

  String get_route_action() {
    String action_str = "";
    // if there is a description, show it
    if (this.description != null) {
      action_str = "${this.description}";
    }

    // if there is none, show defaults
    if (this.description == null) {
      switch (this.type) {
        case 'room':
          action_str = 'Go to [${this.name}]';
          break;
        case 'item':
          action_str = 'Inspect [${this.name}]';
          break;
        default:
          action_str = "???";
      }
    }

    return action_str;
  }
}

Screen switch_screen(Screen curr_screen, int route_idx) {
  if (route_idx < 0 || route_idx > curr_screen.routes.length) {
    print("That's not a valid option.");
    return curr_screen;
  }

  Screen new_screen = curr_screen.routes[route_idx];

  return new_screen;
}

(Screen, Screen) connect_screens(Screen screen_a, Screen screen_b) {
  screen_a.routes.add(screen_b);
  screen_b.routes.add(screen_a);
  return (screen_a, screen_b);
}

bool check_valid_input(Screen curr_screen, int choice_idx) {
  if (choice_idx < 0) {
    return false;
  }

  int no_of_interactibles = curr_screen.routes.length;
  if (choice_idx > no_of_interactibles) {
    return false;
  }

  return true;
}

void print_status(Screen curr_screen) {
  if (curr_screen.type == 'room') {
    print("You are in the [${curr_screen.name}] .");
  } else {
    print("You are at the [${curr_screen.name}]");
  }

  print("What do you want to do?");

  int choice_idx = 0;
  print("[${choice_idx++}]: Stay.");
  for (int i = 0; i < curr_screen.routes.length; i++) {
    //print("[${++choice_idx}]: Go to [${curr_screen.routes[i].name}].");
    print('[${++choice_idx}]: ${curr_screen.routes[i].get_route_action()}');
  }
}

int main() {
  Screen curr_screen;
  int curr_id = 0;
  bool is_gaming = true;
  String? user_input;

  print("Welcome.");

  // Initialize screens
  // test screens, just for testing
  Screen outside = Screen.room(curr_id++, "outside", "Leave the house.");
  Screen living_room = Screen.room(curr_id++, "living screen");
  Screen kitchen = Screen.room(curr_id++, "kitchen");

  Screen knife = Screen.item(curr_id++, "knife");
  Screen painting = Screen.item(curr_id++, "painting", "Stare at [painting].");

  (living_room, kitchen) = connect_screens(living_room, kitchen);
  (living_room, outside) = connect_screens(living_room, outside);
  (kitchen, knife) = connect_screens(kitchen, knife);
  (living_room, painting) = connect_screens(living_room, painting);

  curr_screen = living_room;

  // gameplay loop
  while (is_gaming) {
    print_status(curr_screen);

    // get user input
    user_input = stdin.readLineSync() ?? "";
    int int_user_input = int.tryParse(user_input) ?? -1;

    // check if input is valid
    if (!check_valid_input(curr_screen, int_user_input)) {
      print("That's not a valid option.");
      print("-");
      continue;
    }

    // switch screens
    curr_screen = switch_screen(curr_screen, int_user_input - 1);

    // CR for cleanliness
    print("-");

    if (curr_screen.name == "outside") {
      is_gaming = false;
    }
  }

  print("You went [outside]. Thank god.");

  return 0;
}
