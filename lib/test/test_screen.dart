import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/test_cubit.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TestCubit, TestState>(
        builder: (context, state) {
          if (state is TestLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TestError) {
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          }

          if (state is TestSuccess) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.5,
              ),
              itemCount: state.data.length,
              itemBuilder: (context, index,) {
                return Container(
                  color: Colors.grey.shade100,
                  child: Column(
                    children: [
                      Image.network(state.data[index].imageUrl!),
                      Text(state.data[index].title),
                      Text(state.data[index].price.toString()),
                      Text(state.data[index].currency),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: ElevatedButton(onPressed: (){
              context.read<TestCubit>().getProducts();
            }, child: Text('Get products'),
            ),
          );
        },
      ),
    );
  }
}
