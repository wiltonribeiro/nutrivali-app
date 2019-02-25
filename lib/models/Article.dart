class Article {

  String description, source, author, title, url, urlToImage, publishedAt, content;

  Article(this.description, this.source, this.author, this.title, this.url, this.urlToImage, this.publishedAt, this.content);

  Article.fromJson(Map<String, dynamic> json){
    this.description = json["description"];
    this.source = json["source"];
    this.author = json["author"];
    this.title = json["title"];
    this.url = json["url"];
    this.urlToImage = json["urlToImage"];
    this.publishedAt = json["publishedAt"];
    this.content = json["content"];
  }

  Map<String, dynamic> toJSON() => {
      //TODO
  };

}