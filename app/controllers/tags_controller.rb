class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.order('title')
    @tag_groups = TagGroup.order('title')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new
    @tag_groups = TagGroup.order('title')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
    @tag_groups = TagGroup.order('title')
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])
    @tags = Tag.order('title')
    @tag_groups = TagGroup.order('title')

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_url, notice: 'Tag was successfully created.' }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])
    @tag_groups = TagGroup.order('title')

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to tags_url, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag_groups = TagGroup.order('title')
    tag_count = @tag.gallery_images.count

    if tag_count == 0
      @tag.destroy

      respond_to do |format|
        format.html { redirect_to tags_url, notice: 'Tag was removed.' }
        format.json { head :no_content }
      end
    else
      tag_count = view_context.pluralize(tag_count, 'image')
      respond_to do |format|
        format.html { redirect_to tags_url,
          notice: "Tag could not be reomved because it is being used by #{tag_count}" }
      end
    end
  end
end
