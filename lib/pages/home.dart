import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/model/article_model.dart';
import 'package:newsapp/model/category_model.dart';
import 'package:newsapp/model/slider_model.dart';
import 'package:newsapp/pages/all_news.dart';
import 'package:newsapp/pages/article_view.dart';
import 'package:newsapp/pages/category_news.dart';
import 'package:newsapp/service/data.dart';
import 'package:newsapp/service/news.dart';
import 'package:newsapp/service/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading =true;
  int activeIndex = 0 ;
  @override
  void initState() {
    // TODO: implement initState
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }
  getNews()async{
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading=false;
      
    });

  }
  getSlider()async{
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
   

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Flutter'),
          Text('News', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)

        ],),
        centerTitle: true,
        elevation: 0.0,

      ),
      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                
                  shrinkWrap: true,
                  itemCount: categories.length,itemBuilder: (context, index){
                  return CategoryTile(image: categories[index].image, categoryName: categories[index].categoryName,);
                }),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Breaking News!', style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Breaking")));
                      },
                      child: Text('View all', style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16,decoration: TextDecoration.underline,
                      ),),
                    ),
                  ],
                ),
              ),
               const SizedBox(height: 30,),
              CarouselSlider.builder(itemCount: 5, itemBuilder: (context , index, realIndex){
                String? res = sliders[index].urlToImage;
                String? res1 = sliders[index].title;
                return buildImage(res!, index, res1!);
              }, options: CarouselOptions(height: 250,enlargeCenterPage: true,enlargeStrategy: CenterPageEnlargeStrategy.height, autoPlay: true,
              onPageChanged: (index , reason){
                setState(() {
                  activeIndex = index;
                  
                });
              }
              )),
              const SizedBox(height: 30,),
              Center(child: buildIndicator()),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trending News!', style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18
                    ),),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Trending")));
                      },
                      child: Text('View all', style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16, decoration: TextDecoration.underline,
                      ),),
                    ),
                  ],
                ),
              ),
             
                const SizedBox(height: 10,),
              SingleChildScrollView(
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,itemBuilder: (context, index){
                    return BlogTile(
                      url: articles[index].url!,
                      imageUrl: articles[index].urlToImage!, title: articles[index].title!, desc: articles[index].description!);
                  }),
                ),
              )
        
            ],
          ),
        ),
      ),
    );
  }
   Widget buildImage(String image , int index , String name)=>Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: Stack(
      children: [ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(imageUrl: image,height: 250, fit: BoxFit.cover, width: MediaQuery.of(context).size.width,)),
        Container(
          height: 250,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 170),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)
          
          )),
          child: Text(name ,maxLines: 2, style: TextStyle(color: Colors.white , fontSize: 20, fontWeight: FontWeight.w500),),

        )
   ] ),

     
  );
  Widget buildIndicator()=> AnimatedSmoothIndicator(activeIndex: activeIndex, count: 5, effect: SlideEffect(dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),);
}



class CategoryTile extends StatelessWidget {
  final image , categoryName;
  const CategoryTile({super.key, this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(image, width: 120, height: 70,fit: BoxFit.cover,)),
              Container(
                width: 120,
                height: 70,
              
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),  color: Colors.black38,),
                
                child: Center(child: Text(categoryName, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),),
              ),
              
          ],
        ),
      ),
    );
  }
 
}
class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile({required this.imageUrl, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(imageUrl: imageUrl, height: 120, width: 120,fit: BoxFit.cover,)),
                            ),
                            const SizedBox(width: 8,),
                           Column(
                             children: [
                               Container(
                                width: MediaQuery.of(context).size.width/2,
                                 child: Text(
                                  maxLines: 2,
                                  title, style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17
                                  ),),
                               ),
                               const SizedBox(height: 8,),
                               Container(
                                width: MediaQuery.of(context).size.width/2,
                                 child: Text(
                                  maxLines: 3,
                                  desc, style: TextStyle(
                                    color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15
                                  ),),
                               ),
                             ],
                           ),
                          ],
                        ),
                      ),
                    ),
                    ),
                ),
              )
        ;
  }
}