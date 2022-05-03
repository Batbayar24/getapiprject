class Post{
  final int id;
  final String title;
  final String description;
  final String p_image;
  final int user_id;

  Post({required this.id, required this.title, required this.description, required this.p_image, required this.user_id});

  factory Post.fromJson(
    Map<String, dynamic> json){
    return Post(
    id: json['id'], 
    title: json['title'], 
    description: json['description'], 
    p_image: json['p_image'], 
    user_id: json['user_id']);
  }
}