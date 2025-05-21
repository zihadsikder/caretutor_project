import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../data/common/widgets/app_snackber.dart';
import '../../../data/models/note_model.dart';
import '../../../services/auth_services.dart';
import '../../../services/note_services.dart';

class HomeViewController extends GetxController {
  final RxList<NoteModel> notes = <NoteModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  void fetchNotes() {
    isLoading.value = true;
    try {
      NotesService.getNotes().listen((notesList) {
        notes.value = notesList;
        isLoading.value = false;
      }, onError: (error) {
        AppSnackBar.showError('Failed to load notes: ${error.toString()}');
        isLoading.value = false;
      });
    } catch (e) {
      AppSnackBar.showError('An error occurred: ${e.toString()}');
      isLoading.value = false;
    }
  }

  List<NoteModel> get filteredNotes {
    if (searchQuery.isEmpty) {
      return notes;
    }
    return notes.where((note) {
      return note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          note.description.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void navigateToAddNote() {
    GoRouter.of(Get.context!).push('/add-note');
  }

  void navigateToEditNote(String noteId) {
    GoRouter.of(Get.context!).push('/edit-note/$noteId');
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await NotesService.deleteNote(noteId);
      AppSnackBar.showSuccess('Note deleted successfully');
    } catch (e) {
      AppSnackBar.showError('Failed to delete note: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await AuthService.signOut();
      GoRouter.of(Get.context!).go('/auth');
    } catch (e) {
      AppSnackBar.showError('Failed to sign out: ${e.toString()}');
    }
  }
}
