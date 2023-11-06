import 'package:flutter/material.dart';
import 'package:whisper/components/utility_helper.dart';
import 'package:whisper/global/global.dart';
import 'package:whisper/utils/app_helper/app_color.dart';
import 'package:whisper/utils/app_helper/app_style.dart';
import 'package:whisper/utils/routes/route_name.dart';
import '../../../model/my_profile_api_response.dart';
import '../../../model/user_profile_response.dart';
import '../../../utils/app_helper/app_keys.dart';

class PostList extends StatefulWidget {
  const PostList({super.key, required this.postList});
  // final List<ApiResponseMyProfileUserPost> postList;
  // final List<ApiResponseUserDataModel> postList;
  final List<ApiResponseMyProfileUserPost> postList;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint(
        "#####################${widget.postList.length}###################################");
    // return Container(
    //   child: Text("Data Found ${widget.postList.length}"),
    // );
    return GridView.builder(
      key: const PageStorageKey<String>(StoragePathKey.postListPath),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0, // Add spacing as needed.
        mainAxisSpacing: 2.0, // Add spacing as needed.
      ),
      itemCount: widget.postList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, RouteName.postDetailsView, arguments: {'postId':widget.postList[index].id, 'isLiked' : true});
            },
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 204, 199, 199),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          AspectRatio(aspectRatio: 1, child: UtilityHelper.image(widget.postList[index].url, fit: BoxFit.fill, )),
                          Align(alignment: Alignment.bottomCenter,child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.thumb_up_alt_outlined, color: AppColors.white,),
                                  Text(
                                    widget.postList[index].likeCount.toString(),
                                    style: AppStyle.whiteMedium16,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.comment, color: AppColors.white,),
                                  Text(widget.postList[index].commentCount.toString(), style: AppStyle.whiteMedium16,
                                  ),
                                ],
                              ),
                            ],
                          ),)
                        ],
                      )),
                  ),
                ),
                sizedBox(hei: 3),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
