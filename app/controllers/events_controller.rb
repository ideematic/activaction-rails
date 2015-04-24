class EventsController < ApplicationController
  def index
    @search = params[:search].andand.strip
    @events = Event.distinct.
      joins('LEFT JOIN "event_skills" ON "event_skills"."event_id" = "events"."id"').
      joins('LEFT JOIN "skills" ON "skills"."id" = "event_skills"."skill_id"').
      joins('LEFT JOIN "event_tags" ON "event_tags"."event_id" = "events"."id"').
      joins('LEFT JOIN "tags" ON "tags"."id" = "event_tags"."tag_id"')
    wheres = []
    if !@search.blank?
      wheres << "events.name ilike '%#{@search}%' or events.description ilike '%#{@search}%'"
    end
    if !@search.blank?
      wheres << "tags.name ilike '%#{@search}%' or skills.name ilike '%#{@search}%'"
    end

    @events_past_count =  @events.past.limit(10).
        where(wheres.compact.join(' OR ')).
        count

    @category = Category.distinct

    @current_user_activacteur = current_user && current_user.is_activacteur

    @event_future_count = @events.future.
      where(wheres.compact.join(' OR ')).
      count
    @events = @events.
      where(wheres.compact.join(' OR ')).
      order('created_at DESC').page(params[:page]).per(12)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    @event = Event.includes(:category, :user, :tags, :skills, :attendances, :attending_users, :comments).
      find(params[:id])
    @attendance = current_user && current_user.attendance_for(@event)
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
    @event = Event.new(parse_event_params event_params)
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
      if @event.update_attributes(parse_event_params event_params)
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
  def parse_event_params(event_params)
    event_params[:date] = '%s %s' % [event_params[:date].andand.split('/').reverse.join('-'),
                                     event_params[:hour].andand.sub('h', ':')]
    event_params.delete :hour
    event_params[:tags] = event_params[:tags].split(';').map { |t| Tag.where(name: t).first_or_create }
    event_params[:skills] = event_params[:skills].split(';').map { |s| Skill.where(name: s).first_or_create }
    event_params
  end

  def event_params
    params.require(:event).permit(:user_id,
                                  :name,
                                  :date,
                                  :hour,
                                  :description,
                                  :picture,
                                  :category_id,
                                  :tags,
                                  :skills,
                                  :spots,
                                  :address,
                                  :latitude,
                                  :longitude)

  end
end
