import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../controllers/auth_controller.dart';
import '../controllers/room_controller.dart';
import '../controllers/message_controller.dart';
import '../Services/firebase_services.dart';

List<SingleChildWidget> providers = [
  Provider<FirebaseService>(create: (_) => FirebaseService()),
  ChangeNotifierProvider<AuthController>(
      create: (context) => AuthController(context.read<FirebaseService>())),
  ChangeNotifierProvider<RoomController>(create: (_) => RoomController()),
  ChangeNotifierProvider<MessageController>(create: (_) => MessageController()),
];
