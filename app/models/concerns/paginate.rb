module Paginate
  extend ActiveSupport::Concern
  include Kaminari::PageScopeMethods

  included do
    scope :paginate, -> p, perpage { page(p[:page]).per(perpage) }
  end
end