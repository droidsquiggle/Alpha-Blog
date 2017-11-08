class ArticlesController < ApplicationController
  # since we removed the @article = Article.find(params[:id]) assignment from all actions and migratd it to a private method 
  # we need to tell the application to set the article before the action is taken but ONLY do this for specific methods
  # Always have the before_action in order of how you want them to execute
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  # controller for displaying ALL articles
  def index
    # take note variable name is now plural for we will be holding all articles in this object
    # this paginate function will load a default number of articles per page
    @articles = Article.paginate(page:params[:page], per_page: 5)
  end
  
  def new
    #this line is required for the new.html.erb form which uses the variable @article
    @article = Article.new
  end
  
  # define a function to show an article given an ID from the table
  def edit

  end
  
  # this function is required for the submit button on the new.html.erb form for creating a new entry into the database
  def create
    # when we hit this block of code from the create button we will get an error about not having an articles/create template
    # THIS IS OK as the object still gets created. To see this we add the line below to display the variables entered
    #render plain: params[:article].inspect
    
    # take the submitted variables and insert into table
    @article = Article.new(article_params)
    
    # before we get to this create action we know we have a current user because create requires user
    @article.user = current_user
    
    # if the article saved display a message to the screen and then redirect to article path
    if @article.save
      flash[:success] = 'Article successfully created'
    
      # function that will redirect the page so we dont land on an error for not having an article/create template
      redirect_to article_path(@article)
    else # the article did not save, there was an error for one reason or another
      # if the article doesnt save reload the 'new' page
      render 'new'
    end
  end
  
  # this function is required for the edit function to actually update the database with the edits
  def update
    # assign the to the @article object the article we are going to be updating

    
    # check if article can be successfully updated else redisplay edit page
    if @article.update(article_params) # update the given article with the given params from the form submission
      flash[:success] = 'Article successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  # define a function to show the article after successful save
  def show
    # assign the @article object the article located at the id given from the params arguments
    # need to create a view in articles for show in order for anything to happen at this point
   
  end

  # define a function to delete an article from the table
  def destroy
    
    @article.destroy
    flash[:danger] = 'Article successfully deleted'
    redirect_to articles_path
  end

  # define a private functions
  private 
    # reduce code reuse by putting @article = Article.find(params[:id]) code within a method
    def set_article
      @article = Article.find(params[:id]) 
    end
    
    # assign the article params to the article object
    def article_params
      # the top level key for params.require is :article... from here we are going to permit for the key that is article the values that are :title and :description
      params.require(:article).permit(:title, :description)
    end
  
    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You can only edit or delete your own article"
        redirect_to root_path
      end
    end
end