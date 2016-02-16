class ApplicationSerializer < ActiveModel::Serializer
  # Mix in route helpers, so that we can include links
  # to other API endpoints, should we need to.
  #include Rails.application.routes.url_helpers

  #embed :ids

  # def created_at
  #   object.created_at.utc.iso8601
  # end
  #
  # def updated_at
  #   object.updated_at.utc.iso8601
  # end
end
