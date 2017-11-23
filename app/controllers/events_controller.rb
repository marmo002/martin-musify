class EventsController < ApplicationController

  def index
    @events = Event.all

    if params[:search]
      @events = Event.search(params[:search]).order(created_at: :desc)
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
