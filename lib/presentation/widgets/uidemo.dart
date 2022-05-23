import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uidemo/api/repository.dart';
import 'package:uidemo/models/data_model.dart';
import 'package:uidemo/presentation/widgets/user_details.dart';

class UIDemo extends StatefulWidget {
  const UIDemo({Key? key}) : super(key: key);

  @override
  State<UIDemo> createState() => _UIDemoState();
}

class _UIDemoState extends State<UIDemo> {
  final PagingController<int, DataModel> _pagingController = PagingController<int, DataModel>(firstPageKey: 1);
  final Repository _repository = Repository();
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _repository.getPage(pageKey);
      final isLastPage = newItems!.length < 6;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginatedListView(),
    );
  }

  PagedListView<int, DataModel> _paginatedListView() {
    return PagedListView.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<DataModel>(
        itemBuilder: (context, item, index) {
          return GestureDetector(
            onTap: () => _onSingleUserTap(item),
            child: Container(
              margin: const EdgeInsets.all(20),
              child: ListTile(
                leading: _userAvatar(item),
                title: Text(
                  "${item.firstName!} ${item.lastName}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.white,
        );
      },
    );
  }

  Container _userAvatar(DataModel item) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.amber),
          borderRadius: BorderRadiusDirectional.circular(5),
        ),
        child: Image.network(item.avatarLink!));
  }

  void _onSingleUserTap(DataModel singleUser) {
    debugPrint("$runtimeType ${singleUser.id}");
    _launchNextPage(singleUser.id!);
  }

  _launchNextPage(int userID) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => UserDetails(userId: userID)));
  }
}
