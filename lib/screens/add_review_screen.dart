import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/theme/colors.dart';
import '../../cubit/review/review_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Review", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<ReviewCubit, ReviewState>(
        // СЛУШАТЕЛЬ ДЛЯ НАВИГАЦИИ И ОШИБОК
        listener: (context, state) {
          if (state is ReviewSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Review added successfully!")),
            );
            Navigator.pop(context); // Возвращаемся назад после успеха
          }
          if (state is ReviewError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInput(
                label: "Name",
                hint: "Type your name",
                controller: _nameController,
              ),
              const SizedBox(height: 20),
              CustomInput(
                label: "How was your experience?",
                hint: "Describe your experience",
                controller: _descController,
                maxLines: 5,
              ),
              const SizedBox(height: 25),
              const Text("Rating", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(_rating.toStringAsFixed(1), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Slider(
                      value: _rating,
                      min: 1.0,
                      max: 5.0,
                      divisions: 40,
                      activeColor: const Color(0xFF3D93F8),
                      onChanged: (val) => setState(() => _rating = val),
                    ),
                  ),
                  const Text("5.0"),
                ],
              ),
              const Spacer(),
              // КНОПКА С ОБРАБОТКОЙ ЗАГРУЗКИ
              BlocBuilder<ReviewCubit, ReviewState>(
                builder: (context, state) {
                  return CustomButton(
                    text: state is ReviewLoading ? "Submitting..." : "Submit Review",
                    onPressed: state is ReviewLoading
                        ? () {} // Блокируем кнопку при загрузке
                        : () {
                      if (_nameController.text.isNotEmpty && _descController.text.isNotEmpty) {
                        context.read<ReviewCubit>().CreateReview(
                          name: _nameController.text,
                          description: _descController.text,
                          rating: _rating,
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}