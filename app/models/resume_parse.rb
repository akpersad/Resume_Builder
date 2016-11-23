require 'open-uri'

class ResumeParse < ActiveRecord::Base
    def initialize
        @url = "https://crowded.com/samples/sample_resume.txt"
    end

    def text_to_string
        string = open(@url).read
        # binding.pry
    end
end
