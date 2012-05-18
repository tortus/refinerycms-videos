module Refinery
  module Videos
    class VideosController < ::ApplicationController

      before_filter :find_all_videos
      before_filter :find_page

      def index
        @featured_video = Video.featured
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @video in the line below:
        present(@page)
      end

      def show
        @video = Video.active.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @video in the line below:
        present(@video)
      end

    protected

      def find_all_videos
        @videos = Video.active.by_position
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/videos").first
      end

    end
  end
end
