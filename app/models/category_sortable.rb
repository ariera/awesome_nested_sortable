module CategorySortable
  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    def reorder(params)
      params=convert_url_params_to_hash(params)
      categories = Category.find(params.keys)
      ActiveRecord::Base.transaction do
        self.restructure_ancestry(categories, params)
        self.sort(categories, params)
      end
    end
  
    # converts a typical string of url params like this:
    #     "list[1]=root&list[7]=1&list[8]=1&list[2]=root&list[5]=2&list[6]=5"
    # into a nice hash like this:
    #     {1=>nil, 7=>1, 8=>1, 2=>nil, 5=>2, 6=>5}
    # notice that 'root' is substituted by nil and the numbers are integers and not strings
    #
    def convert_url_params_to_hash(params)
      params = Rack::Utils.parse_query(params)
      # in this point params looks like this:
      #     {"list[6]"=>"root", "list[8]"=>"6", "list[2]"=>"8", "list[5]"=>"2", "list[1]"=>"6", "list[7]"=>"1"}
      params.map do |k,v|
        cat_id = k.match(/\[(.*?)\]/)[1]
        parent_id = v=='root' ? nil : v.to_i
        {cat_id.to_i => parent_id}
      end.inject(&:merge)
    end
  
    def restructure_ancestry(categories, params)
      categories.each do |cat|
        cat.update_attributes({:parent_id => params[cat.id]})
      end
    end
  
    def sort(categories, params)
      hierarchy = convert_params_to_hierarchy(params)
      categories.each do |cat|
        cat.sort(hierarchy[cat.parent_id])
      end
    end
    
    def convert_params_to_hierarchy(params)
      params.hash_revert
    end
  end
  
  module InstanceMethods
    # sorts one node between its siblings accorrding to the 
    # ordered list of ids _ordered_siblings_ids_
    #
    def sort(ordered_siblings_ids)
      return if ordered_siblings_ids.length==1
      if ordered_siblings_ids.first == id
        move_to_left_of siblings.find(ordered_siblings_ids.second)
      else
        move_to_right_of siblings.find(ordered_siblings_ids[ordered_siblings_ids.index(id) - 1])
      end
    end
  end

end