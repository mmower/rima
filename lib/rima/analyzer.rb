require 'rima/dictionary'

module RIMA
  class Analyzer
    
    def self.restore( state_file )
      File.open( File.expand_path( state_file ) ) do |file|
        Marshal.restore( file )
      end
    end
    
    def initialize( category_file, exceptions_file = nil )
      @dictionary = Dictionary.new
      @dictionary.load_categories( category_file )
      @dictionary.load_exceptions( exceptions_file ) unless exceptions_file.nil?
    end
    
    def store( state_file )
      File.open( File.expand_path( state_file ), "w" ) do |file|
        Marshal.dump( self, file )
      end
      self
    end
    
    def analyze( text )
      results = {
        :word_count => 0,
        :word_total => 0,
        :scores => Hash.new { 0 }
      }
      
      text.scan( /\w+/ ) do |word|
        category = @dictionary.find( word.gsub( /[^\w-]/, "" ) )
        results[:word_total] += 1
        unless category.nil?
          results[:word_count] += 1
          results[:scores][category] = results[:scores][category] + 1
        end
      end
      
      results[:sorted_scores] = results[:scores].to_a.sort_by { |result| -result[1] }
      results[:classes] = {
        :primary => Float(results[:sorted_scores].select { |result| result[0].primary? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count],
        :secondary => Float(results[:sorted_scores].select { |result| result[0].secondary? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count],
        :emotions => Float(results[:sorted_scores].select { |result| result[0].emotions? }.inject( 0 ) { |count,result| count + result[1] }) / results[:word_count]
      }
      
      results
    end
    
  end
end