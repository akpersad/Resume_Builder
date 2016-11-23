class ResumeController < ApplicationController
    def home
    end

    def resume
        @resume = ResumeParse.new(params['link'])
    end
end
