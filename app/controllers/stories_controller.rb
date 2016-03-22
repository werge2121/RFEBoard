class StoriesController < ApplicationController
	before_action :find_story, only: [:show, :edit, :update, :destroy]

    def index
    	@stories = Story.all.order("created_at DESC")
        for story in @stories
            if(story.youtube.to_s != '')
                story.youtube = YouTubeAddy.youtube_embed_url(story.youtube, 420, 315).gsub! 'http', 'https'
            end
            if(story.vine.to_s != '')
                story.vine = '<iframe src="' + story.vine + '/embed/simple" width="600" height="600" frameborder="0"></iframe><script src="https://platform.vine.co/static/scripts/embed.js"></script>'
            end
        end
    end
    
    def show
        if @story.youtube.to_s != ''
            @story.youtube = YouTubeAddy.youtube_embed_url(@story.youtube, 840, 630).gsub! 'http', 'https'
        end
        if @story.vine.to_s != ''
            @story.vine = '<iframe src="' + @story.vine + '/embed/simple" width="600" height="600" frameborder="0"></iframe><script src="https://platform.vine.co/static/scripts/embed.js"></script>'
        end
    end
    
    def new
    	@story = current_user.stories.build
    end
    
    def create
    	@story = current_user.stories.build(story_params)

    	if @story.save
    		redirect_to @story, notice: "Succesfully created new Story"
    	else
    		render 'new'
    	end
    end
    
    def edit
    end

    def update
    	if @story.update(story_params)
    		redirect_to @story, notice: "Succesfully updated Story"
    	else
    		render 'edit'
    	end
    end

    def destroy
    	@story.destroy
    	redirect_to root_path
    end

    private

    def story_params
        params.require(:story).permit(:title, :youtube, :vine, :twitter, :description)
    end

    def find_story
    	@story = Story.find(params[:id])
    end

end
