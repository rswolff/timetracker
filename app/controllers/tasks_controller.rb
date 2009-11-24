class TasksController < ApplicationController
  
  before_filter :login_required
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = current_user.todays_tasks

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = current_user.tasks.find(:params[:id])
  rescue
    flash[:warning] = "You are not permitted to see this page."
    redirect_to new_task_path
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new
    @task.start = Time.zone.now
    @task.end_session = false
    @task.notes = nil if @task.notes

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = current_user.tasks.build(params[:task])
    @task.stop = DateTime.now
    @task.elapsed_time_in_seconds = @task.stop - @task.start
    
    #scan for #hashtags
    tags = @task.notes.scan(/(?:\s|\A)[##]+([\w_]+)/)
    @task.tag_list = tags
    
    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html {
          if @task.end_session == 'true'
            redirect_to(@task)
          else
            redirect_to :action => "new"
          end  
        }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
