import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/note_model.dart';
import 'auth_services.dart';

class NotesService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _notesCollection = _firestore.collection('notes');

  // Get all notes for the current user
  static Stream<List<NoteModel>> getNotes() {
    final userId = AuthService.getUserId();
    if (userId == null) {
      return Stream.value([]);
    }

    return _notesCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return NoteModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Get a single note by ID
  static Future<NoteModel?> getNoteById(String noteId) async {
    final userId = AuthService.getUserId();
    if (userId == null) {
      return null;
    }

    final docSnapshot = await _notesCollection.doc(noteId).get();
    if (!docSnapshot.exists) {
      return null;
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    if (data['userId'] != userId) {
      return null; }

    return NoteModel.fromMap(docSnapshot.id, data);
  }

  // Add a new note
  static Future<String> addNote(String title, String description) async {
    final userId = AuthService.getUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final docRef = await _notesCollection.add({
      'title': title,
      'description': description,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return docRef.id;
  }

  // Update an existing note
  static Future<void> updateNote(String noteId, String title, String description) async {
    final userId = AuthService.getUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Verify the note belongs to the current user
    final docSnapshot = await _notesCollection.doc(noteId).get();
    if (!docSnapshot.exists) {
      throw Exception('Note not found');
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    if (data['userId'] != userId) {
      throw Exception('Unauthorized access to note');
    }

    await _notesCollection.doc(noteId).update({
      'title': title,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete a note
  static Future<void> deleteNote(String noteId) async {
    final userId = AuthService.getUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Verify the note belongs to the current user
    final docSnapshot = await _notesCollection.doc(noteId).get();
    if (!docSnapshot.exists) {
      throw Exception('Note not found');
    }

    final data = docSnapshot.data() as Map<String, dynamic>;
    if (data['userId'] != userId) {
      throw Exception('Unauthorized access to note');
    }

    await _notesCollection.doc(noteId).delete();
  }
}
