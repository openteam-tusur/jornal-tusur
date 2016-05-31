angular.module('article_form')
  .factory('article_authors', [
    '$http',
    ($http) ->

      o = {
        authors: []
      }

      o.removeAuthor = (author) ->
        i = o.author_ids().indexOf(author.id)
        o.authors.splice(i, 1)
        o.commitAuthors()
  ])
