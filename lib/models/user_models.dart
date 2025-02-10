

class UserModels {
  final String userId ;
  final String username ;
  final String email;
    UserModels(
        {
            required this.userId,required this.username,required this.email
        }
    );
    factory UserModels.fromJson(Map<String,dynamic> json){
      return UserModels(userId: json['_id'], username:json['name'] , email: json['email']);
    }
    factory UserModels.empty(){
      return UserModels(userId: '', username: '', email: '');
    }
      
    
      
    
}