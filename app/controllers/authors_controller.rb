class AuthorsController < MainController

  def show
    @author = Author.friendly.find(params[:id])
    @articles = @author.articles.newest

    if @breadcrumbs.present?
      @breadcrumbs.extend_content.push Hashie::Mash.new({
        external_link: nil,
        path: send("#{I18n.locale}_author_path", @author),
        slug: @author.slug,
        title: @author.fullname
      })
    end

    @page.related_pages.en = en_author_path(@author)
    @page.related_pages.ru = ru_author_path(@author)
  end
end
