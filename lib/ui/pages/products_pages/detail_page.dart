
import 'package:flutter/material.dart';

import '../../../model/product_model.dart';
import '../../widget/single_list_text.dart';

class DetailPage extends StatefulWidget {
  final Product productt;
  const DetailPage({super.key, required this.productt});

  @override
  State<DetailPage> createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage> {
  final PageController _pageController=PageController(viewportFraction: 0.9);
  
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.productt.title),
        backgroundColor: const Color.fromARGB(255, 3, 85, 5),
      ),
      body: Stack(
        children: [
           Container(
            height: size.height,
             decoration: const BoxDecoration(
              color: Colors.green
             ),
             child: Column(
              children: [
                Expanded(child: Container(color: Colors.cyan[100],
                
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: widget.productt.images.length,
                  itemBuilder: (_,index){
                  return Card(
                    color: Colors.green[100],
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: 
                    widget.productt.images.length<2?
                    Center(
                      child: SizedBox(
                        child: Image.network(widget.productt.images[index],fit: BoxFit.fill,)),
                    ):
                    SizedBox(
                      width: 300, 
                      child: Image.network(widget.productt.images[index],fit: BoxFit.fill,)),
                  );
                }),)),
                Expanded(child: Container(
                  
                )),
              ],
             ),
             
           ),
           Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 20),
                decoration:   BoxDecoration(
                 color: Colors.lime[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(),
                    SingleListText(text: widget.productt.title),
                    SingleListText(text: 'Brand- ${widget.productt.brand}'),
                    SingleListText(text: 'Category- ${widget.productt.category.toUpperCase()}'),
                    SingleListText(text: widget.productt.description),
                    SingleListText(text: 'Discount- ${widget.productt.discountPercentage} %'),
                    SingleListText(text: 'Price- ${widget.productt.price} \$'),
                    SingleListText(text: 'Rating- ${widget.productt.rating}'),
                    SingleListText(text: 'Stock- ${widget.productt.stock}'),
                    const SizedBox()
                  ],
                ),
                ),),

      ],)
    );
  }
}