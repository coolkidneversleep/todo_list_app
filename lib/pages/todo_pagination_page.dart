import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hookified_infinite_scroll_pagination/use_paging_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:todo_list_app/api/todo_list_api.dart';
import 'package:todo_list_app/constants/todo_status.dart';
import 'package:todo_list_app/pages/widgets/date_group_title.dart';
import 'package:todo_list_app/pages/widgets/status_button.dart';
import 'package:todo_list_app/pages/widgets/todo_item.dart';
import '../models/todo_item_model.dart';

class TodoPaginationPage extends HookWidget {
  const TodoPaginationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(TodoStatus.TODO);
    final isDismiss = useState(false);
    const pageSize = 10;

    final PagingController<int, TodoItemModel> _pagingController =
        usePagingController(firstPageKey: 0);

    Future<void> _fetchPage(int pageKey) async {
      try {
        final newItems = await TodoListAPI.getTodoList(
            status: selectedTab.value.name, page: pageKey, perPage: pageSize);

        final isLastPage = newItems.tasks.length < 10;

        if (isLastPage) {
          _pagingController.appendLastPage(newItems.tasks);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems.tasks, nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }
    }

    useEffect(() {
      _pagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      return () {
        _pagingController.dispose();
      };
    }, [_pagingController]);

    bool isSameDay(String date1String, String date2String) {
      DateTime date1 = DateTime.parse(date1String);
      DateTime date2 = DateTime.parse(date2String);

      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 173, 180, 255),
          ),
          child: const Icon(
            Icons.add,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(32, 32, 16, 55),
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 225, 229, 255),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(40)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Hi! User',
                            style: TextStyle(
                              color: Color.fromARGB(255, 97, 89, 86),
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            'What do you want to do today :D',
                            style: TextStyle(
                              color: Color.fromARGB(255, 97, 89, 86),
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 173, 180, 255),
                    )
                  ],
                ),
              ),
              Expanded(
                child: PagedListView<int, TodoItemModel>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<TodoItemModel>(
                    itemBuilder: (context, item, index) {
                      final todoList = _pagingController.itemList;
                      if (todoList!.isNotEmpty) {
                        final currentItem = todoList[index];
                        final previousItem =
                            index > 0 ? todoList[index - 1] : null;
                        if (previousItem != null &&
                            isSameDay(previousItem.createdAt,
                                currentItem.createdAt)) {
                          return TodoItem(
                            id: currentItem.id,
                            title: currentItem.title,
                            description: currentItem.description,
                            onDismissItem: (_) {
                              _pagingController.itemList!.removeAt(index);
                              isDismiss.value = true;
                            },
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DateGroupTitle(date: currentItem.createdAt),
                              TodoItem(
                                id: currentItem.id,
                                title: currentItem.title,
                                description: currentItem.description,
                                onDismissItem: (_) {
                                  _pagingController.itemList!.removeAt(index);
                                  isDismiss.value = true;
                                },
                              ),
                            ],
                          );
                        }
                      } else {
                        return const Center(
                          child: Text('You do not have anything to do yet.'),
                        );
                      }
                    },
                    newPageProgressIndicatorBuilder: (_) =>
                        const CircularProgressIndicator(),
                    noItemsFoundIndicatorBuilder: (context) {
                      return const Center(
                        child: Text('You do not have anything to do yet.'),
                      );
                    },
                    firstPageErrorIndicatorBuilder: (context) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Something went wrong.'),
                            const SizedBox(
                              height: 10,
                            ),
                            CupertinoButton(
                                minSize: 0,
                                padding: EdgeInsets.zero,
                                color: const Color.fromARGB(255, 173, 180, 255),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  child: Text(
                                    'Try again',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  _pagingController.refresh();
                                })
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 32,
            right: 32,
            top: MediaQuery.of(context).size.height * 0.32,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              width: MediaQuery.of(context).size.width - 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(255, 246, 241, 241),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusButton(
                    status: 'To-do',
                    onSelectedButton: () {
                      selectedTab.value = TodoStatus.TODO;
                      _pagingController.refresh();
                    },
                    isSelected: selectedTab.value == TodoStatus.TODO,
                  ),
                  StatusButton(
                    status: 'Doing',
                    onSelectedButton: () {
                      selectedTab.value = TodoStatus.DOING;
                      _pagingController.refresh();
                    },
                    isSelected: selectedTab.value == TodoStatus.DOING,
                  ),
                  StatusButton(
                    status: 'Done',
                    onSelectedButton: () {
                      selectedTab.value = TodoStatus.DONE;
                      _pagingController.refresh();
                    },
                    isSelected: selectedTab.value == TodoStatus.DONE,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
