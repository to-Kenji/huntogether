module DeviseHelper
  def bootstrap_alert(key)
    lists = {
      'notice' => 'info',
      'error' => 'danger',
      'alert' => 'danger'
    }
    lists[key]
  end
end
