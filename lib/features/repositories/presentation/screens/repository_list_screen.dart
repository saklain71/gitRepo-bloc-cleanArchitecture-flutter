
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_test/features/repositories/domain/entities/repository_entity.dart';
import 'package:gemini_test/features/repositories/presentation/bloc/repository_bloc.dart';
import 'package:gemini_test/features/repositories/presentation/bloc/repository_event.dart';
import 'package:gemini_test/features/repositories/presentation/bloc/repository_state.dart';
import 'package:gemini_test/injection_container.dart';

class RepositoryListScreen extends StatefulWidget {
  final String technology;

  const RepositoryListScreen({super.key, required this.technology});

  @override
  State<RepositoryListScreen> createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  late RepositoryBloc _bloc;
  final TextEditingController _searchController = TextEditingController();
  List<RepositoryEntity> _repositories = [];
  List<RepositoryEntity> _filteredRepositories = [];

  @override
  void initState() {
    super.initState();
    _bloc = sl<RepositoryBloc>();
    _bloc.add(GetRepositories(widget.technology));
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _filteredRepositories = _repositories
          .where((repo) =>
              repo.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.technology} Repositories'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search repositories...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<RepositoryBloc, RepositoryState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is RepositoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is RepositoryLoaded) {
                  _repositories = state.repositories;
                  _filteredRepositories = _repositories
                      .where((repo) => repo.name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()))
                      .toList();
                  return ListView.builder(
                    itemCount: _filteredRepositories.length,
                    itemBuilder: (context, index) {
                      final repository = _filteredRepositories[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(repository.owner.avatarUrl),
                          ),
                          title: Text(repository.name),
                          subtitle: Text(repository.description ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(repository.stargazersCount.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is RepositoryError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('No data'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
