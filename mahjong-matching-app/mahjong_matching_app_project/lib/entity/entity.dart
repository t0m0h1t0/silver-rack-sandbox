// this entity represents the schema of user profile.
class UserProfileEntity {
    final String gmail_address;
    final String user_name;
    final String user_age;
    final String user_sex;
    final String user_lineid;

    UserProfileEntity(
        this.gmail_address,
        this.user_name,
        this.user_age,
        this.user_sex
        this.user_lineid
    );

    UserProfileEntity.fromJson(Map<String, dynamic> json)
        : gmail_address = json['gmail_address'] as String,
          user_name = json['user_name'] as String,
          user_age = json['user_age'] as String,
          user_sex = json['user_sex'] as String;
          user_lineid = json['user_lineid'] as String;

    Map<String, dynamic> toJson() => {
        'gmail_address': gmail_address,
        'user_name': user_name,
        'user_age': user_age,
        'user_sex': user_sex,
        'user_lineid': user_lineid,
    };
}
