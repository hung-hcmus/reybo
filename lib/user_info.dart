class UserInformation {
  late String Id;
  late String Fullname;
  late String About;
  late String Aka;
  late String Image;
  late int Follower_count;
  late int Following_count;
  late int Works;

  UserInformation(String id, String name) {
    //TODO: retrieve data from firestore** change below
    this.Id = id;
    this.Fullname = name;
    this.About = "";
    this.Aka = "";
    this.Image =
        "https://images.squarespace-cdn.com/content/v1/54b7b93ce4b0a3e130d5d232/1519987020970-8IQ7F6Z61LLBCX85A65S/icon.png?format=1000w";
    this.Follower_count = 0;
    this.Following_count = 0;
    this.Works = 0;
  }
}
