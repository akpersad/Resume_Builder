require 'open-uri'

class ResumeParse < ActiveRecord::Base
    def initialize
        @url = "https://crowded.com/samples/sample_resume.txt"
        @name_array = []
        @phone_array = []
        @email_array = []
        @objective_array = []
        @key_skills_array = []
        @employment_array = []
        @education_array = []
        text_to_string
    end

    def text_to_string
        counter = 0
        string = open(@url).read
        @string = string.split("\n")
        @string.delete("")
        @name_array << @string.shift
        @phone_array << @string.shift
        @email_array << @string.shift

        until @string[counter] == "KEY SKILLS"
            @objective_array << @string.shift
        end

        until @string[counter] == "EMPLOYMENT HISTORY"
            @key_skills_array << @string.shift
        end

        until @string[counter] == "EDUCATION"
            @employment_array << @string.shift
        end

        until @string.length == 0
            @education_array << @string.shift
        end
        # binding.pry
    end

    def name
        @name_array[0].split("Name:")[1][1..-2]
    end

    def phone
        @phone_array[0].split("Phone:")[1][1..-2]
    end

    def email
        @email_array[0].split("Email:")[1][1..-1]
    end

    def objective
        @objective_array
    end

    def key_skills
        @key_skills_array
    end

    def employment
        @employment_array
    end

    def education
        @education_array
    end
end
