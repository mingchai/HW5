class PostsController < ApplicationController
    def new
        @post = Post.new
    end

    def create
        @post = Post.new post_params
        if @post.save
            redirect_to posts_path
        else
            render :new
        end
    end

    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def show
        @post = Post.find params[:id]
        @comments = @post.comments.order(created_at: :desc) #loads only the comments associated to the post
        @comment = Comment.new
    end

    def edit
        @post = Post.find params[:id]
        #this part is required to fill in the form with existing info
    end

    def update
        @post = Post.find params[:id]
        if @post.update post_params
            #update with the parameters title and body, like express' {title, body} passed to knex
            redirect_to post_path
        else
            render :edit
        end
    end

    def destroy
        post = Post.find params[:id]
        post.destroy
        redirect_to posts_path
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

end
