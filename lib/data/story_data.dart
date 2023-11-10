import 'package:bitfitx_project/data/models/story_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';

User user = User(
  uid: 'null',
  name: 'presence.fit',
  tokenValue: '',
  profileImageUrl:
      'http://m.gettywallpapers.com/wp-content/uploads/2021/03/Cool-HD-Wallpaper.jpg',
  coverImageUrl: 'null',
  email: 'null',
);

List<Story> stories = [
  Story(
    url:
        'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_1280.jpg',
    media: MediaType.image,
    user: user,
    duration: Duration(seconds: 5),
  ),

  Story(
    url:
        'https://firebasestorage.googleapis.com/v0/b/bitfitx-app.appspot.com/o/ahmed.jpg?alt=media&token=7d9d0589-9396-4524-b103-9f65323b7527',
    media: MediaType.image,
    duration: Duration(seconds: 5),
    user: user,
  ),

  // Story(
  //   url: 'assets/v3.mp4',
  //   media: MediaType.video,
  //   duration: Duration(seconds: 0),
  //   user: user,
  // ),
];
List<UserStoryList> storyListUser = [
  UserStoryList(
      user: User(
        uid: 'one thing',
        tokenValue: '',
        coverImageUrl: 'one thing',
        email: 'one thing',
        name: 'The Flutter Pro fit',
        profileImageUrl:
            'http://m.gettywallpapers.com/wp-content/uploads/2021/03/Cool-HD-Wallpaper.jpg',
      ),
      story: stories),
  UserStoryList(
      user: User(
        uid: 'one thing',
        tokenValue: '',
        coverImageUrl: 'one thing',
        email: 'one thing',
        name: 'The Flutter Pro fit 1',
        profileImageUrl:
            'https://firebasestorage.googleapis.com/v0/b/bitfitx-app.appspot.com/o/ahmed.jpg?alt=media&token=7d9d0589-9396-4524-b103-9f65323b7527',
      ),
      story: stories),
];

class UserStoryList {
  List<Story> story;
  User user;

  UserStoryList({required this.story, required this.user});
}
