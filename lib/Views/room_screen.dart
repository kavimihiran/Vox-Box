import 'package:flutter/material.dart';
import '../controllers/room_controller.dart';
import 'package:vox_box/Utils/colors.dart';
import 'chat_screen.dart'; // Your chat screen file

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final TextEditingController _boxNameController = TextEditingController();
  final RoomController _roomControllerCreate = RoomController();

  bool _isPopupOpen = false;
  bool _isCreateNewOpen = false;
  bool _isJoinOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Boxes'),
        centerTitle: true,
        backgroundColor: customColor,
      ),
      body: Stack(
        children: [
          Container(
            color: customColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Please create a new box or join an existing one.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        // Display existing boxes or relevant content here
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isPopupOpen) _buildOptionsContainer(),
          if (_isCreateNewOpen) _buildCreateNewPopup(),
          if (_isJoinOpen) _buildJoinPopup(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isPopupOpen = !_isPopupOpen;
          });
        },
        backgroundColor: customColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildOptionsContainer() {
    return Positioned(
      bottom: 100.0,
      right: 20.0,
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isCreateNewOpen = true;
                  _isJoinOpen = false;
                  _isPopupOpen = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                ),
                child: const Text(
                  'Create new',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isJoinOpen = true;
                  _isCreateNewOpen = false;
                  _isPopupOpen = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: const Text(
                  'Join a box',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateNewPopup() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isCreateNewOpen = false;
          });
        },
        child: Container(
          color: Colors.black.withOpacity(0.5),
          alignment: Alignment.center,
          child: Container(
            width: 300.0,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create New Box',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green),
                  ),
                  child: TextField(
                    controller: _boxNameController,
                    decoration: const InputDecoration(
                      hintText: 'Box Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    String boxName = _boxNameController.text.trim();
                    if (boxName.isNotEmpty) {
                      String roomId =
                          await _roomControllerCreate.createRoom(boxName);
                      if (roomId.isNotEmpty) {
                        if (mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(roomId: roomId),
                            ),
                          );
                        }
                        _boxNameController.clear();
                      } else {
                        print("empty");
                        // Handle error
                      }
                    } else {
                      // Handle empty box name
                      print('Box name cannot be empty.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Create'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJoinPopup() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isJoinOpen = false;
          });
        },
        child: Container(
          color: Colors.black.withOpacity(0.5),
          alignment: Alignment.center,
          child: Container(
            width: 300.0,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Join Box',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green),
                  ),
                  child: TextField(
                    controller: _boxNameController,
                    decoration: const InputDecoration(
                      hintText: 'Room ID',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    String roomId = _boxNameController.text.trim();
                    if (roomId.isNotEmpty) {
                      bool roomExists =
                          await _roomControllerCreate.joinRoom(roomId);
                      if (roomExists) {
                        if (mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(roomId: roomId),
                            ),
                          );
                        }
                      } else {
                        print('Room does not exist.');
                        // Handle room not existing
                      }
                      _boxNameController.clear();
                      setState(() {
                        _isJoinOpen = false;
                      });
                    } else {
                      // Handle empty room ID
                      print('Room ID cannot be empty.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Join'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _boxNameController.dispose();
    super.dispose();
  }
}
