class TaskObserver < ActiveRecord::Observer
  def before_create(task)
    task.elapsed_time_in_seconds = task.calculate_elapsed_time
  end
  
  def before_save(task)
    task.elapsed_time_in_seconds = task.calculate_elapsed_time
    task.not_tagged = true unless task.tagged?
  end
end
