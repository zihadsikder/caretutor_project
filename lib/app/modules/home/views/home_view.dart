import 'package:caretutor_project/app/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../data/common/widgets/custom_text.dart';
import '../controllers/home_controller.dart';
import 'note_card.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'My Notes',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textPrimary),
            onPressed: () => controller.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
          // Notes list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ),
                );
              }

              if (controller.notes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.note_alt_outlined,
                        size: 80.sp,
                        color: AppColors.textSecondary.withOpacity(0.5),
                      ),
                      SizedBox(height: 16.h),
                      CustomText(
                        text: 'No notes yet',
                        fontSize: 18.sp,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Tap the + button to create a new note',
                        fontSize: 14.sp,
                        color: AppColors.textSecondary.withOpacity(0.7),
                      ),
                    ],
                  ),
                );
              }

              final filteredNotes = controller.filteredNotes;

              if (filteredNotes.isEmpty) {
                return Center(
                  child: CustomText(
                    text: 'No notes match your search',
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = filteredNotes[index];
                  return NoteCard(
                    note: note,
                    onTap: () => controller.navigateToEditNote(note.id),
                    onDelete: () => controller.deleteNote(note.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToAddNote,
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
