
# Flutter Together 

This application showcase the basic API calling from mock API. In this application we are reteriving the data from mock API and implemented the pagination i.e. added infinite scroll.

For Code Design I have used following pattern 

       main.dart
       \lib\src\feature\
                    discovery_page\
                                data\model
                                        \info_data.dart
                                        \model_data.dart
                                data\service\mock_api.dart
                                view\discovery_page.dart
    



## Implementing Pagination 


For implementing pagination I have used pull_to_refresh package. I wrapped my ListView Builder with SmartRefresher and attached the RefreshController with it.

 ```
   final RefreshController _refreshController = RefreshController();
```
I used onRefresh to implement the pull down refresh feature and used onLoading to implement the pagination logic.

```
onRefresh: () {
        mockApi.fetchPages(isRefresh: true).then((value) {
          setState(() {
            currentPage = 1;
          });
          _refreshController.refreshCompleted();
        });
      },
```

```
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
```

In my MockApi class I proceed by taking currentPage as parameter. And append it with our URL tot get the next page data.

```
 final url =
        'https://api-stg.together.buzz/mocks/discovery?page=$page&limit=10';
```
## Run Locally

Clone the project

```bash
  git clone https://github.com/someshwar16/flutter-together.git
```

Go to the project directory

```bash
  cd flutter_together
```

Install dependencies

```bash
  flutter pub get 
```

Run the application

```bash
  flutter run
```


## Screenshots

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)

