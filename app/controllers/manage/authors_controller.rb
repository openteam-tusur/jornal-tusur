class Manage::AuthorsController < Manage::ApplicationController

  def search
    results = Author.search {
      fulltext params[:q]
      without :id, params[:author_ids] if params[:author_ids]
    }.results

    render json: results.to_json
  end

end
