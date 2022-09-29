module TasksHelper
  def status_value_options
    Task.statuses.map { |k, v| [Task.human_attribute_name([:status, k].join('.')), v] }
  end

  def status_key_options
    Task.statuses.map { |k, _v| [Task.human_attribute_name([:status, k].join('.')), k] }
  end

  def priority_key_options
    Task.priorities.map { |k, _v| [Task.human_attribute_name([:priority, k].join('.')), k] }
  end
end
