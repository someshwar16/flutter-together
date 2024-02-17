import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_together/src/feature/discovery_page/data/models/model_data.dart';
import 'package:flutter_together/src/feature/discovery_page/data/service/mock_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  final MockApi mockApi = MockApi();
  final RefreshController _refreshController = RefreshController();
  ModelData? modelData;

  int currentPage =
      2; //Set the current page to 2 because the first page is already fetched

  @override
  void initState() {
    super.initState();
    //Fetch data from the API
    _fetchData();
  }

  //Function to fetch data from the API
  Future<void> _fetchData() async {
    final data = await mockApi.fetchPages();
    setState(() {
      modelData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 156, 148),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Together',
          style:
              GoogleFonts.pacifico(fontSize: 30, color: Colors.redAccent[200]),
        ),
      ),
      body: modelData == null //Check if the data is null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : buildBody(),
    );
  }

  Widget buildBody() {
    return SmartRefresher(
      controller: _refreshController,
      //Pull to refresh and load more
      onRefresh: () {
        mockApi.fetchPages(isRefresh: true).then((value) {
          setState(() {
            currentPage = 1;
          });
          _refreshController.refreshCompleted();
        });
      },
      enablePullUp: true,
      //Logic for the pagination
      onLoading: () {
        //On reaching the bottom of the page we will call the API to fetch the next page and add it to the existing list
        mockApi.fetchPages(page: currentPage).then((value) {
          setState(() {
            modelData!.data
                .addAll(value.data); //Add the new data to the existing list
            currentPage++; //Increment the current page
          });
          _refreshController.loadComplete();
        });
      },
      child: _buildList(),
    );
  }

//Function to build the list of data
  Widget _buildList() {
    return ListView.builder(
      itemCount: modelData?.data.length,
      itemBuilder: (context, index) {
        var discover = modelData!.data[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(10),
          child: ListTile(
            style: ListTileStyle.drawer,
            title: Text(
              discover.title,
              style: GoogleFonts.alegreya(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              discover.description,
              style: GoogleFonts.raleway(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: Image.network(discover.image),
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (_) {
                  return CupertinoAlertDialog(
                    title: Text(
                      discover.title,
                      style: GoogleFonts.robotoCondensed(),
                    ),
                    content: Column(
                      children: [
                        Image.network(discover.image),
                        Text(
                          discover.description,
                          style: GoogleFonts.spaceMono(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
