class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
    @group = Group.find(params[:group_id])
    @categories = @group.categories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end
  
  # GET  /categories/reorder
  # POST /categories/reorder
  def reorder
    if request.get?
      @group = Group.find(params[:group_id])
      @categories = @group.categories
    elsif request.post?
      Category.reorder(params[:order])
      redirect_to group_path(:id => params[:group_id])
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new
    @category.group_id = params[:group_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path(:group_id => @category.group_id), notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_path(:group_id => @category.group_id), notice: 'Category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_path(:group_id => @category.group_id) }
      format.json { head :ok }
    end
  end
end
