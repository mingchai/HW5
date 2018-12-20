class CommentsController < ApplicationController
    def create
        # render json: params
        @comment = Comment.new comment_params
        @post = Post.find params[:post_id]
        # render json: params[:post_id]
        @comment.post = @post
        if @comment.save
            redirect_to post_path(@post.id)
        else
            render "posts/show"
        end
        @comment.save
    end

    def destroy
        @comment = Comment.find params[:post_id]
        @comment.destroy
        redirect_to post_path(@comment.post)
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
end
