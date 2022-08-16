class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_group

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    # post or comment selection
    post_params_with_necessary_id = 
      post_params[:post_id] ? post_params.except(:group_id) : post_params.merge(group_id: @group.id)

    post_params_with_necessary_id.merge!(author: current_user)

    @post = Post.new(post_params_with_necessary_id)

    respond_to do |format|
      if @post.save
        format.html { redirect_to group_post_url(@group, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }

        send_notifications(post_params[:post_id])
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to group_post_url(@group, @post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to group_posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def send_notifications(post_id)
      if post_id
        post = Post.find(post_id)
        
        if post.author != current_user

          action_text = post.group_id ? 'commented to your post' : 'replied to your comment'
          CommentsChannel.broadcast_to(post.author, "#{current_user.email} #{action_text}")

          action_method = post.group_id ? :your_post_is_commented : :your_comment_is_replied
          NotificationsMailer.send(action_method, post.author).deliver_later
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :group_id, :post_id)
    end
end
