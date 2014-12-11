class EventsController < ApplicationController
  def index
    @events = Event.order('created_at DESC').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    @event = Event.includes(:category, :user, :tags, :attendances, :attending_users, :comments).
      find(params[:id])
    if request.path != event_path(@event)
      redirect_to @event, status: :moved_permanently
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'L\'évènement a été crée.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to @event, notice: 'L\'évènement a été mis à jour.' }
        format.json { head :no_content }
        format.js {}
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def form
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  private
  def event_params
    params[:event][:date] = '%s %s' % [params[:event][:date].split('/').reverse.join('-'),
                                       params[:event][:hour].sub('h', ':')]
    params[:event].delete :hour
    params.require(:event).permit(:user_id,
                                  :name,
                                  :date,
                                  :hour,
                                  :description,
                                  :picture,
                                  :category_id,
                                  :tags)
  end
end
