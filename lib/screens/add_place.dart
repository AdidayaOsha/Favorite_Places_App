import 'dart:io';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class screen
// Use ConsumerStatefulWidget form the Riverpod to manage global state
class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

// class screen that is override with this stateful screen
  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  // CONTROLLER
  final _titleController = TextEditingController();
  File? _selectedImage;

  // FUNCTIONS
  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }
    // ref are used to reach to access our provider
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!);

    // use Pop to leave the screen
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // new screen always start with scaffold
    return Scaffold(
      appBar: AppBar(title: const Text('Add new place')),
      body: SingleChildScrollView(
        // singlechildscrollview has an inbuilt padding
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              // input decoration to add label etc to the input
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),

            const SizedBox(height: 10),
            // IMAGE INPUT
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 10),
            const LocationInput(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            )
          ],
        ),
      ),
    );
  }
}
