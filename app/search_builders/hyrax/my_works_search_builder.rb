# Added to allow for the My controller to show only things I have edit access to
class Hyrax::MyWorksSearchBuilder < Hyrax::SearchBuilder
  include Hyrax::MySearchBuilderBehavior
  include Hyrax::FilterByType

  self.default_processor_chain += [:show_only_resources_deposited_by_current_user]

  def only_works?
    true
  end
end
