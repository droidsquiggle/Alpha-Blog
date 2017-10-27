class ArticlesController < ApplicationController
  
  def new
    #this line is required for the new.html.erb form which uses the variable @article
    @article = Article.new
  end
  
  #this function is required for the submit button on the new.html.erb form for creating a new entry into the database
  def create
    # when we hit this block of code from the create button we will get an error about not having an articles/create template
    # THIS IS OK as the object still gets created. To see this we add the line below to display the variables entered
    #render plain: params[:article].inspect
    
    # take the submitted variables and insert into table
    @article = Article.new(article_params)
    @article.save
    
    # function that will show display the article.
    redirect_to_articles_show(@article)

  end
  
  # define a private function which will assign the article params to the article table object
  def article_params
    # the top level key for params.require is :article... from here we are going to permit for the key that is article the values that are :title and :description
    params.require(:article).permit(:title, :description)
  end
end