// import 'package:flutter/material.dart';
// import '../../services/api_helper.dart';
// import 'detail_page.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController searchController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         top: true,
//         child: Column(
//           children: [
//             const SizedBox(height: 16,),
//             SizedBox(
//               height: 35,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconButton(onPressed: (){
//                     Navigator.pop(context);
//                   }, icon: const Icon(Icons.arrow_back)),
//                   Flexible(
//                     child: TextFormField(
//                       controller: searchController,
                      
//                       decoration:  const InputDecoration(
//                         fillColor: Colors.black12,
//                         filled: true,
//                         hintText: 'Search',
//                         contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(7.0)),
//                               borderSide:
//                                   BorderSide(color: Colors.blue, width: 2),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(7.0)),
//                               borderSide: BorderSide(color: Colors.green),
//                             ),
//                       ),
//                       textInputAction: TextInputAction.search,
//                       onChanged: (value) {
//                          value=searchController.text;
//                          setState(() {
                           
//                          });
//                       } 
//                     ),
//                   ),
//                   const SizedBox(width: 20,)
//                 ],
//               ),
//             ),
//             searchController.text==''? Expanded(child: Container(),):
//             Expanded(
//               child: Container(
//                 child: FutureBuilder(
//                 future: ApiHelper.queryData(searchController.text),
//                 builder: (context, snapshot) {
//                   print(snapshot.data);
//                   return snapshot.connectionState != ConnectionState.done
//                       ? const Center(
//                           child: SizedBox(
//                             width: 25,
//                             height: 25,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Color.fromARGB(255, 3, 85, 5),
//                             ),
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: snapshot.data!.products!.length,
//                           itemBuilder: (_, index) {
//                             return InkWell(
//                               onTap: () => Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                       builder: (builder) => DetailPage(
//                                           productt: snapshot.data!.products![index]))),
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 4, vertical: 8),
//                                 child: Card(
//                                   elevation: 7,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Image.network(
//                                         snapshot.data!.products![index].thumbnail,
//                                         width: double.infinity,
//                                         height: 200,
//                                         fit: BoxFit.fill,
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 8.0),
//                                         child: Text(
//                                           snapshot.data!.products![index].title,
//                                           style: const TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 8),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               '${snapshot.data!.products![index].price}',
//                                               style: const TextStyle(fontSize: 15),
//                                             ),
//                                             const Text(
//                                               ' USD',
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                           padding: const EdgeInsets.only(left: 8),
//                                           child: Text(snapshot
//                                               .data!.products![index].description)),
//                                       const SizedBox(
//                                         height: 10,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           });
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/product_provider.dart';
import 'detail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends ConsumerWidget {
   SearchPage({super.key});
  final TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context,ref) {
    final data=ref.watch(productProvider);
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            const SizedBox(height: 16,),
            SizedBox(
              height: 35,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back)),
                  Flexible(
                    child: TextFormField(
                      controller: searchController,
                      
                      decoration:   InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: AppLocalizations.of(context).search,
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        ref.read(productProvider.notifier).queryData(value);
                         value=searchController.text;
                      } 
                    ),
                  ),
                  const SizedBox(width: 20,)
                ],
              ),
            ),
            searchController.text==''? Expanded(child: Container(),):
            Expanded(
              child: Container(
                child: 
                ref.read(productProvider.notifier).productsModel==null
                      ? const Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color.fromARGB(255, 3, 85, 5),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: data.products!.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (builder) => DetailPage(
                                          productt: data.products![index]))),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                child: Card(
                                  elevation: 7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data.products![index].thumbnail,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          data.products![index].title,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${data.products![index].price}',
                                              style: const TextStyle(fontSize: 15),
                                            ),
                                            const Text(
                                              ' USD',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Text(
                                              data.products![index].description)),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
              ),
            ),
          ],
        ),
      ),
    );
  }
}