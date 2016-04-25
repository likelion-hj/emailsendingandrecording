require 'mailgun'
class HomeController < ApplicationController
  def index
  end
  
  def write
        @title = params[:title]
        @content = params[:content]
        @email2 = params[:email2]
        
        new_post = Post.new
        new_post.title = @title
        new_post.content = @content
        new_post.save
         redirect_to "/list"
        
        mg_client = Mailgun::Client.new("key-f88e254be4c1906feda6fa0fc8d7dd0f")

        message_params =  {
                   from: 'master@likelion.net',
                   to:   @email2,
                   subject: @title,
                   text:    @content
                  }

        result = mg_client.send_message('sandboxe512645158f1497eaa12cb9e6bb2a7d9.mailgun.org', message_params).to_h!

        message_id = result['id']
        message = result['message']
  end
    
  def list
     @every_post = Post.all.order("id desc")
  end
  
  def destroy
    @one_post = Post.find(params[:post_id])
    @one_post.destroy
    redirect_to "/list"
  end
    
end
