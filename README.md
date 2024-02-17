
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



https://github.com/someshwar16/flutter-together/assets/83568897/488d62d1-35b3-4c4b-ab40-cbf46cd9e347

![01](https://github.com/someshwar16/flutter-together/assets/83568897/5ecfabc9-6eef-4ca8-a5ca-21485d7df188)
![02](https://github.com/someshwar16/flutter-together/assets/83568897/4d41ecbb-87c3-4f61-8c52-b57da1cb8c0b)
![03](https://github.com/someshwar16/flutter-together/assets/83568897/a514e29b-9cc0-4c07-aa83-c2fd56532ef4)

# IOS Screenshot

<img width="400" alt="image" src="https://github.com/someshwar16/flutter-together/assets/83568897/1188bc86-9508-4b69-8497-764e1a368a0c">
<img width="393" alt="image" src="https://github.com/someshwar16/flutter-together/assets/83568897/d391839a-9d6d-404a-a5b2-909ba7a9f912">




