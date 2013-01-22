module RIMA
  class SearchTree
    OFFSET = 'a'[0].freeze
    
    attr_accessor :value
    
    # 0 -> *
    # 1 -> -
    # 2 -> a
    # 27 -> z
    def initialize
      @subtrees = Array.new( 28, nil )
      @value = nil
    end
    
    def insert( s, value )
      priv_insert( s.split( '' ), value )
    end
    
    def find( s )
      priv_find( s.split( '' ) )
    end
    
  protected
    def key( chr )
      if chr == '*'
        0
      elsif chr == '-'
        1
      else
        rval = chr.downcase[0] - OFFSET + 2
        
        if rval < 2 || rval > 27
          rval = -1 # invalid character
        end
        
        rval
        
      end
    end
    
    def priv_insert( s, value )
      if s.empty?
        @value = value
      else
        index = key( s.first )
        subtree = if @subtrees[index] == nil
          @subtrees[index] = SearchTree.new
        else
          @subtrees[index]
        end
        
        subtree.priv_insert( s.tail, value )
      end
    end
    
    def priv_find( search )
      if @subtrees[0]
        @subtrees[0].value
      else
        if search.empty?
          value
        else
          index = key( search.first )
          if @subtrees[index]
            @subtrees[index].priv_find( search.tail )
          else
            nil
          end
        end
      end
    end
  end
end