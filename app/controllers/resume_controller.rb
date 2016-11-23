class ResumeController < ApplicationController
    def home
        @resume = ResumeParse.new
    end
end
