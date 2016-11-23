require 'open-uri'

class ResumeParse < ActiveRecord::Base
    def initialize(link)
        @url = link
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
        @objective_array[1][0..-1]
    end

    def key_skills
        @key_skills_array[1..-1]
    end

    def employment
        formatted_array = []
        @employment_array.shift
        @employment_array = @employment_array.chunk { |i| i[0..5] == "Title:" }.to_a.map { |_, v| v }
        counter = @employment_array.length
        amount = counter / 2

        amount.times do |x|
            @employment_array[counter-2].push(*@employment_array[counter-1])
            counter -= 2
        end

        @employment_array.each_with_index do |item, index|
            if index %2 == 0
                formatted_array.push(item)
            end
        end

        formatted_array.each do |job|
            3.times do |number|
                job[number-1].gsub!(/(.+?):/, "")
            end
        end

        formatted_array
    end

    def education
        @education_array.shift
        @education_array.each do |element|
            element.gsub!(/(.+?):/, "")
        end
        @education_array
    end
end
