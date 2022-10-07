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

  def tags_options
    Tag.all.map { |tag| [tag.name, tag.id] }
  end

  def order_options
    [
      [I18n.t("order_options.priority_desc"), "priority desc"],
      [I18n.t("order_options.priority_asc"), "priority asc"],
      [I18n.t("order_options.end_time_desc"), "end_time desc"],
      [I18n.t("order_options.end_time_asc"), "end_time asc"]
    ]
  end

  def task_priority(task)
    Task.human_attribute_name [:priority, task.priority].join(".")
  end

  def task_status(task)
    Task.human_attribute_name [:status, task.status].join(".")
  end
end
