module RIMA
  class Category
    attr_reader :parent, :name
    
    def initialize( name, parent = nil )
      @parent = parent
      @name = name.to_sym
    end
    
    def path
      @parent ? ( @parent.path + '/' + name.to_s ) : name.to_s
    end
    
    def root
      category = self
      while category.parent != nil
        category = category.parent
      end
      category.name
    end
    
    def to_s
      "#{path.inspect}"
    end
    
    def primary?
      root == :PRIMARY
    end
    
    def secondary?
      root == :SECONDARY
    end
    
    def emotions?
      root == :EMOTIONS
    end
    
  end
end
