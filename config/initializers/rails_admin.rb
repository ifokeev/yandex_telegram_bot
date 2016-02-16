RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.included_models = %w[Product Image Order ActsAsTaggableOn::Tag]

  config.model Image do
    edit do
      field :file, :refile
    end
  end

  config.model Product do
    configure :base_tags do
      visible false
    end

    show do 
      configure :color_list do
        visible false
      end

      configure :category_list do
        visible false
      end
    end

    edit do
      configure :colors do
        visible false
      end

      configure :categories do
        visible false
      end

      fields_of_type :tag_list do
        partial 'tag_list_with_autocomplete'

        # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
        ratl_max_suggestions -1
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
