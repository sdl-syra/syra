# Syra
====
Syra is a bartering website based on fictive money. 
Each new user get a little amount of point when the account is created.
Then users can "buy" services from others users with this money.
There is also a social network aspect with a profile to fill, a gamification system and so on.
Even if the application is finished, the site never went online.

## Table of contents

* [Technologies used](#technologies-used)
* [Samples of code](#samples-of-code)
  * [Ruby on Rails architecture](#ruby-on-rails-architecture)
  * [Facebook authentication](#facebook-authentication)
  * [Following system](#following-system)
  * [Account activation with a code](#account-activation-with-a-code)


## Technologies used
* Ruby On Rails
* HTML/CSS
* Bootstrap
* PostgreSQL
* JQuery

## Samples of code
In this part, I will describe (for you, visitor, and for the future me) which part of this project can illustrate classical
cases of development.
I will put sample of code that could be used and adapted for other projects. For more details about the fonctionalities described, it will be better to check the code

### Ruby on Rails architecture

RoR use the MVC architecture pattern. In this project, it is defined like this :
```
Syra/
├── app/ 
    ├── assets     font, images, js and css files
    ├── controllers   
    ├── helpers     code that will only contain logic for the view and not related to database should be here
    ├── mailers
    ├── models
    ├── views
```

RoR has a very active community, therefore there is a lot a "gem" that can be used to make your development easier.
You can add a gem into the gemfile then run the bundle install command to be able to use it.

### Facebook authentication

gemfile:
```ruby
gem 'omniauth'
gem 'omniauth-facebook'
```

Configuration:
```
Syra/config/initializers/omniauth.rb
```
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
   # provider :facebook, [APP ID], [SECRET KEY], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
   provider :facebook, "YOUR_APP_ID", "YOUR_SECRET_KEY" , :scope => 'email', :provider_ignores_state => true
  
end
```
Routing:
```
Syra/config/routes.rb
```
```ruby
 get '/auth/:provider/callback' => 'authentifications#create'
 ```
User model:
```ruby
  def apply_omniauth(auth)

    self.email = auth['extra']['raw_info']['email']
    self.name = auth['extra']['raw_info']['first_name']
    self.lastName = auth['extra']['raw_info']['last_name']
    self.avatar = auth[:info][:image] 
    self.save

    authentifications.build(:provider => auth['provider'], :uid => auth['uid'])
  end
  ```
### Following system
We implemented a following system Twitter-like.
We used association tools offered by RoR.

Models:
In first, there is the Relationship class which has 2 foreign keys toward the User table. From this table, we can get the follower of this user but also the people followed by this user.
```ruby
class Relationship < ActiveRecord::Base

  #attr_accessible :followed_id
  belongs_to :follower, :foreign_key => "follower_id", :class_name => "User"
  belongs_to :followed, :foreign_key => "followed_id", :class_name => "User"
  
  validates :followed_id, :presence => true
  validates :follower_id, :presence => true
end
```
In the User model, we are using the association of Active Record class.
There are 4 has_many relationships:
* relationships and reverse_relationships are used as linked between the user and the lists of following/followers
* following and followers use :through to perform a query through a join model. In this case, the join model can be relationships or reverse_relationship

There are 3 methods related to this social aspect:
* Follow someone
* Unfollow an user
* Get the the follower's list
```ruby
class User < ActiveRecord::Base
  has_many :relationships, :dependent => :destroy, :foreign_key => "follower_id"
  has_many :reverse_relationships, :dependent => :destroy, :foreign_key => "followed_id",:class_name => "Relationship"
  has_many :following, :through => :relationships, :source => :followed
  has_many :follower, :through => :reverse_relationships, :source => :follower
  
  # ...............
   def follow!(followed)
    rs = relationships.create!(:followed_id => followed)
    rs.favorite = false
    rs.save
  end
  
  def unfollow!(followed)
    relationships.where(:followed_id => followed).destroy_all
  end

  def followedBy?(follower)
    Relationship.find_by follower_id: follower, followed_id: self.id
  end

end
```
### Account activation with a code
It is common to ask the user to click on a link sent by email to confirm its inscription.
In the user controller, we use the UserMail in the Mailer folder to send a email.
```ruby
def create
    @user = User.new(user_params)
    @user.assign_attributes(address:Address.new, level:Level.new(levelUser:1, XPUser:0),
    isPremium:false, isBanned:false, confirmcode:UsersHelper.generate_code) # Code generation
    respond_to do |format|
      if @user.save
        UserMailer.send_code_confirmation(@user).deliver
        flash[:info] = "Veuillez consulter vos mails pour ainsi valider votre compte"
        format.html { redirect_to '/signin', notice: 'User was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
```

The code generation is pretty simple:
```ruby
def self.generate_code
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'
    code = ''
    32.times { code << chars[rand(chars.size)] }
    code
  end
  ```
  
Mailer method:
```ruby
def send_code_confirmation(user)
    @url = "http://localhost:3000/code/" + user.confirmcode
    #send email-> :to => user.email, :from => "noreply@yourcompany.com", :subject =>"Confirmation registration"
  end
```

According to routes.rb
```ruby
 get "code/:id", :to => 'users#unlock_user'
```
Again, controller method :
```ruby
def unlock_user
  @newuser = User.where(confirmcode:params[:id]).first
  unless @newuser.nil?
    @newuser.update_attribute(:confirmcode, nil)
    flash[:info] = "Votre compte est désormais activé !"
  end
  redirect_to signin_path
end
  ```
