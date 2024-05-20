import 'package:flutter/material.dart';

class IdnpSelectionWidget extends StatefulWidget {
  const IdnpSelectionWidget({super.key});

  @override
  State<IdnpSelectionWidget> createState() => _IdnpSelectionWidgetState();
}

class _IdnpSelectionWidgetState extends State<IdnpSelectionWidget> {
  SearchController _searchController = SearchController();

  // final TextEditingController _textController = TextEditingController();
  final FocusScopeNode focusNode = FocusScopeNode();
  bool didJustDismiss = false;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: focusNode,
      onFocusChange: (isFocused) {
        print("FocusScope onFocusChange");
        if (isFocused) {
          print("IF FocusScope onFocusChange");
          // didJustDismiss = false;
          focusNode.unfocus();
        }
      },
      child: SearchAnchor.bar(
          isFullScreen: false,
          searchController: _searchController,
          onTap: () {
            print("SearchBar onTap");
            // _searchController.openView();
          },
          onChanged: (_) {
            print("SearchBar onChanged");
            //controller.openView();
            //controller.closeView("");
          },
          keyboardType: TextInputType.number,
          onSubmitted: (text) {
            print("SearchBar onSubmitted ${_searchController.isOpen}");
            //
            // if (_searchController.isOpen){
              _searchController.closeView(text);
            // }
            //
            // print("2 SearchBar onSubmitted ${_searchController.isOpen}");
            // // FocusManager.instance.?.unfocus();
            // FocusScope.of(context).unfocus();
            //
          },
          // // keyboardType: TextInputType.numberWithOptions(),
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return [
            ListTile(
              title: Text("Test"),
              onTap: () {
                controller.closeView("Test");
              },
            ),
          ];
        },
  // viewConstraints:
      ),
    );
  }
}
