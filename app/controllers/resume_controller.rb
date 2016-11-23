class ResumeController < ApplicationController
    def home
        @test = ResumeParse.new
    end
end
