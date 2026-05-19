import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/reviews_model.dart';
import '../cubit/review/review_cubit.dart';
import 'add_review_screen.dart';

class ReviewsScreen extends StatefulWidget {
  final String productId;

  const ReviewsScreen({super.key, required this.productId});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    // Передаем widget.productId в вызов кубита
    context.read<ReviewCubit>().GetReviews(widget.productId);
  }

  // Вспомогательный метод для подсчета среднего рейтинга
  double _calculateAverageRating(List<ReviewsModel> reviews) {
    if (reviews.isEmpty) return 0.0;
    double sum = reviews.fold(0, (total, current) => total + current.rating);
    return sum / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF5F6F7),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
            "Reviews",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF497FFA)));
          }

          if (state is ReviewError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          }

          if (state is ReviewsLoaded) {
            final reviews = state.reviews;
            final avgRating = _calculateAverageRating(reviews);

            if (reviews.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildHeader(0, 0.0, context),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "No reviews yet. Be the first to add one!",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  _buildHeader(reviews.length, avgRating, context),
                  const SizedBox(height: 25),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        return _buildReviewItem(reviews[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // Верхняя панель: Динамический рейтинг и кнопка "Add Review"
  Widget _buildHeader(int totalReviews, double avgRating, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$totalReviews Reviews",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                    avgRating == 0.0 ? "0.0" : avgRating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black)
                ),
                const SizedBox(width: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < avgRating.round() ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: 13,
                    );
                  }),
                )
              ],
            )
          ],
        ),

        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddReviewScreen()),
            ).then((_) {
              // При возврате с экрана добавления отзыва, обновляем список
              context.read<ReviewCubit>().GetReviews(widget.productId);
            });
          },
          icon: const Icon(Icons.edit_square, color: Colors.white, size: 16),
          label: const Text(
              "Add Review",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13)
          ),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF497FFA),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  // Карточка живого отзыва
  Widget _buildReviewItem(ReviewsModel review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFF5F6F7),
                child: Icon(Icons.person, color: Colors.grey, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey, size: 13),
                        SizedBox(width: 4),
                        Text(
                          "13 Sep, 2020", // Хардкод даты по дизайну Figma
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        "${review.rating}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                      ),
                      const Text(
                        " rating",
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < review.rating.round() ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 11,
                      );
                    }),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.description,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}