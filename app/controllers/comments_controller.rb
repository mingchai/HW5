class CommentsController < ApplicationController
    before_action :authenticated_user!
    def create
        # render json: params
        @comment = Comment.new comment_params
        @comment.user = current_user
        # each comment needs a user, so we need to specify this
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
        @comment = Comment.find params[:id]
        @comment.destroy
        redirect_to post_path(@comment.post)
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
end
