
import 'package:whisper/model/post_model.dart';

import '../../global/global.dart';

class GetMyPostRepo
{
  static Future<List<Post>>getMyPost() async
  {
    /// API end point will be added here and then calling of the post api to get all the post of the user
    /// Also It required User Id / token to access the post
    // Currently calling the dummy model
    return await generateDummyPosts();
  }

}