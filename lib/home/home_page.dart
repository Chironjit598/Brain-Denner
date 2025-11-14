import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brain_denner/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Brain Denner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: c.textController,
                focusNode: c.focusNode,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter your name...',
                ),
                onChanged: c.onTextChanged,
                onSubmitted: (_) => c.submit(),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                offset: c.showButton.value ? Offset.zero : const Offset(0, 0.2),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  opacity: c.showButton.value ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: c.showButton.value ? c.submit : null,
                        child: const Text('Continue'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}