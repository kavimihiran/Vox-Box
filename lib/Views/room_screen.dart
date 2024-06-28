import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool _isPopupOpen = false;
  bool _isCreateNewOpen = false;
  bool _isJoinOpen = false;
  TextEditingController _boxNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'My Boxes',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
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
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
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
          boxShadow: [
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
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Text(
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
                padding: EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: Text(
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
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
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
                Text(
                  'Create New Box',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green),
                  ),
                  child: TextField(
                    controller: _boxNameController,
                    decoration: InputDecoration(
                      hintText: 'Box Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement logic for creating a new box
                    setState(() {
                      _isCreateNewOpen = false;
                    });
                    // Access _boxNameController.text for the box name entered
                    String boxName = _boxNameController.text;
                    // Add your logic here to create the box with the given name
                    // For now, just print the box name
                    print('Creating new box: $boxName');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Create'),
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
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
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
                Text(
                  'Join a Box',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                // Add UI components for joining a box (if needed)
                Text('Join functionality to be implemented'),
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
