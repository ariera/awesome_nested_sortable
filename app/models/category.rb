class Category < ActiveRecord::Base
  belongs_to :group
  acts_as_nested_set :scope => :group_id
  
  include CategorySortable
end
