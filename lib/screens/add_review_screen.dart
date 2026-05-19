import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/review/review_cubit.dart';

class AddReviewScreen extends StatefulWidget {
  final String productId; // 1. Добавили поле для ID товара

  const AddReviewScreen({super.key, required this.productId}); // 2. Добавили в конструктор

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double _rating = 3.0;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Add Review", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<ReviewCubit, ReviewState>(
        listener: (context, state) {
          if (state is ReviewSuccess) {
            Navigator.pop(context); // Возвращаемся назад при успешном добавлении
          } else if (state is ReviewError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Type your name",
                  fillColor: const Color(0xFFF5F6F7),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              const Text("How was your experience ?", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Describe your experience",
                  fillColor: const Color(0xFFF5F6F7),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              Text("Rating: ${_rating.toStringAsFixed(1)}", style: const TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                value: _rating,
                min: 1.0,
                max: 5.0,
                divisions: 4,
                activeColor: const Color(0xFF497FFA),
                onChanged: (value) => setState(() => _rating = value),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF497FFA)),
                  onPressed: () {
                    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
                      return;
                    }
                    // 3. Передаем живой widget.productId в Кубит
                    context.read<ReviewCubit>().CreateReview(
                      productId: widget.productId,
                      name: _nameController.text.trim(),
                      description: _descriptionController.text.trim(),
                      rating: _rating,
                    );
                  },
                  child: const Text("Submit Review", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}